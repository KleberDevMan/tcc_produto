# == Schema Information
#
# Table name: teachers
#
#  id                   :bigint           not null, primary key
#  academic_works_count :integer          default(0)
#  name                 :string
#  status               :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
require "test_helper"

class TeacherTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
