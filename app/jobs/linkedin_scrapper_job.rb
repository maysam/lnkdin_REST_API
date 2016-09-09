class LinkedinScrapperJob < ActiveJob::Base
  queue_as :default

  def perform(profile_id)
	   profile=Profile.find(profile_id)
		 loop do
			 result=PriorityQueue.instance.exist?(profile.link) 
			 if result
				profile.update_attribute(:json, result)
				break
			 end
		 end	
  end


end
