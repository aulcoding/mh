# == Schema Information
#
# Table name: classroom_sessions
#
#  id                   :integer          not null, primary key
#  session_date         :date
#  year                 :integer
#  semester             :integer
#  classroom_student_id :integer          not null
#  teacher_id           :integer          not null
#  ziyadah_start        :integer
#  attendance_status_id :integer
#  attendance_remarks   :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  murajaah_start       :integer
#  ziyadah_end          :integer
#  murajaah_end         :integer
#
require "test_helper"

class ClassroomSessionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
