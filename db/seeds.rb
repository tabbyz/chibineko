user = User.create(email: "test@example.com", password: "test")
user.skip_confirmation!
user.save