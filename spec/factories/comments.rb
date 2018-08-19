FactoryBot.define do
  factory :comment do
    content 'xD'
    user_id 1
    post_id 1
  end

  factory :comment2, class: Comment do
    content 'lol'
    user_id 2
    post_id 1
  end
end
