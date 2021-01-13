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
require "test_helper"

class IdeaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
