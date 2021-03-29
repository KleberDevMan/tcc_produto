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
require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
