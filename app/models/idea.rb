# == Schema Information
#
# Table name: ideas
#
#  id                   :bigint           not null, primary key
#  description          :string
#  differential         :string
#  possibility_business :boolean
#  possibility_reward   :boolean
#  problem_to_solve     :string
#  proposed_solution    :string
#  status               :string
#  suffering_people     :string
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  ideializer_id        :bigint           not null
#
# Indexes
#
#  index_ideas_on_ideializer_id  (ideializer_id)
#
# Foreign Keys
#
#  fk_rails_...  (ideializer_id => users.id)
#
class Idea < ApplicationRecord
  extend Enumerize

  # belongs_to :idea_category, coyunter_cache: true
  belongs_to :ideializer, class_name: 'User'

  has_many :collaborations
  has_many :collaborators, through: :collaborators, source: :user, class_name: "User"
  has_many :idea_category_ideas
  has_many :categories, through: :idea_category_ideas, source: :idea_category, class_name: "IdeaCategory"

  enumerize :status, in: [:public, :private], predicates: true, default: :public

  def status_value_default
    if status.nil?
      'public'
    else
      status
    end
  end
end
