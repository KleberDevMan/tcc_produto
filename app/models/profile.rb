# == Schema Information
#
# Table name: profiles
#
#  id          :bigint           not null, primary key
#  active      :boolean
#  description :string
#  name        :string
#  namespace   :string
#  permissions :json
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Profile < ApplicationRecord
  has_many :profile_menus
  has_many :profile_users
  has_many :users, through: :profile_users

  validates :name, presence: true

  before_create :set_active

  def set_active
    self.active = true
  end

  def to_s
    self.name
  end

  def self.to_select
    where(status: true).map { |a| [a.name, a.id] }
  end
end
