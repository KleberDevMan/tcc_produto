# == Schema Information
#
# Table name: academic_works
#
#  id            :bigint           not null, primary key
#  appraisers    :string
#  author        :string
#  course        :string
#  defense_date  :string
#  document_link :string
#  how_to_quote  :string
#  institution   :string
#  keyword       :string
#  link_or_doc   :string
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
  include Rails.application.routes.url_helpers

  belongs_to :teacher, counter_cache: true
  belongs_to :course, counter_cache: true

  validates :title, :teacher_id, presence: true

  enumerize :work_type, in: [:tcc, :search, :extension], predicates: true, default: :tcc
  enumerize :link_or_doc, in: [:link, :doc], predicates: true, default: :link

  has_one_attached :document

  def work_type_value_default
    if work_type.nil?
      'tcc'
    else
      work_type
    end
  end

  def default_link_or_doc
    if link_or_doc.nil?
      'link'
    else
      link_or_doc
    end
  end

  def get_url_doc
    if link_or_doc == 'doc' and document
      rails_blob_path(document , only_path: true)
    elsif link_or_doc == 'link' and document_link
      document_link
    else
      'https://media.istockphoto.com/vectors/broken-file-line-icon-vector-id1146597753?k=6&m=1146597753&s=612x612&w=0&h=OM5uYm7mpD3dW3S3nSHDwIwy5kbIQcIEW9i46HKTahM='
    end
  end
end
