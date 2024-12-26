# == Schema Information
#
# Table name: genders
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Gender < ApplicationRecord
  has_many :students
  has_many :teachers
  has_many :classrooms
end
