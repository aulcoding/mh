# == Schema Information
#
# Table name: teachers
#
#  id         :integer          not null, primary key
#  name       :string
#  gender_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Teacher < ApplicationRecord
  belongs_to :gender

  # Validations
  validates :name, presence: true,
                   format: { without: /\A\d+\z/, message: "Tidak boleh ada angka." }

  private
end
