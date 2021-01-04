# == Schema Information
#
# Table name: ideas
#
#  id                   :bigint           not null, primary key
#  description          :string
#  possibility_business :boolean
#  possibility_reward   :boolean
#  status               :string
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  idea_category_id     :bigint           not null
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

  belongs_to :idea_category
  belongs_to :ideializer, class_name: 'User'

  enumerize :status, in: [:public, :private], predicates: true, default: :public
end