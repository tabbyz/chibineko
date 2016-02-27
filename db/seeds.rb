user = User.create(email: "test@example.com", password: "1234")
user.skip_confirmation!
user.save