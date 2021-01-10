# == Schema Information
#
# Table name: idea_category_ideas
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  idea_category_id :bigint           not null
#  idea_id          :bigint           not null
#
# Indexes
#
#  index_idea_category_ideas_on_idea_category_id  (idea_category_id)
#  index_idea_category_ideas_on_idea_id           (idea_id)
#
# Foreign Keys
#
#  fk_rails_...  (idea_category_id => idea_categories.id)
#  fk_rails_...  (idea_id => ideas.id)
#
require "test_helper"

class IdeaCategoryIdeaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
