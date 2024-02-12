class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :work_experiences, dependent: :destroy
  has_many :connections, dependent: :destroy

  PROFILE_TITLE = [
    'Senior Ruby on Rails Developer',
    'Full Stack Ruby on Rails Developer',
    'Senior Full Stack Ruby on Rails Developer',
    'Junior Full Stack Ruby on Rails Developer',
    'Senior Javascript Developer',
    'Senior Frontend Developer',
    ].freeze
    
  def name
    "#{first_name} #{last_name}".strip
  end

  def address
    "#{city}, #{state}, #{country}, #{pincode}"
  end
  

  def self.ransackable_attributes(auth_object = nil)
    ["country", "city"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def my_connection user
    Connection.where("(user_id = ? AND connected_user_id = ?)
                        OR (user_id = ? AND connected_user_id = ?)",
                        self.id, user.id, user.id, self.id)
  end

  def check_if_already_connected? user
    self != user && !my_connection(user).present?
  end

  def mutually_connected_ids user
    self.connected_user_ids.intersection user.connected_user_ids
  end
  
end
