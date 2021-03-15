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
  include Rails.application.routes.url_helpers

  has_many :ideas

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

  def get_url_img
    if link_or_image == 'img' and img
      rails_blob_path(img, disposition: "attachment", only_path: true)
    elsif link_or_image == 'link' and img_link
      img_link
    else
      'https://piotrkowalski.pw/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png'
    end
  end
end
