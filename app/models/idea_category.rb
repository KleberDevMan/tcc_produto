# == Schema Information
#
# Table name: idea_categories
#
#  id          :bigint           not null, primary key
#  ideas_count :integer          default(0)
#  name        :string
#  status      :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class IdeaCategory < ApplicationRecord
  extend Enumerize

  has_many :ideas

  validates :name, presence: true

  enumerize :status, in: [:active, :inactive], predicates: true, default: :active

  def to_s
    self.name
  end

  scope :active, -> { where(status: :active) }
end
