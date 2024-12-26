# == Schema Information
#
# Table name: attendance_statuses
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AttendanceStatus < ApplicationRecord
end
