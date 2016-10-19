class TestResult < ActiveRecord::Base
  belongs_to :testcase
  validates :result, length: { maximum: 255 }
  validates :note, length: { maximum: 1024 }
  validates :environment, length: { maximum: 256 }

  def result
    super || self.testcase.test.result_label_texts.first  # Default value
  end

  def result_color
    self.testcase.test.result_labels_or_default[self.result] || "white"  # Default value
  end

  class << self
    def result(text)
      text.try(:strip!)
      return nil if text.blank?

      text =~ /,(?:\s)?\[(.*)\]/
      result = $1
    end

    def note(text)
      text.try(:strip!)
      return nil if text.blank?

      text =~ /,(?:\s)?\[(?:.*)\],(.*)/
      note = $1
      note.strip if note
    end
  end

end
