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
require "test_helper"

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
