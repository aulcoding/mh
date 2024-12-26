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


  #Validations
  validates :name, presence: true,
            format: { without: /\A\d+\z/, message: "Tidak boleh ada angka." },
            length: { minimum: 3, maximum: 50 }

  validate :birthdate_cannot_be_invalid



  private

  # Custom validation for birthdate
  def birthdate_cannot_be_invalid
    if birthdate.present?
      if birthdate.year > 2010
        errors.add(:birthdate, "Tahun lahir harus di bawah 2010.")
      elsif birthdate.year == Date.current.year
        errors.add(:birthdate, "Tahun lahir tidak boleh sama dengan tahun yang berlangsung.")
      end
    else
      errors.add(:birthdate, "Kolom ini tidak boleh kosong.")
    end
  end


end