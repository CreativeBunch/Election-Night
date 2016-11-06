require 'active_record'

class Candidate < ActiveRecord::Base
  has_many :candidate_a, class_name: "Campaign", foreign_key: :candidate_a_id
  has_many :candidate_b, class_name: "Campaign", foreign_key: :candidate_b_id
  has_many :winner_candidate, class_name: "Campaign", foreign_key: :winner_candidate_id
  validates :name, presence: true
end
