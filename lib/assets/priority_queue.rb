require 'singleton'
require 'net/ssh'
require 'json'
require 'net/ssh/session'


class PriorityQueue
	
	include Singleton	
	
	attr_reader :run
		
  def initialize
    @elements = [nil]
		@results = {}
  end

  def <<(element)
    @elements << element
		bubble_up(@elements.size - 1)
		get_data unless @run
  end

	def bubble_up(index)
		parent_index = (index / 2)
		puts 'works'
		# return if we reach the root element
		return if index <= 1

		# or if the parent is already greater than the child
		return if @elements[parent_index] >= @elements[index]

		# otherwise we exchange the child with the parent
		exchange(index, parent_index)

		# and keep bubbling up
		bubble_up(parent_index)
	end

	def exchange(source, target)
		@elements[source], @elements[target] = @elements[target], @elements[source]
	end

	def pop
		# exchange the root with the last element
		exchange(1, @elements.size - 1)

		# remove the last element of the list
		max = @elements.pop

		# and make sure the tree is ordered again
		bubble_down(1)
		max
	end

	def bubble_down(index)
		child_index = (index * 2)

		# stop if we reach the bottom of the tree
		return if child_index > @elements.size - 1

		# make sure we get the largest child
		not_the_last_element = child_index < @elements.size - 1
		left_element = @elements[child_index]
		right_element = @elements[child_index + 1]
		child_index += 1 if not_the_last_element && right_element > left_element

		# there is no need to continue if the parent element is already bigger
		# then its children
		return if @elements[index] >= @elements[child_index]

		exchange(index, child_index)

		# repeat the process until we reach a point where the parent
		# is larger than its children
	 	bubble_down(child_index)
	end

	def size
		@elements.size
	end

	def open_ssh
		@session = Net::SSH::Session.new('torq.wha.la', 'papa', 'wry135qa')
 		toggle=true
		begin
			@session.open(10)
		rescue =>e
			sleep 3
			print toggle ? "Trying to reconnect" : "."
			toggle=false
			retry
		end
		puts "\nNew connection established"
		puts "IP: #{@session.capture('wget -qO- http://ipecho.net/plain ; echo')}"
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

	def get_data
		@run=true
		#error=nil
		#open_ssh 
		#@logic=Logic.new
		#profiles={}
		while PriorityQueue.instance.size-1>0
			element=PriorityQueue.instance.pop
#			begin
#				output=@session.capture("ruby test.rb #{url}")
#				puts "Switch ip? : #{output.include?('999 =>  for')}"
#				raise "IP blocked" if output.include?('999 =>  for')
#				execute_logic(JSON.parse(output))
#				profiles[url.to_sym]=@logic.json
#			rescue =>e
#				puts error=e.message  
#				puts e.backtrace.inspect
#				profiles
#				if e.message=="IP blocked"
#					@session.capture("sh reboot.sh &")
#					sleep(10)
#					puts 'Switching IP'
#					@session.close
#					puts "Re-open connection"
#					open_ssh
#					retry
#				end	
				test_json=JSON.parse( File.read(Rails.root+'test.json') )
				@results.merge!({
		 			element.name.to_sym => JSON.pretty_generate(test_json)
											 })
		end
		@run=false
	end
	
	def exist?(link)
		@results.delete(link.to_sym) if @results[link.to_sym]
	end	

end



