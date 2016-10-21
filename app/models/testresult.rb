class Testresult < ActiveRecord::Base
  belongs_to :test
  validates :result, length: { maximum: 255 }
  validates :note, length: { maximum: 1024 }
  validates :environment, length: { maximum: 255 }
  default_scope { order("id ASC") }

  def environment
    self.environment = "default"
  end

  def result
    super || self.test.result_label_texts.first  # Default value
  end
  
  def result_color
    self.test.result_labels_or_default[self.result] || "white"  # Default value
  end

  class << self
    def result(text)
      text.try(:strip!)
      return nil if text.blank?

      #text =~ /,(?:\s)?<<(.*)>>/
      #result = $1
      #results = text.scan(/<<[^<|>]*>>/).delete("<>")
      text.scan(/<[^<>]*>/).map { |item| item.delete("<>") }
    end

    def note(text)
      text.try(:strip!)
      return nil if text.blank?

      #text =~ /,(?:\s)?<<(?:.*)>>,(.*)/
      #note = $1
      text.scan(/{[^{}]}/).map { |item| item.delete("{}") }
    end
  end

end
