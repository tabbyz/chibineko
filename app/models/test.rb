class Test < ActiveRecord::Base
  belongs_to :project
  after_initialize :set_slug
  attr_accessor :markdown

  def to_param
    slug
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
