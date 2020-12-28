# == Schema Information
#
# Table name: academic_works
#
#  id            :bigint           not null, primary key
#  appraisers    :string
#  author        :string
#  course        :string
#  defense_date  :date
#  document      :string
#  document_link :string
#  how_to_quote  :string
#  keyword       :string
#  summary       :string
#  title         :string
#  type          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class AcademicWork < ApplicationRecord
end
