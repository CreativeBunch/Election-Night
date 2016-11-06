require_relative "test_helper"

class CampaignTest < Minitest::Test

  def setup
    #Candidate.delete_all
    #Campaign.delete_all
  end

  def test_class_exist
    assert Campaign
  end

  def test_can_create_a_campaign
    candidate_a = Candidate.create!(name: "Judy", intelligence: 3, charisma: 4, willpower: 3)
    candidate_b = Candidate.create!(name: "John", intelligence: 1, charisma: 6, willpower: 3)
    Campaign.create!(name: "MD Senate 2016", candidate_a_id: candidate_a, candidate_b_id: candidate_b, winner_candidate_id: candidate_a)
  end

end
