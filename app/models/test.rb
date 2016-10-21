class Test < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :testcases, dependent: :destroy
  has_many :testresults, dependent: :destroy
  after_initialize :set_slug
  serialize :result_labels
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 4096 }
  default_scope { order("id ASC") }
  attr_accessor :markdown, :source

  def to_param
    slug
  end

  def authorized?(user)
    if project = self.project
      project.team.authorized?(user)
    else
      true
    end
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

  def test_environments
    environments = [ "mac", "win" ]
    environments
  end

  def test_environment_texts
    test_environments_or_default.keys
  end
  def test_environment_colors
    test_environments_or_default.values
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

  def testresult_groups(testcase_id)
    self.testresults.select {|tr| tr.testcase_id == testcase_id} 
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
        buff = "[#{t.body}]"
        if with_result
          self.testresult_groups(t.id).each do |tr|
            if tr.result && tr.result != self.result_label_texts.first
              buff += ", <#{tr.result}>"
              unless tr.note.blank?
                buff += ", {#{tr.note}}"
              end
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
    self.testresults.delete_all

    self.markdown.each_line do |line|
      level  = Testcase.heading_level(line)
      body   = Testcase.body(line)
      results = Testresult.result(line)
      notes = Testresult.note(line)

      self.testcases.create(heading_level: level, body: body)
      self.test_environments.each do |env|
        result = results.empty? ? nil : results.shift
        note = notes.empty? ? nil : notes.shift
        self.testresults.create(heading_level: level, result: result, note: note, testcase_id: self.testcases.last.id, environment: env)
      end
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
