class LinkedinScrapperJob < ActiveJob::Base
  queue_as :default

  def perform(profile_id)
	   profile=Profile.find(profile_id)
		 until result=PriorityQueue.instance.exist?(profile.link)	
			 sleep 1
			 puts 'closure in job'
		 end
		 profile.update_attribute(:json, result)
  end


end
