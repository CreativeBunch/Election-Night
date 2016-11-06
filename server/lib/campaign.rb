require 'active_record'

class Campaign < ActiveRecord::Base
  belongs_to :candidate_a, class_name: "Candidate", foreign_key: :candidate_a_id
  belongs_to :candidate_b, class_name: "Candidate", foreign_key: :candidate_b_id
  belongs_to :winner_candidate, class_name: "Candidate", foreign_key: :winner_candidate_id

end
