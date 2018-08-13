FactoryBot.define do
  factory :post do
    title "Top 10 ruby methods"
    content "i want to find a job"
  end
  factory :first_post, class: Post do
    title "one is the zero"
    content "common knowlege for any programmer"
  end
end
