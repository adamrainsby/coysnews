class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :predictions

  validates :username, presence: true
  validates :username, uniqueness: true

  class << self
    def users_ordered_by_points
      self.includes(:predictions).to_a.sort do |user_a, user_b|
        user_b.points <=> user_a.points
      end
    end
  end

  def points
    predictions.map(&:points).sum
  end

  def prediction_for match
    match.predictions.find_by user: self
  end
end
