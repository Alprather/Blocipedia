class User < ActiveRecord::Base
  attr_accessor :login
  attr_writer :login
  has_many :wikis
  has_many :charges
  has_many :collaborators
  has_many :wikis, through: :collaborators
  enum role: [:basic, :admin, :premium]
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :basic
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         authentication_keys: [:login]
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, multiline: true

  def login
    @login || username || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions.key?(:username) || conditions.key?(:email)
      where(conditions.to_hash).first
    end
  end


end
