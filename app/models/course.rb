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

  has_many :academic_works

  validates :name, presence: true

  enumerize :status, in: [:active, :inactive], predicates: true, default: :active

  def to_s
    self.name
  end

  scope :active, -> { where(status: :active) }
end