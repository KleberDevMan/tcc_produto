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
  extend ActiveModel::Naming

  enumerize :status, in: %i[active inative], predicates: true
end