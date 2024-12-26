# == Schema Information
#
# Table name: classrooms
#
#  id         :integer          not null, primary key
#  name       :string
#  gender_id  :integer          not null
#  level_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Classroom < ApplicationRecord
  belongs_to :gender
  belongs_to :level
  has_many :classroom_students
  has_many :students, through: :classroom_students




  validates :name, presence: true,
  length: { minimum: 3, maximum: 20 }



end
