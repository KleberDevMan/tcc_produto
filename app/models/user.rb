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

  enumerize :type_collaborator, in: [:developer, :facilitator], predicates: true
end
