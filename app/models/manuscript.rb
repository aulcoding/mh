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
  has_many :children, class_name: "Manuscript", foreign_key: "parent_manuscript_id"

  belongs_to :parent, class_name: "Manuscript", foreign_key:"parent_manuscript_id", optional: true

  has_many :classroom_sessions
end
