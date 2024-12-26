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
require "test_helper"

class ManuscriptTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
