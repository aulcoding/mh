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
require "test_helper"

class ClassroomStudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
