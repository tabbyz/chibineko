FactoryGirl.define do
  factory :test do
    sequence(:title) { |n| "test_title_#{n}" }
  end
end
