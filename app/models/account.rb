class Account < ApplicationRecord
  validates :name, :password, :birthday, presence: true
  validates :name, uniqueness: true
  validates :name, length: {in: 2..20, message: "は2〜20文字にしてください"}
  validates :password, presence: true, confirmation: true
  validate :encrypt_password
  has_many :posts
  has_many :tokens, dependent: :destroy
  has_many :locations, dependent: :destroy

  def encrypt_password
    self.password = BCrypt::Password.create(self.password)
  end

  class << self
    def authenticate(name, password)
      acc = Account.find_by(name: name)
      acc if acc && BCrypt::Password.new(acc.password) == password
    end
  end
end
