# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  name       :string
#  nickname   :string
#  gender_id  :integer          not null
#  birthdate  :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Student < ApplicationRecord
  belongs_to :gender
  has_many :classroom_students
  has_many :classrooms, through: :classroom_students

  # Validations
  validates :name, presence: true,
             format: { without: /\A\d+\z/, message: "Tidak boleh ada angka." },
             length: { minimum: 3, maximum: 50 }
  validates :nickname, allow_nil: true,
             format: { without: /\A\d+\z/, message: "Tidak boleh ada angka." },
             length: { minimum: 3, allow_nil: true },
             format: { without: /\s/, message: "Tidak boleh ada spasi." }
  # validate :birthdate_cannot_be_invalid

  private

  # Custom validation for birthdate
  def birthdate_cannot_be_invalid
    if birthdate.present?
      if birthdate.year < 2000
        errors.add(:birthdate, "Tahun lahir harus di atas 2000.")
      elsif birthdate.year == Date.current.year
        errors.add(:birthdate, "Tahun lahir tidak boleh sama dengan tahun yang berlangsung.")
      end
    else
      errors.add(:birthdate, "Kolom ini tidak boleh kosong.")
    end
  end
end
