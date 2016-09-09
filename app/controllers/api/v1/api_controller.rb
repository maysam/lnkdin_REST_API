class Api::V1::ApiController < ApplicationController
	

	def generate
		@profile=Profile.find_or_create_by(link:params[:link])
		priority = params[:priority].nil? ? 1 : params[:priority]
		PriorityQueue.instance << Element.new(params[:link], priority)
		LinkedinScrapperJob.new.perform(@profile.id)
		loop do
		@profile.reload
			if @profile.json
				render_response( JSON.parse(@profile.json) )
				break
			end
		end
	end	

private
	
	def render_response(json)
		if params[:result_only]	
			render json: JSON.pretty_generate(json.first[1]["result"])
		else	
			render json: JSON.pretty_generate(json)
		end
	end

end
