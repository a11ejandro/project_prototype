FactoryGirl.define do
  factory :user do
    email do
      counter = 0
      while User.find_by(email: "user#{counter}@example.com")
        counter += 1
      end

      "user#{counter}@example.com"
    end

    first_name Faker::Name.first_name
    last_name  Faker::Name.last_name
    password 'password'
    role REGULAR_USER

    trait :admin do
      email do
        counter = 0
        while User.find_by(email: "admin#{counter}@example.com")
          counter += 1
        end

        "admin#{counter}@example.com"
      end

      first_name 'Admin'
      last_name 'Example'
      role ADMIN
    end
  end
end
