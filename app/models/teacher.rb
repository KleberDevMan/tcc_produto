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
class Teacher < ApplicationRecord
  extend Enumerize

  has_many :academic_works

  validates :name, presence: true

  enumerize :status, in: [:active, :inactive], predicates: true, default: :active

  def to_s
    self.name
  end

  scope :active, -> { where(status: :active) }
end
