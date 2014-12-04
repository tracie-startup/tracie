class BetaRequest < ActiveRecord::Base
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def create_user
    #Create User with random unknown password:
    password = (0...25).map { ('a'..'z').to_a[rand(26)] }.join
    user = User.new
    user.email = self.email
    user.password = password
    user.password_confirmation = password
    user.skip_confirmation!
    if user.save
      return user
    else
      return false
    end
  end

  def invite_to_beta
    unless invited_at
      self.update_attribute(:invited_at, Time.now)

      user = create_user()

      if user
        UserMailer.beta_invite(user).deliver
      end
    end
  end
end
