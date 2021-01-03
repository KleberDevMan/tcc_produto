# == Schema Information
#
# Table name: profile_users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  profile_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_profile_users_on_profile_id  (profile_id)
#  index_profile_users_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (profile_id => profiles.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class ProfileUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
