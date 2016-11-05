class Api::V1::ApiController < ApplicationController

  before_action :set_profile, except: :priority

  attr_accessor :profile

  def priority
    top = Profile.where(json: nil).first # .order(priority: :asc).first
    if top
      render text: top.link
    else
      render nil
    end
  end

  def generate
    priority = params[:priority].nil? ? 1 : params[:priority]
# Commented for normal work of dummy API. Uncomment when need to turn on this part
    if @profile.json.nil?
      # PriorityQueue.instance << Element.new(params[:link], priority)
    end
    until !@profile.json.nil?
       @profile.json
      sleep 1
      @profile.reload
    end
    render_response
  end

  def update
    @logic=Logic.new
    execute_logic JSON.parse params[:json].to_s.force_encoding("ISO-8859-1").encode("UTF-8")
    @profile.update_attribute :json, @logic.json.to_json
    render json: @logic.json
  end

private

  def set_profile
    if params[:link][/linkedin.com\/in\/.*/]
        @profile=Profile.find_or_create_by(link:params[:link].strip)
    else
      render json: {"error" => "Link is incorrect"}
    end
  end

  def render_response
    # data=File.read("#{Rails.root}/test.json")
    if params[:result_only]
      render json: JSON.parse(@profile.json)["result"]
    else
      render json: JSON.pretty_generate(
        JSON.parse(@profile.json)
        # JSON.parse(data)
      )
    end
  end

  def execute_logic(hash)
    @logic.json=hash
    @logic.picture
    @logic.first_name
    @logic.last_name
    # @logic.location
    # @logic.industry
    @logic.title_score
    @logic.summary_score
    @logic.summary_contact_score
    @logic.linkedin_url_score
    @logic.number_of_connections_score
    @logic.skills_score
    @logic.groups_score
    @logic.organizations_score
    @logic.average_title_score
    @logic.average_description_score
    @logic.average_bullet_points_score
    @logic.grammar_score
    @logic.passive_language_score
    @logic.action_score
    @logic.specifics_score
    @logic.avoided_words_score
    @logic.profile_word_cloud
    @logic.grade
    @logic.benchmark
    @logic.generate
  end
end
