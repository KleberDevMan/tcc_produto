# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  biography              :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  img                    :string
#  img_link               :string
#  link_or_img            :string
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  telephone              :string
#  type_collaborator      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  registered_by_id       :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_registered_by_id      (registered_by_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (registered_by_id => users.id)
#
class User < ApplicationRecord
  # has_paper_trail on: [:create]

  extend Enumerize
  include Rails.application.routes.url_helpers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :ideas, foreign_key: :ideializer_id, dependent: :destroy
  has_many :profile_users, dependent: :destroy
  has_many :profiles, through: :profile_users, dependent: :destroy
  has_many :profile_menus, through: :profiles, dependent: :destroy
  has_many :menus, through: :profile_menus, dependent: :destroy
  has_many :collaborations, dependent: :destroy
  has_many :notifications, dependent: :destroy

  belongs_to :registered_by, class_name: 'User', optional: true

  has_one_attached :img

  enumerize :type_collaborator, in: [:developer, :facilitator], predicates: true
  enumerize :link_or_img, in: [:link, :img], predicates: true, default: :link

  after_create :set_profile_idealize

  def set_profile_idealize
    profile_idealizer = Profile.find_by namespace: 'ideializer'

    if profile_idealizer
      ProfileUser.create user_id: self.id, profile_id: profile_idealizer.id
    end
  end

  scope :collaborators, -> { includes(:profiles).where(profiles: { namespace: 'collaborator' }) }

  def to_s
    name
  end

  def link_or_img_value_default
    if link_or_img.nil?
      'link'
    else
      link_or_img
    end
  end

  def get_url_img
    if link_or_img == 'img' and img
      rails_blob_path(img, disposition: "attachment", only_path: true)
    elsif link_or_img == 'link' and img_link
      img_link
    else
      '/img/avatar2.png'
    end
  end
end
