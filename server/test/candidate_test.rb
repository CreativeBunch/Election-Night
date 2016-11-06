require_relative "test_helper"

class CandidateTest < Minitest::Test

  def setup
    #Candidate.delete_all
    #Campaign.delete_all
  end

  def test_class_exist
    assert Candidate
  end

  def test_can_create_a_candidate
    Candidate.create!(name: "Judy", intelligence: 3, charisma: 4, willpower: 3)
  end

  def test_candidate_must_have_name
    assert_raises do
      Candidate.create!
    end
  end

end
