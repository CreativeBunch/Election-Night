require_relative "test_helper"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    App
  end

  def test_classes_exist
    assert Candidate
  end

  def test_can_create_candidate
    payload = {
      name: 'Judy',
      image_url: 'www.judy.com',
      intelligence: 3,
      charisma: 4,
      willpower: 3
    }

    post "/candidates", payload.to_json
    assert_equal 201, last_response.status
    assert_equal Candidate.last.id, JSON.parse(last_response.body)["id"]
  end

  def test_can_read_all_candidates
    get "/candidates"
    assert last_response.ok?
    candidates = JSON.parse(last_response.body)
    assert_equal "Judy", candidates.first["name"]
  end

  def test_can_read_single_candidate
    candidate_a = Candidate.create!(name: "Judy", intelligence: 3, charisma: 4, willpower: 3)
    get "/candidates/#{candidate_a.id}"
    assert last_response.ok?
    assert_equal "Judy", JSON.parse(last_response.body)["name"]
  end

  def test_404_for_candidate_not_in_database
    get "/candidates/#{Candidate.last.id + 1}"
    assert_equal 404, last_response.status
  end

  def test_it_can_update_a_candidate
    judy = Candidate.create!(
            name: 'Judy',
            image_url: 'www.judy.com',
            intelligence: 3,
            charisma: 4,
            willpower: 3)
    update_data = {
            intelligence: 4,
            charisma: 4,
            willpower: 2
            }

    response = patch("/candidates/#{judy.id}", update_data.to_json, { "CONTENT_TYPE" => "application/json" })
    assert response.ok?

    updated_judy = Candidate.find_by(id: judy.id)
    candidate =  JSON.parse(response.body)
    assert_equal 4, updated_judy.intelligence
    assert_equal 4, candidate["intelligence"]
  end

  def test_delete_candidate_with_id
    judy = Candidate.create!(
            name: 'Judy',
            image_url: 'www.judy.com',
            intelligence: 3,
            charisma: 4,
            willpower: 3)

    response = delete "/candidates/#{judy.id}"
    assert response.ok?

    candidate_response =  JSON.parse(response.body)
    assert_equal judy.name, candidate_response["name"]
    refute Candidate.find_by(id: judy.id)
  end

  def test_can_create_a_campaign
    candidate_a = Candidate.create!(name: "Judy", intelligence: 3, charisma: 4, willpower: 3)
    candidate_b = Candidate.create!(name: "John", intelligence: 1, charisma: 6, willpower: 3)
    payload = {
      name: 'MD Senate 2016',
      candidate_a_id: candidate_a.id,
      candidate_b_id: candidate_b.id
    }

    post "/campaigns", payload.to_json
    assert_equal 201, last_response.status
    assert_equal Campaign.last.id, JSON.parse(last_response.body)["id"]
  end

  def test_can_read_all_campaigns
    get "/campaigns"
    assert last_response.ok?
    campaigns = JSON.parse(last_response.body)
    assert_equal 'MD Senate 2016', campaigns.first["name"]
  end

  def test_can_get_campaigns_for_candidate_with_given_id
    peter =  Candidate.create!(name: "peter", intelligence: 3, charisma: 4, willpower: 3)
    pamela = Candidate.create!(name: "pamela", intelligence: 2, charisma: 5, willpower: 3)
    angela = Candidate.create!(name: "angela", intelligence: 3, charisma: 3, willpower: 4)
    adolph = Candidate.create!(name: "Adolph", intelligence: 1, charisma: 6, willpower: 3)
    Campaign.create!(name: "MD Senate 2016", candidate_a: peter, candidate_b: pamela, winner_candidate: pamela)
    Campaign.create!(name: "NY Dem Primary 2016", candidate_a: pamela, candidate_b: angela, winner_candidate: angela)
    Campaign.create!(name: "VA Senate 2016", candidate_a: pamela, candidate_b: adolph, winner_candidate: pamela)
    get "/candidates/#{pamela.id}/campaign"
    campaigns = JSON.parse(last_response.body)
    assert_equal 3, campaigns.count
  end

  def test_delete_campaign_with_given_id
    peter =  Candidate.create!(name: "peter", intelligence: 3, charisma: 4, willpower: 3)
    pamela = Candidate.create!(name: "pamela", intelligence: 2, charisma: 5, willpower: 3)
    senate_campaign = Campaign.create!(name: "VA Senate 2016", candidate_a: pamela, candidate_b: peter, winner_candidate: pamela)

    response = delete "/campaigns/#{senate_campaign.id}"
    assert response.ok?

    campaign_response =  JSON.parse(response.body)
    assert_equal senate_campaign.name, campaign_response["name"]
    refute Campaign.find_by(id: senate_campaign.id)
  end

end
