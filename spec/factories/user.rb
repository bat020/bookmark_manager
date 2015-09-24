FactoryGirl.define do

  factory :user do # FactoryGirl will assume that the parent model of a factory named ":user" is "User".
    email 'alice@example.com'
    password 'oranges'
    password_confirmation 'oranges'
  end

end
