# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Admin User'
    email 'moncef@example.com'
    password 'mong01dtest'
    password_confirmation 'mong01dtest'
    role "admin"
    # required if the Devise Confirmable module is used
    confirmed_at Time.now
  end

  factory :unconfirmed_user, :class => :user do
    name 'Unconfirmed User'
    email 'invalid@example.com'
    password 'mong01dtest'
    password_confirmation 'mong01dtest'
  end
end
