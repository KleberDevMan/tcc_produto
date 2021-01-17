# == Schema Information
#
# Table name: idea_categories
#
#  id            :bigint           not null, primary key
#  img           :string
#  img_link      :string
#  link_or_image :string
#  name          :string
#  status        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class IdeaCategory < ApplicationRecord
  extend Enumerize

  has_many :idea_category_ideas
  has_many :ideas, through: :idea_category_ideas

  validates :name, presence: true

  enumerize :status, in: [:active, :inactive], predicates: true, default: :active
  enumerize :link_or_image, in: [:link, :img], predicates: true, default: :link

  has_one_attached :img

  scope :active, -> { where(status: :active) }

  def to_s
    self.name
  end

  def link_or_img_value_default
    if link_or_image.nil?
      'link'
    else
      link_or_image
    end
  end
end
