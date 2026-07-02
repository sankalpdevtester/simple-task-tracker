class AuthenticationService
  def self.authenticate(email, password)
    user = User.find_by(email: email)
    return false unless user
    user.authenticate(password)
  end

  def self.login(user)
    session = Session.new(user_id: user.id, token: Session.generate_token)
    session.save!
    session.token
  end

  def self.logout(token)
    session = Session.find_by(token: token)
    session.destroy if session
  end
end