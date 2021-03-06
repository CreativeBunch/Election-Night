# This is used to select which database to use.
ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
require 'sinatra'
require 'json'

require_relative 'database'

class App < Sinatra::Base
  # Serve any HTML/CSS/JS from the client folder
  set :static, true
  set :public_folder, proc { File.join(root, '..', '..', 'client', 'public') }

  # Enable the session store
  enable :sessions

  # This ensures that we always return the content-type application/json
  before do
    content_type 'application/json'
  end

  # DO NOT REMOVE THIS ENDPOINT IT ENABLES HOSTING HTML FOR THE FRONT END
  get '/' do
    content_type 'text/html'
    body File.read(File.join(settings.public_folder, 'index.html'))
  end

  # You can delete this route but you should nest your endpoints under /api
  get '/api' do
    { msg: 'The server is running' }.to_json
  end

  post "/candidates" do
    candidate_info = JSON.parse(request.body.read)
    candidate = Candidate.new(candidate_info)

    if candidate.save
      status 201
      candidate.to_json
    else
      status 422
      {
        errors: {
          full_messages: candidate.errors.full_messages,
          messages: candidate.errors.messages
        }
      }.to_json
    end
  end

  get "/candidates" do
    content_type("application/json")
    Candidate.all.to_json
  end

  get "/candidates/:id" do
    candidate = Candidate.find_by(id: params["id"])
    if candidate
      candidate.to_json
    else
      status(404)
      {message: "Candidate with id: #{params["id"]} not found!"}.to_json
    end
  end

  patch "/candidates/:id" do
    candidate = Candidate.find_by(id: params["id"])
    if candidate
      candidate_data = JSON.parse(request.body.read)
      candidate.update(candidate_data)
      candidate.to_json
    else
      status(404)
      {message: "Candidate with id: #{params["id"]} not found!"}.to_json
    end
  end

  delete "/candidates/:id" do
    candidate = Candidate.find_by(id: params["id"])
    if candidate
      candidate.destroy
      candidate.to_json
    else
      status(404)
      {message: "Candidate with id: #{params["id"]} not found!"}.to_json
    end
  end

  post "/campaigns" do
    campaign_info = JSON.parse(request.body.read)
    campaign_name = campaign_info["name"]
    a_candidate = Candidate.find_by(id: campaign_info["candidate_a_id"])
    b_candidate = Candidate.find_by(id: campaign_info["candidate_b_id"])
    a_candidate_score = (a_candidate.intelligence * 2) +
                        (a_candidate.willpower * 3) +
                        (a_candidate.charisma)
    b_candidate_score = (b_candidate.intelligence * 2) +
                        (b_candidate.willpower * 3) +
                        (b_candidate.charisma)
    if a_candidate_score >= b_candidate_score
      winning_candidate = a_candidate
    else
      winning_candidate = b_candidate
    end

    campaign = Campaign.new(
                            name: campaign_name,
                            candidate_a: a_candidate,
                            candidate_b: b_candidate,
                            winner_candidate: winning_candidate)
    if campaign.save
      status 201
      campaign.to_json
    else
      status 422
      {
        errors: {
          full_messages: campaign.errors.full_messages,
          messages: campaign.errors.messages
        }
      }.to_json
    end
  end

  get "/campaigns" do
    content_type("application/json")
    Campaign.all.to_json
  end

  get "/candidates/:id/campaign" do
    candidate = Candidate.find_by(id: params["id"])
    if !candidate
      status(404)
      return {message: "Candidate with id: #{params["id"]} not found!"}.to_json
    end
    (candidate.candidate_a + candidate.candidate_b).to_json
  end

  delete "/campaigns/:id" do
    campaign = Campaign.find_by(id: params["id"])
    if campaign
      campaign.destroy
      campaign.to_json
    else
      status(404)
      {message: "Campaign with id: #{params["id"]} not found!"}.to_json
    end
  end

# If this file is run directly boot the webserver
run! if app_file == $PROGRAM_NAME
end
