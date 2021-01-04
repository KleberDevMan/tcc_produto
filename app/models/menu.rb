# == Schema Information
#
# Table name: menus
#
#  id         :bigint           not null, primary key
#  active     :boolean
#  ancestry   :string
#  icon       :string
#  name       :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_menus_on_ancestry  (ancestry)
#
class Menu < ApplicationRecord
  has_ancestry

  has_many :profile_menus, dependent: :destroy
  has_many :profiles, through: :profile_menus

  validates :name, :icon, :url, presence: true

  before_create :set_active

  def to_s
    self.name
  end

  def set_active
    self.active = true
  end
end
