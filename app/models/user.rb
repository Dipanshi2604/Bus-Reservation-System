class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :buses, foreign_key: 'bus_owner_id', class_name: 'Bus', dependent: :destroy
  
  has_many :reservations, foreign_key: 'user_id', class_name: 'Reservation', dependent: :destroy



  enum user_type: { bus_owner: 'bus_owner', customer: 'customer'}


  def has_user_type?(require_type)
    self.user_type == require_type
  end
end
