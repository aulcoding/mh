# == Schema Information
#
# Table name: manuscripts
#
#  id                   :integer          not null, primary key
#  name                 :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  parent_manuscript_id :integer
#
class Manuscript < ApplicationRecord
  has_many :children, class_name: "Manuscript",
                     foreign_key: "parent_manuscript_id"
  belongs_to :parent, class_name: "Manuscript",
                      foreign_key: "parent_manuscript_id",
                      optional: true

  has_many :classroom_sessions


  validates :name, presence: true

  class << self
    def filter_surahs_by_juz(juz_number)
      validate_juz_input!(juz_number)

      case juz_number
      when "Juz lainnya"
        Manuscript.first.children.where.not("name LIKE ?", "Juz%")
      else
        matching_surahs = get_surahs_for_juz(juz_number)
        find_matching_manuscripts(matching_surahs)
      end
    end

    private

    def get_surahs_for_juz(juz_number)
      SURAH_MAPPINGS[juz_number] || []
    rescue KeyError
      raise ArgumentError, "Invalid Juz number format"
    end

    def find_matching_manuscripts(surah_names)
      return [] if surah_names.empty?

      where(name: surah_names)
    end

    def validate_juz_input!(input)
      return if input == "Juz lainnya"

      unless input =~ /\AJuz (\d+)\z/
        raise ArgumentError, "Invalid Juz number format"
      end

      true
    end

    SURAH_MAPPINGS =  {
        "Juz 30" => [
          "An-Naba'", "An-Nazi'at", "Abasa", "At-Takwir", "Al-Infithar", "Al-Muthaffifin",
          "Al-Inshiqaq", "Al-Buruj", "At-Tariq", "Al-A'la", "Al-Ghasyiyah", "Al-Fajr",
          "Al-Balad", "Ash-Syams", "Al-Lail", "Ad-Duha", "Al-Insyirah", "At-Tin",
          "Al-'Alaq", "Al-Qadr", "Al-Bayyinah", "Az-Zalzalah", "Al-'Adiyat", "Al-Qari'ah",
          "At-Takatsur", "Al-'Ashr", "Al-Humazah", "Al-Fil", "Quraisy", "Al-Ma'un",
          "Al-Kautsar", "Al-Kafirun", "An-Nasr", "Al-Lahab", "Al-Ikhlas", "Al-Falaq",
          "An-Nas"
        ],
        "Juz 29" => [
          "Al-Mulk", "Al-Qalam", "Al-Haqqah", "Al-Ma'arij", "Nuh", "Al-Jinn",
          "Al-Muzzammil", "Al-Muddatstsir", "Al-Qiyamah", "Al-Insan", "Al-Mursalat"
        ],
        "Juz 28" => [
          "Al-Mujadilah", "Al-Hasyr", "Al-Mumtahanah", "Ash-Shaff", "Al-Jumu'ah",
          "Al-Munafiqun", "At-Taghabun", "At-Talaq", "At-Tahrim"
        ],
        "Juz 27" => [
          "Adz-Dzariyat", "Ath-Thur", "An-Najm", "Al-Qamar", "Ar-Rahman", "Al-Waqiah",
          "Al-Hadid"
        ],
        "Juz 26" => [
          "Al-Ahqaf", "Muhammad", "Al-Fath", "Al-Hujurat", "Qaf"
        ]
      }.freeze
  end
end

