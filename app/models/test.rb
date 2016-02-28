class Test < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :testcases, dependent: :destroy
  after_initialize :set_slug
  serialize :result_labels
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 4096 }
  attr_accessor :markdown, :source
  default_scope { order("updated_at DESC") }

  def to_param
    slug
  end

  def result_labels_or_default
    labels = I18n.t("tests.result_labels")
    result_labels || {
      labels[:unexecuted] => "white",
      labels[:pass] => "green",
      labels[:fail] => "red",
      labels[:blocked] => "orange",
      labels[:na] => "gray",
    }
  end

  def result_label_texts
    result_labels_or_default.keys
  end

  def result_label_colors
    result_labels_or_default.values
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
          if t.result && t.result != self.result_label_texts.first
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

    self.markdown.each_line do |line|
      level  = Testcase.heading_level(line)
      body   = Testcase.body(line)
      result = Testcase.result(line)
      note   = Testcase.note(line)
      self.testcases.create(heading_level: level, body: body, result: result, note: note)
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
