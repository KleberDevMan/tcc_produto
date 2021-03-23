# == Schema Information
#
# Table name: ideas
#
#  id                   :bigint           not null, primary key
#  description          :string
#  differential         :string
#  locality             :string
#  possibility_business :boolean
#  possibility_reward   :boolean
#  problem_to_solve     :string
#  proposed_solution    :string
#  status               :string
#  suffering_people     :string
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  idea_category_id     :bigint
#  ideializer_id        :bigint           not null
#
# Indexes
#
#  index_ideas_on_idea_category_id  (idea_category_id)
#  index_ideas_on_ideializer_id     (ideializer_id)
#
# Foreign Keys
#
#  fk_rails_...  (idea_category_id => idea_categories.id)
#  fk_rails_...  (ideializer_id => users.id)
#
class Idea < ApplicationRecord
  extend Enumerize

  # belongs_to :idea_category, coyunter_cache: true
  belongs_to :ideializer, class_name: 'User'

  has_many :collaborations, dependent: :destroy
  has_many :collaborators, through: :collaborations, source: :user, class_name: "User"

  has_many :collaboration_devs, -> { where(type_collaboration: :developer) }, class_name: "Collaboration"
  has_many :devs, through: :collaboration_devs, source: :user, class_name: "User"

  has_many :collaboration_facs, -> { where(type_collaboration: :facilitator) }, class_name: "Collaboration"
  has_many :facilitators, through: :collaboration_facs, source: :user, class_name: "User"

  # has_many :idea_category_ideas
  # has_many :categories, through: :idea_category_ideas, source: :idea_category, class_name: "IdeaCategory"

  belongs_to :idea_category

  enumerize :status, in: [:public, :private], predicates: true, default: :public

  def status_value_default
    if status.nil?
      'public'
    else
      status
    end
  end

  def get_semester
    year = self.created_at.year
    if self.created_at.month <= 6
      semester = 1
    else
      semester = 2
    end

    "#{year.to_s}/#{semester.to_s}"
  end

  scope :quick_filter, -> (filter = nil, user_id = nil) do
    case filter
    when 'my_collaborations'
      includes(:collaborations).where(collaborations: { user_id: user_id }).distinct
    when 'my_ideas'
      where(ideializer_id: user_id)
    else
      all
    end
  end
end
