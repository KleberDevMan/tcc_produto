# == Schema Information
#
# Table name: courses
#
#  id         :bigint           not null, primary key
#  name       :string
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Course < ApplicationRecord
  extend Enumerize

  enumerize :status, in: [:active, :inactive], predicates: true, default: :active

  def to_s
    self.name
  end
end