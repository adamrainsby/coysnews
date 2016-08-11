class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :predictions

  class << self
    def users_ordered_by_points
      self.includes(:predictions).to_a.sort do |user_a, user_b|
        user_a.points <=> user_b.points
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
