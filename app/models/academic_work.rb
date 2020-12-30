# == Schema Information
#
# Table name: academic_works
#
#  id            :bigint           not null, primary key
#  appraisers    :string
#  author        :string
#  course        :string
#  defense_date  :date
#  document_link :string
#  how_to_quote  :string
#  institution   :string
#  keyword       :string
#  summary       :string
#  title         :string
#  work_type     :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  course_id     :bigint           not null
#  teacher_id    :bigint           not null
#
# Indexes
#
#  index_academic_works_on_course_id   (course_id)
#  index_academic_works_on_teacher_id  (teacher_id)
#
# Foreign Keys
#
#  fk_rails_...  (course_id => courses.id)
#  fk_rails_...  (teacher_id => teachers.id)
#
class AcademicWork < ApplicationRecord
  extend Enumerize

  belongs_to :teacher
  belongs_to :course

  validates :title, :teacher_id, presence: true

  enumerize :work_type, in: [:tcc, :search, :extension], predicates: true, default: :tcc

  has_one_attached :document


end
