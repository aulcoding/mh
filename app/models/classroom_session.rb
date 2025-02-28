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
class ClassroomSession < ApplicationRecord
  belongs_to :classroom_student
  belongs_to :teacher
  belongs_to :ziyadah, class_name: 'Manuscript', foreign_key: 'ziyadah_start', optional: true
  belongs_to :ziyadah, class_name: 'Manuscript', foreign_key: 'ziyadah_end', optional: true
  belongs_to :murajaah, class_name: 'Manuscript', foreign_key: 'murajaah_start', optional: true
  belongs_to :murajaah, class_name: 'Manuscript', foreign_key: 'murajaah_end', optional: true
  belongs_to :attendance_status, optional: true

  class << self
    def filter_juz(params = {})

    end
  end
end


