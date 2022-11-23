class BeerClub < ApplicationRecord
  def to_s
    self.name
  end

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
end
