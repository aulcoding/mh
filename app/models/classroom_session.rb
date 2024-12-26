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
#  ziyadah_id           :integer
#  attendance_status_id :integer          not null
#  attendance_remarks   :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  murajaah_id          :integer
#
class ClassroomSession < ApplicationRecord
  belongs_to :classroom_student
  belongs_to :teacher
  belongs_to :ziyadah, class_name: 'Manuscript', foreign_key: 'ziyadah_id', optional: true
  belongs_to :murajaah, class_name: 'Manuscript', foreign_key: 'murajaah_id', optional: true
  belongs_to :attendance_status
end


