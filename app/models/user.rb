class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :buses, foreign_key: 'bus_owner_id', class_name: 'Bus', dependent: :destroy
  
  has_many :reservations, foreign_key: 'user_id', class_name: 'Reservation', dependent: :destroy



  enum user_type: { bus_owner: 'bus_owner', customer: 'customer'}
  validates :name, :email,:mobile_no, presence: true
  validates :mobile_no, numericality: true
  validate :validate_mobile_no_length, if: :mobile_no?
  validates :name, format: { with: /\A[a-zA-Z]+\z/, message: "should only contain letters" }, if: :name?

  def has_user_type?(require_type)
    self.user_type == require_type
  end

  private
  def validate_mobile_no_length
    unless mobile_no.to_s.length == 10
      errors.add(:mobile_no, 'must have exactly 10 digits')
    end
  end
end
