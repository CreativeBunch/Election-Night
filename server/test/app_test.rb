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
    get "/candidates/#{Candidate.last.id}"
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


end
