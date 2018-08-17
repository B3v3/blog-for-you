FactoryBot.define do
  factory :user do
    nickname 'D3v3'
    email 'boksa.dawid@interia.pl'
    password 'passwordtest'
    password_confirmation 'passwordtest'
  end

  factory :user2, class: User do
    nickname 'randomname'
    email 'remaill@mo.pk'
    password 'randompassword'
    password_confirmation 'randompassword'
  end
end
