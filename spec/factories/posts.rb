FactoryBot.define do
  factory :post do
    title "Top 10 ruby methods"
    content "i want to find a job"
    user_id '1'
  end
  factory :first_post, class: Post do
    title "one is the zero"
    content "common knowlege for any programmer"
    user_id '1'
  end
end
