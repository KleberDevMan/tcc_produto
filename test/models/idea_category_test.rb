# == Schema Information
#
# Table name: idea_categories
#
#  id            :bigint           not null, primary key
#  img           :string
#  img_link      :string
#  link_or_image :string
#  name          :string
#  status        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "test_helper"

class IdeaCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
