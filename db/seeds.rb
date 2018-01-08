if Rails.env.development?
  Vacation.destroy_all
  User.destroy_all
  
  User.create(email: "one@test.com", password: "111222", password_confirmation: "111222")
  User.create(email: "two@test.com", password: "111222", password_confirmation: "111222")
  User.create(email: "three@test.com", password: "111222", password_confirmation: "111222")

  
end