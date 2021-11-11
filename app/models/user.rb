class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github twitter]

  validates :username, presence: true, uniqueness: true

  enum role: { contributor: 0, admin: 1 }

  has_many :critics, dependent: :destroy
  has_many :authentications, dependent: :destroy

  def self.from_omniauth(auth)
    authentication = Authentication.find_or_initialize_by(provider: auth.provider, uid: auth.uid)

    unless authentication.persisted?
      user = find_or_create_by(email: auth.info.email) do |new_user|
        new_user.username = auth.info.nickname
        new_user.password = Devise.friendly_token[0, 20]
      end

      authentication.user = user
      authentication.save if user.persisted?
    end

    authentication.user
  end
end
