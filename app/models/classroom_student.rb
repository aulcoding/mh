# == Schema Information
#
# Table name: classroom_students
#
#  id           :integer          not null, primary key
#  year         :integer
#  semester     :integer
#  classroom_id :integer          not null
#  student_id   :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class ClassroomStudent < ApplicationRecord
  belongs_to :classroom
  belongs_to :student
end
