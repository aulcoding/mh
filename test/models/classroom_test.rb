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
require "test_helper"

class ClassroomTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
