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
      intelligence: 4,
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
    get "/candidate/#{Candidate.last.id}"
    assert last_response.ok?
    assert_equal "Judy", JSON.parse(last_response.body)["name"]
  end

  def test_404_for_candidate_not_in_database
    get "/candidate/#{Candidate.last.id + 1}"
    assert_equal 404, last_response.status
    assert_equal "Candidate with id: #{Candidate.last.id + 1} not found!", JSON.parse(last_response.body)["message"]
  end


end
