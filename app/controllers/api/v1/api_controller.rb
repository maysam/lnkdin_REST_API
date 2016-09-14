class Api::V1::ApiController < ApplicationController
	

	def generate
		if params[:link][/linkedin.com\/in\/.*/]
			@profile=Profile.find_or_create_by(link:params[:link])
			priority = params[:priority].nil? ? 1 : params[:priority]
			unless @profile.json
				PriorityQueue.instance << Element.new(params[:link], priority)
			end
			until @profile.json
				sleep 1
				@profile.reload
			end
			render_response(JSON.parse(@profile.json))
			@profile.update_attribute( :json, nil )
		else
			render json: {"error" => "Link is incorrectt"}
		end
	end	
	
	def update
		@logic=Logic.new
		execute_logic( JSON.parse(params[:json]) )
		Profile.find_by(link: params[:link].strip)
			.update_attribute(:json,@logic.json.to_json)
		render :text => "done"
	end
private
	
	def render_response(json)
		if params[:result_only]=='true'		
			render json: JSON.pretty_generate(json["result"])
		else	
			render json: JSON.pretty_generate(json)
		end
	end

	def execute_logic(hash)
		@logic.json=hash
		@logic.picture
		@logic.first_name
		@logic.last_name
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
