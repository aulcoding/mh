# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


puts "Seeding ..."

# alquran = Manuscript.find_or_create_by(name: "Al-Qur'an")
puts "Seeding starts now ..."

juz_data = [
  { number: 1, pages: (1..21) },
  { number: 2, pages: (22..41) },
  { number: 3, pages: (42..61) },
  { number: 4, pages: (62..81) },
  { number: 5, pages: (82..101) },
  { number: 6, pages: (102..121) },
  { number: 7, pages: (122..141) },
  { number: 8, pages: (142..161) },
  { number: 9, pages: (162..181) },
  { number: 10, pages: (182..201) },
  { number: 11, pages: (202..221) },
  { number: 12, pages: (222..241) },
  { number: 13, pages: (242..261) },
  { number: 14, pages: (262..281) },
  { number: 15, pages: (282..301) },
  { number: 16, pages: (302..321) },
  { number: 17, pages: (322..341) },
  { number: 18, pages: (342..361) },
  { number: 19, pages: (362..381) },
  { number: 20, pages: (382..401) },
  { number: 21, pages: (402..421) },
  { number: 22, pages: (422..441) },
  { number: 23, pages: (442..461) },
  { number: 24, pages: (462..481) },
  { number: 25, pages: (482..501) },
  { number: 26, pages: (502..521) },
  { number: 27, pages: (522..541) },
  { number: 28, pages: (542..561) },
  { number: 29, pages: (562..581) },
  { number: 30, pages: (582..604) }
]





# juz_data.each do |data|
#   juz = Manuscript.create!(
#     name: "Juz #{data[:number]}",
#     parent_manuscript_id: alquran.id
#   )

#   # Seed pages for each Juz as children of that Juz
#   data[:pages].each do |page_number|
#     Manuscript.create!(
#       name: "Halaman #{page_number}",
#       parent_manuscript_id: juz.id
#     )
#   end
# end


surahs = {
  "Al-Fatihah" => 7,
  "Al-Baqarah" => 286,
  "Ali Imran" => 200,
  "An-Nisaa" => 176,
  "Al-Ma'idah" => 120,
  "Al-An'am" => 165,
  "Al-A'raf" => 206,
  "Al-Anfal" => 75,
  "At-Taubah" => 129,
  "Yunus" => 109,
  "Hud" => 123,
  "Yusuf" => 111,
  "Ar-Ra'd" => 43,
  "Ibrahim" => 52,
  "Al-Hijr" => 99,
  "An-Nahl" => 128,
  "Al-Isra" => 111,
  "Al-Kahf" => 110,
  "Maryam" => 98,
  "Taha" => 135,
  "Al-Anbiya" => 112,
  "Al-Hajj" => 78,
  "Al-Mu'minun" => 118,
  "An_Nuur" => 64,
  "Al-Furqan" => 77,
  "Asy-Syu'ara" => 227,
  "An-Naml" => 93,
  "Al-Qasas" => 88,
  "Al-Ankabut" => 69,
  "Ar-Rum" => 60,
  "Luqman" => 34,
  "As-Sajdah" => 30,
  "Al-Ahzab" => 73,
  "Saba'" => 54,
  "Fathir" => 45,
  "Yasin" => 83,
  "Ash-Shaffat" => 182,
  "Shad" => 88,
  "Az-Zumar" => 75,
  "Ghafir" => 85,
  "Fushilat" => 54,
  "Asy-Syura'" => 53,
  "Az-Zukhruf" => 89,
  "Ad-Dukhan" => 59,
  "Al-Jatsiyah" => 37,
  "Al-Ahqaf" => 35,
  "Muhammad" => 38,
  "Al-Fath" => 29,
  "Al-Hujurat" => 18,
  "Qaf" => 45,
  "Adz-Dzariyat" => 60,
  "Ath-Thur" => 49,
  "An-Najm" => 62,
  "Al-Qamar" => 55,
  "Ar-Rahman" => 78,
  "Al-Waqiah" => 96,
  "Al-Hadid" => 29,
  "Al-Mujadilah" => 22,
  "Al-Hasyr" => 24,
  "Al-Mumtahanah" => 13,
  "Ash-Shaff" => 14,
  "Al-Jumu'ah" => 11,
  "Al-Munafiqun" => 11,
  "At-Taghabun" => 18,
  "At-Talaq" => 12,
  "At-Tahrim" => 12,
  "Al-Mulk" => 30,
  "Al-Qalam" => 52,
  "Al-Haqqah" => 52,
  "Al-Ma'arij" => 44,
  "Nuh" => 28,
  "Al-Jinn" => 28,
  "Al-Muzzammil" => 20,
  "Al-Muddatstsir" => 56,
  "Al-Qiyamah" => 40,
  "Al-Insan" => 31,
  "Al-Mursalat" => 50,
  "An-Naba'" => 40,
  "An-Nazi'at" => 46,
  "Abasa" => 42,
  "At-Takwir" => 29,
  "Al-Infithar" => 19,
  "Al-Muthaffifin" => 36,
  "Al-Inshiqaq" => 25,
  "Al-Buruj" => 22,
  "At-Tariq" => 17,
  "Al-A'la" => 19,
  "Al-Ghasyiyah" => 26,
  "Al-Fajr" => 30,
  "Al-Balad" => 20,
  "Ash-Syams" => 15,
  "Al-Lail" => 21,
  "Ad-Duha" => 11,
  "Al-Insyirah" => 8,
  "At-Tin" => 8,
  "Al-'Alaq" => 19,
  "Al-Qadr" => 5,
  "Al-Bayyinah" => 8,
  "Az-Zalzalah" => 8,
  "Al-'Adiyat" => 11,
  "Al-Qari'ah" => 11,
  "At-Takatsur" => 8,
  "Al-'Ashr" => 3,
  "Al-Humazah" => 9,
  "Al-Fil" => 5,
  "Quraisy" => 4,
  "Al-Ma'un" => 7,
  "Al-Kautsar" => 3,
  "Al-Kafirun" => 6,
  "An-Nasr" => 3,
  "Al-Lahab" => 5,
  "Al-Ikhlas" => 4,
  "Al-Falaq" => 5,
  "An-Nas" => 6
}



# surahs.each do |surah_name, verses_count|
#   surah = Manuscript.create!(name: surah_name, parent_manuscript_id: alquran.id)

#   # Create verses as children of the surah
#   verses_count.times do |verse_number|
#     Manuscript.create!(name: verse_number + 1, parent_manuscript_id: surah.id)
#   end
# end

genders = [
  {name: "Male"},
  {name: "Female"}
]
levels = [
  {name: "1"},
  {name: "2"},
  {name: "3"},
]

statuses = [
  {name: "Hadir"},
  {name: "Sakit"},
  {name: "Izin"},
  {name: "Alpa"}

]

manuscript_statuses = [
  {name: "Ziyadah"},
  {name: "Muraja'ah"}
]

# genders.each do |gender|
#   Gender.create!(name: gender[:name])
# end
# levels.each do |level|
#   Level.create!(name: level[:name])
# end

statuses.each do |status|
  AttendanceStatus.create!(name: status[:name])
  puts "Berhasil membuat #{status[:name]}"
end
# manuscript_statuses.each do |manuscript_status|
#   ManuscriptStatus.create!(name: manuscript_status[:name])
#   puts "Berhasil membuat #{manuscript_status[:name]}"
# end
puts "Seeding done, Sir."