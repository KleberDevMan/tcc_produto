# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  biography              :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  telephone              :string
#  type_collaborator      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  has_paper_trail on: [:create]

  extend Enumerize
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :ideas, foreign_key: :ideializer_id, dependent: :destroy
  has_many :profile_users, dependent: :destroy
  has_many :profiles, through: :profile_users, dependent: :destroy
  has_many :profile_menus, through: :profiles, dependent: :destroy
  has_many :menus, through: :profile_menus, dependent: :destroy
  has_many :collaborations

  enumerize :type_collaborator, in: [:developer, :facilitator], predicates: true

  after_create :set_profile_idealize

  def set_profile_idealize
    profile_idealizer = Profile.find_by namespace: 'ideializer'

    if profile_idealizer
      ProfileUser.create user_id: self.id, profile_id: profile_idealizer.id
    end
  end

  scope :collaborators, -> { includes(:profiles).where(profiles: { namespace: 'collaborator' }) }
end
