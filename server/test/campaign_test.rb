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

  def test_can_get_campaigns_for_candidate_with_given_id
    peter =  Candidate.create!(name: "peter", intelligence: 3, charisma: 4, willpower: 3)
    pamela = Candidate.create!(name: "pamela", intelligence: 2, charisma: 5, willpower: 3)
    angela = Candidate.create!(name: "angela", intelligence: 3, charisma: 3, willpower: 4)
    adolph = Candidate.create!(name: "Adolph", intelligence: 1, charisma: 6, willpower: 3)
    Campaign.create!(name: "MD Senate 2016", candidate_a: peter, candidate_b: pamela, winner_candidate: pamela)
    Campaign.create!(name: "NY Dem Primary 2016", candidate_a: pamela, candidate_b: angela, winner_candidate: angela)
    Campaign.create!(name: "VA Senate 2016", candidate_a: pamela, candidate_b: adolph, winner_candidate: pamela)
    pamela_campaigns = pamela.candidate_a + pamela.candidate_b
    assert_equal 3, pamela_campaigns.count
  end

end
