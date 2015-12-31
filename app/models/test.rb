class Test < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :testcases, dependent: :destroy
  after_initialize :set_slug
  attr_accessor :markdown

  def to_param
    slug
  end

  # def description_format
  #   self.description.gsub(/\n/, "<br>")
  # end

  def results
    # TODO: From DB
    {
      "未実行" => "white",
      "OK" => "green",
      "NG" => "red",
      "保留" => "orange",
      "対象外" => "gray",
    }
  end

  def result_labels
    results.keys
  end

  def result_colors
    results.values
  end

  def testcase_groups
    groups = []
    buff = []

    testcases = self.testcases
    testcases.each_with_index do |c, i|
      buff << c
      if testcases[i + 1].try(:heading_level) == 1
        groups << buff
        buff = []
      end
    end
    groups << buff if buff.size
    groups
  end

  def set_markdown(with_result = false)
    array = []
    self.testcases.each do |t|
      buff = nil
      case t.type
      when :blank
        buff = ""
      when :heading
        buff = ("#" * t.heading_level) + " " + t.body
      when :testcase
        buff = t.body
        if with_result
          if t.result && t.result != self.result_labels.first
            buff += ", [#{t.result}]"
            unless t.note.blank?
              buff += ", #{t.note}"
            end
          end
        end
      end
      array << buff
    end
    self.markdown = array.join("\n")
  end

  def make_testcase
    self.testcases.delete_all

    case_id = 0
    self.markdown.each_line do |line|
      level  = Testcase.heading_level(line)
      body   = Testcase.body(line)
      result = Testcase.result(line)
      note   = Testcase.note(line)
      case_id += 1 if level == 0
      self.testcases.create(case_id: case_id, heading_level: level, body: body, result: result, note: note)
    end
  end

  class << self
    def find_by_user(user)
      user.tests  # TODO: Also an authorized test
    end
  end

  private
    def set_slug
      self.slug = self.slug.blank? ? generate_slug : self.slug
    end

    def generate_slug
      token = SecureRandom.urlsafe_base64
      self.class.where(slug: token).blank? ? token : generate_slug
    end
end
