class Logic

	require 'after_the_deadline'
 	require_relative 'normdist'

	attr_reader :result
	attr_accessor :json

	include Normdist

	def initialize
	  @result={}
	  @all_companies=[]
	end

	def json=(hash)
	  @result={}
	  @json=hash
	  @all_companies=@json["current_companies"]+@json["past_companies"]
	  grammar_checking
	end

	def title_score
		values=[]
	  values=if @json["title"]
	  	case @json["title"].length
				when 71..80
					["90","Format and length of your profile tagline are close to optimal and can be further maximized. You furthermore want to include long tail keywords that recruiters would use when searching on linkedin for candidates of new job positions that are of interest to you.","Length looking good, validate the content."]
				when 61..70
					["80","Format and length of your profile tagline can be optimized. You furthermore want to include long tail keywords that recruiters would use when searching on linkedin for candidates of new job positions that are of interest to you.","Try to optimize length and content of the headline."]
				when 51..60
					["70","Format and length of your profile tagline should be optimized. You furthermore want to include long tail keywords that recruiters would use when searching on linkedin for candidates of new job positions that are of interest to you.","Try to optimize length and content of the headline."]
				when 41..50
					["60","Format and length of your profile tagline can be improved. You furthermore want to include long tail keywords that recruiters would use when searching on linkedin for candidates of new job positions that are of interest to you.","Try to optimize length and content of the headline."]
				when 31..40
					["50","Format and length of your profile tagline should be improved. You furthermore want to include long tail keywords that recruiters would use when searching on linkedin for candidates of new job positions that are of interest to you.","Try to optimize length and content of the headline."]
				when 21..30
					["40","Format and length of your profile tagline should be improved. You furthermore want to include long tail keywords that recruiters would use when searching on linkedin for candidates of new job positions that are of interest to you.","Try to optimize length and content of the headline."]
				when 11..20
					["10","Format and length of your profile tagline need improvement. You furthermore want to include long tail keywords that recruiters would use when searching on linkedin for candidates of new job positions that are of interest to you.","Try to optimize length and content of the headline."]
				when 0..10
					["0","Format and length of your profile tagline need improvement. You furthermore want to include long tail keywords that recruiters would use when searching on linkedin for candidates of new job positions that are of interest to you.","Try to optimize length and content of the headline."]
				else
					["100","Congratulation, format and length of your profile tagline are optimal and fully utilized. You might want to review the content and make sure that you included the long tail keywords that recruiters would use when searching on linkedin for candidates of new job positions that are of interest to you.","Length looking good, validate the content."]
			end
		else
					["0","Error #1383 occurred. Please note the error code and inform us via contact form. Many thanks for your help and we apologize for the inconvenience caused.","Error #1383 occurred. Please inform us about this error."]
		end
		add_tag(__method__,values, @json["title"].length)
	end

	def summary_score
		values=[]
		values=if @json["summary"]
		nr_sum_chars = @json["summary"].length
				case @json["summary"].length
					when 1250..1350
						["10","Format and length of your profile summary section must be improved. A typical recruiter skips your summary as it is too overwhelming to read. The purpose of this summary is to motivate the reader to read the rest of your profile. Around 700 characters is the sweet spot that you want to aim for - Short enough to be attractive to read and long enough to sell your content. Your summary currently counts #{nr_sum_chars} characters. We would be pleased to write a compelling summary for you. Please check out our offerings at the end of this page.","The length of the current summary seems too long (we count between 1250..1350 characters while 650..899 wold be optimal). Please summarize the key message of the profile and bring them in a logical order."]

					when 1150..1249
						["20","Format and length of your profile summary section needs to be improved. A typical recruiter would skip your summary as it is too overwhelming to read. The purpose of this summary is to motivate the reader to read the rest of your profile. Around 700 characters is the sweet spot that you want to aim for - Short enough to be attractive to read and long enough to sell your content. Your summary currently counts #{nr_sum_chars} characters. We would be pleased to write a compelling summary for you. Please check out our offerings at the end of this page.","The length of the current summary seems too long (we count between 1150..1249  characters while 650..899 wold be optimal). Please summarize the key messages of the profile and bring them in a logical order."]

					when 1050..1149
						["50","Format and length of your profile summary section can be improved. A typical recruiter is very likely to skip your summary as it is too overwhelming to read. The purpose of this summary is to motivate the reader to read the rest of your profile. Around 700 characters is the sweet spot that you want to aim for - Short enough to be attractive to read and long enough to sell your content. Your summary currently counts #{nr_sum_chars} characters. We would be pleased to write a compelling summary for you. Please check out our offerings at the end of this page.","The length of the current summary seems too long (we count between 1050..1149  characters while 650..899 wold be optimal). Please summarize the key messages of the profile and bring them in a logical order."]

					when 900..1049
						["80","Format and length of your profile summary section is close to optimal. A typical recruiter might skip your summary as it is too overwhelming to read. The purpose of this summary is to motivate the reader to read the rest of your profile. Around 700 characters is the sweet spot that you want to aim for - Short enough to be attractive to read and long enough to sell your content. Your summary currently counts #{nr_sum_chars} characters. We would be pleased to write a compelling summary for you. Please check out our offerings at the end of this page.","The length of the current summary seems to be on the upper end (we count between 900..1049  characters while 650..899 wold be optimal). Please summarize the key messages of the profile and bring them in a logical order."]

					when 650..899
						["100","Congratulation, format and length of your profile summary section is optimal. A typical recruiter will assess your summary length as short enough to be attractive to read and long enough to get a clear overview about your profile.","The length of the current summary seems to be perfect (we count between 650..899 characters which is optimal). Please ensure that the content summarize the key messages of the profile and bring them in a logical order."]

					when 500..649
						["80","Format and length of your profile summary section is close to optimal. You might want to increase the content of your summary for another paragraph allowing a typical recruiter to get a clear overview about your profile. The purpose of this summary is to motivate the reader to read the rest of your profile. Around 700 characters is the sweet spot that you want to aim for - Short enough to be attractive to read and long enough to sell your content. Your summary currently counts #{nr_sum_chars} characters. We would be pleased to write a compelling summary for you. Please check out our offerings at the end of this page.","The length of the current summary seems to be on the lower end (we count between 500..649 characters while 650..899 wold be optimal). Please review the key messages of the profile, slightliy increase the length and bring them in a logical order."]

					when 400..499
						["50","Format and length of your profile summary section can be improved. You want to increase the content of your summary allowing a typical recruiter to get a clear overview about your profile. The purpose of this summary is to motivate the reader to read the rest of your profile. Around 700 characters is the sweet spot that you want to aim for - Short enough to be attractive to read and long enough to sell your content. Your summary currently counts #{nr_sum_chars} characters. We would be pleased to write a compelling summary for you. Please check out our offerings at the end of this page.","The length of the current summary seems to be too low (we count between 400..499 characters while 650..899 wold be optimal). Please review the key messages of the profile, increase the length and bring them in a logical order."]

					when 300..399
						["20","Format and length of your profile summary section needs to be improved. You want to increase the content of your summary allowing a typical recruiter to get a clear overview about your profile. The purpose of this summary is to motivate the reader to read the rest of your profile. Around 700 characters is the sweet spot that you want to aim for - Short enough to be attractive to read and long enough to sell your content. Your summary currently counts #{nr_sum_chars} characters. We would be pleased to write a compelling summary for you. Please check out our offerings at the end of this page.","The length of the current summary seems to be too low (we count between 300..399 characters while 650..899 wold be optimal). Please review the key messages of the profile, increase the length and bring them in a logical order."]

					when 200..299
						["10","Format and length of your profile summary section must be improved. You want to increase the content of your summary allowing a typical recruiter to get a clear overview about your profile. The purpose of this summary is to motivate the reader to read the rest of your profile. Around 700 characters is the sweet spot that you want to aim for - Short enough to be attractive to read and long enough to sell your content. Your summary currently counts #{nr_sum_chars} characters. We would be pleased to write a compelling summary for you. Please check out our offerings at the end of this page.","The length of the current summary seems to be too low (we count between 200..299 characters while 650..899 wold be optimal). Please review the key messages of the profile, increase the length and bring them in a logical order."]

					when 5..199
						["5","Format and length of your profile summary section are minimalistic and must be improved. You want to increase the content of your summary allowing a typical recruiter to get a clear overview about your profile. The purpose of this summary is to motivate the reader to read the rest of your profile. Around 700 characters is the sweet spot that you want to aim for - Short enough to be attractive to read and long enough to sell your content. Your summary currently counts #{nr_sum_chars} characters. We would be pleased to write a compelling summary for you. Please check out our offerings at the end of this page.","The length of the current summary seems to be too low (we count between 200..299 characters while 650..899 wold be optimal). Please review the key messages of the profile, increase the length and bring them in a logical order."]

					when 0..5
						["0","You want to have a summary allowing a typical recruiter to get a clear overview about your profile. The purpose of this summary is to motivate the reader to read the rest of your profile. Around 700 characters is the sweet spot that you want to aim for - Short enough to be attractive to read and long enough to sell your content. Your summary currently counts #{nr_sum_chars} characters. We would be pleased to write a compelling summary for you. Please check out our offerings at the end of this page.","The length of the current summary seems to be too low (we count between 200..299 characters while 650..899 wold be optimal). Please review the key messages of the profile, increase the length and bring them in a logical order."]

					else
						["0","Format and length of your profile summary section must be improved. A typical recruiter skips your summary as it is too overwhelming to read. The purpose of this summary is to motivate the reader to read the rest of your profile. Around 700 characters is the sweet spot that you want to aim for - Short enough to be attractive to read and long enough to sell your content. Your summary currently counts #{nr_sum_chars} characters. We would be pleased to write a compelling summary for you. Please check out our offerings at the end of this page.","The length of the current summary seems too long (we count between 1250..1350 characters while 650..899 wold be optimal). Please summarize the key message of the profile and bring them in a logical order."]
				end
			else
				["0","Error #1383 occurred. Please note the error code and inform us via contact form. Many thanks for your help and we apologize for the inconvenience caused.","Error #1383 occurred. Please inform us about this error."]
			end
		add_tag(__method__,values)
	end

	def summary_contact_score
		values=[]
		values=if @json["summary"]=~/([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+/i
			['100','Contratulations, your summary contains your contact details allowing recruiters to directly contact you.','No action required.']
			else
			['0','Your summary is lacking on further contact details.','Include the candidates email address at the end of the summary together with a call for action.']
		end
		add_tag(__method__,values, @json["summary"]=~/([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+/i)
	end

	def linkedin_url_score
		values=[]
	 	@json["linkedin_url"][/https:\/\/(.*).linkedin.com\/in\/(.*\d+)/]
			values=if Regexp.last_match(2)
				['0','The URL of your linkedin profile link is not personalized making it difficult for people to find you via search engines.','No action required.']
			else
				['100','Your LinkedIn profile URL is personalized making it easy for people to find you via search engines.','No action required.']
			end
		add_tag(__method__,values,Regexp.last_match(2))
	end

	def number_of_connections_score
		values=[]
		nr_connections = @json["number_of_connections"][/\d+/].to_i
		values=case @json["number_of_connections"][/\d+/].to_i
			when 400..499
				["50","Your profile shows a good connected professional. However, it is important that you increase your reach from #{nr_connections} to 500+ connectins as this will clearly underline your subject matter expertise.","No action required."]

			when 300..399
				["20","Your profile shows an average number of connections. It is important that you increase your reach from #{nr_connections} to 500+ connectins as this will clearly underline your subject matter expertise. Exceptional professionals are known by many people and as such the number of connections shown in your profile can be seen as an indicator.","No action required."]

			when 200..299
				["10","The number of connections of your profile is weak. It is important that you increase your reach from #{nr_connections} to 500+ connectins as this will clearly underline your subject matter expertise. Exceptional professionals are known by many people and as such the number of connections shown in your profile can be seen as an indicator.","No action required."]

			when 100..199
				["5","The number of connections of your profile is weak. It is important that you increase your reach from #{nr_connections} to 500+ connectins as this will clearly underline your subject matter expertise. Exceptional professionals are known by many people and as such the number of connections shown in your profile can be seen as an indicator.","No action required."]

			when 0..99
				["0","The number of connections of your profile is weak. it is important that you increase your reach from #{nr_connections} to 500+ connectins as this will clearly underline your subject matter expertise. Exceptional professionals are known by many people and as such the number of connections shown in your profile can be seen as an indicator.","No action required."]

			else
				["100","Congratulations, your profile clearly shows a recruiter a well connected professional. Keep adding and maintaining connections.","No action required."]
		end
		add_tag(__method__,values, @json["number_of_connections"][/\d+/].to_i)
	end

	def skills_score
		values=[]
		nr_of_scills = @json["skills"].count
		values=case @json["skills"].count
		when 20..29
			["80","Your profile shows a skilled professional (#{nr_of_scills} listed skilles) however you could improve adding more skills. Also keep seeking endorsements for your skills, especially from other professionals with strong profiles.","No action required."]

		when 10..19
			["65","Your profile shows some professional skills (#{nr_of_scills} listed skilles) however you can increase impact by adding more relevant skills. Also seek for more skill endorsements, especially from other professionals with strong profiles.","No action required."]

		when 5..9
			["40","Your shown skillset is weak (#{nr_of_scills} listed skilles). You can substancially increase the impact of your profile by adding more relevant skills. Also seek for more skill endorsements, especially from other professionals with strong profiles.","No action required."]

		when 1..4
			["20","Your shown skillset is very weak (#{nr_of_scills} listed skilles).  You can substancially increase the impact of your profile by adding more relevant skills. Also seek for more skill endorsements, especially from other professionals with strong profiles.","No action required."]

		when 0
			["0","Your shown skillset is very weak (#{nr_of_scills} listed skilles). You can substancially increase the impact of your profile by start adding relevant skills and seek skill endorsements, especially from other professionals with strong profiles.","No action required."]

		else
			["100","Contratulation, your profile clearly shows a skilled professional with #{nr_of_scills} listed skilles. Keep seeking endorsements for your skills, especially from other professionals with strong profiles.","No action required."]
		end
		add_tag(__method__,values,@json["skills"].count)
	end

	def picture
	  result['picture'] = @json['picture'] ? @json['picture'] : nil
	end

	def first_name
	  result['first_name'] = @json['first_name'] ? @json['first_name'] : nil
	end

	def last_name
	  result['last_name'] = @json['last_name'] ? @json['last_name'] : nil
	end

	def location
	  result['location'] = @json['country'] ? @json['country'] : nil
	end

	def industry
	  result['industry'] = @json['industry'] ? @json['industry'] : nil
	end

	def groups_score
		values=[]
		nr_of_groups=@json["groups"].count
		values=case @json["groups"].count
			when 4..6
				["80","Active participation in relevant groups is key to underline your subject matter expertise. Your profile shows that you are connected to #{nr_of_groups} relevant groups. However in order to increase the impact of your profile you should connect to more relevant groups of your profession. Also increase your participation in those groups.","No action required."]

			when 1..3
				["40","Active participation in relevant groups is key to underline your subject matter expertise. The number of grops that you are connected to is weak (#{nr_of_groups} groups). You can substancially increase the impact of your profile by connecting to more and relevant gourps that you actively participate.  ","No action required."]

			when 0
				["0","Active participation in relevant groups is key to underline your subject matter expertise. Your group participation is weak (#{nr_of_groups} groups). Start now connecting to relevant gourps that you actively participate.","No action required."]

			else
				["100","Congratulations, you understood that active participation in relevant groups is key to underline your subject matter expertise. Your profile clearly shows that you are well connected (#{nr_of_groups} groups). Keep up your participation in those groups.","No action required."]
		end
		add_tag(__method__,values,@json["groups"].count)
	end

	def organizations_score
		values=[]
		nr_of_organ=@json["organizations"].count
		values=case @json["organizations"].count
			when 1..2
				["50","Active participation in relevant organizations is key to underline your interest outside of work and ability to run the extra mile. Your profile shows active participation in #{nr_of_organ} organization(s).","No action required."]

			when 0
				["0","Active participation in relevant organizations is key to underline your interest outside of work and ability to run the extra mile. You profile is weak in that respect. Try to get member in 1-2 organizations to strengthen your overall profile.","No action required."]

			else
				["100","Congratulations, you understood that active participation in relevant organizations is key to underline your interest outside of work and ability to run the extra mile. Your profile clearly shows active participation in #{nr_of_organ} organizations.","No action required."]
		end
		add_tag(__method__,values,@json["organizations"].count)
	end

	def average_title_score
  	values=[]
  	checking_value="User don't have any company in his profile"
  	unless @all_companies.count==0
  		checking_value=@all_companies.map{|a| a["title"]}.join.length/@all_companies.count
			values=case checking_value
				when 40..49
					["80","Format and length of your job position taglines is close to optimal and can be slightly improved. You furthermore want to include domain knowledge keywords that you want your profile to show up when recruiters search for such knowledge or skillset.","The length of the position title inside the current and past employers seem to be close to optimal (we count 40-49 characters and the optimum is 50 and above characters). Please check the content and structure and optimize if required. Try to increase the title length of all position titles to 50 characters if possible."]

				when 30..39
					["60","Format and length of your job position taglines can be impoved. You furthermore want to include domain knowledge keywords that you want your profile to show up when recruiters search for such knowledge or skillset.","The length of the position title inside the current and past employers seem to be on the lower end (we count 30-39 characters and the optimum is 50 and above characters). Please check the content and structure and optimize if required. Try to increase the title length of all position titles to 50 characters if possible."]

				when 20..29
					["40","Format and length of your job position taglines needs to be impoved. You furthermore want to include domain knowledge keywords that you want your profile to show up when recruiters search for such knowledge or skillset.","The length of the position title inside the current and past employers seem to be low (we count 20-29 characters and the optimum is 50 and above characters). Please check the content and structure and optimize if required. Try to increase the title length of all position titles to 50 characters if possible."]

				when 10..19
					["20","Format and length of your job position taglines must be impoved. You furthermore want to include domain knowledge keywords that you want your profile to show up when recruiters search for such knowledge or skillset.","The length of the position title inside the current and past employers seem to be very low (we count 10-19 characters and the optimum is 50 and above characters). Please check the content and structure and optimize if required. Try to increase the title length of all position titles to 50 characters if possible."]

				when 0..9
					["0","Format and length of your job position taglines is weak and must be impoved. You furthermore want to include domain knowledge keywords that you want your profile to show up when recruiters search for such knowledge or skillset.","The length of the position title inside the current and past employers seem to be very low (we count 0-9 characters and the optimum is 50 and above characters). Please check the content and structure and optimize if required. Increase the title length of all position titles to 50 characters if possible."]

				else
	 				["100","Congratulations, the format and length of your job position taglines are optimal. You might want to review and ensure that you included in your titles the right domain knowledge keywords for which you want recruiters to find you.","The length of the position title inside the current and past employers seem to be optimal (50 and above characters). Please check the content and structure and optimize if required without reducing the length."]
			end
		end
		add_tag(__method__,values,checking_value)
	end

	def average_description_score
		values=[]
		checking_value="User don't have any company in his profile"
		unless @all_companies.count==0
			checking_value=@all_companies.map{|a| a["description"]}.join.length/@all_companies.count
			values=case checking_value
				when 1250..1350
					["10","Format and length of your job position descriptions must be improved.","The average length of the position descriptions inside the current and past employers are too long (we count 1250-1350 characters and the optimum is between 650-899 characters). Please summarize the key achivements and resposibilities in a lean and structured way using bullet points like ►or ●. Try to get the length of all descriptions close to 650 characters."]

				when 1150..1249
					["20","1150-1249: Format and length of your job position descriptions needs to be improved.","The average length of the position descriptions inside the current and past employers are too long (we count 1150-1250 characters and the optimum is between 650-899 characters). Please summarize the key achivements and resposibilities in a lean and structured way using bullet points like ►or ●. Try to get the length of all descriptions close to 650 characters."]

				when 1050..1149
					["50","Format and length of your job position descriptions can be improved.","The average length of the position descriptions inside the current and past employers are too long (we count 1050-1150 characters and the optimum is between 650-899 characters). Please summarize the key achivements and resposibilities in a lean and structured way using bullet points like ►or ●. Try to get the length of all descriptions close to 650 characters."]

				when 900..1049
					["80","Format and length of your job position descriptions is close to optimal and can be improved.","The average length of the position descriptions inside the current and past employers are too long (we count 900-1050 characters and the optimum is between 650-899 characters). Please summarize the key achivements and resposibilities in a lean and structured way using bullet points like ►or ●. Try to get the length of all descriptions close to 650 characters."]

				when 650..899
					["100","Congratulations, format and length of your job position descriptions is optimal.","The average length of the position descriptions inside the current and past employers seem to be optimal (650-899 characters). Please focus on the content and ensure that the key achivements and resposibilities are summarized in a lean and structured way using bullet points like ►or ●. Try to keep the length of all descriptions close to 650 characters."]

				when 500..649
					["80","Format and length of your job position descriptions is close to optimal and can be improved.","The average length of the position descriptions inside the current and past employers are at the lower end (we count 500-649 characters and the optimum is between 650-899 characters). Please summarize the key achivements and resposibilities in a lean and structured way using bullet points like ►or ●. Try to increase the length of all descriptions close to 650 characters."]

				when 400..499
					["50","Format and length of your job position descriptions can be improved.","The average length of the position descriptions inside the current and past employers are low (we count 400-500 characters and the optimum is between 650-899 characters). Please summarize the key achivements and resposibilities in a lean and structured way using bullet points like ►or ●. Try to increase the length of all descriptions close to 650 characters."]

				when 300..399
					["20","1150-1249: Format and length of your job position descriptions needs to be improved.","The average length of the position descriptions inside the current and past employers are too low (we count 300-400 characters and the optimum is between 650-899 characters). Please summarize the key achivements and resposibilities in a lean and structured way using bullet points like ►or ●. Increase the length of all descriptions close to 650 characters."]

				when 200..299
					["10","Format and length of your job position descriptions must be improved.","The average length of the position descriptions inside the current and past employers are too low (we count 200-300 characters and the optimum is between 650-899 characters). Please summarize the key achivements and resposibilities in a lean and structured way using bullet points like ►or ●. Increase the length of all descriptions close to 650 characters."]

				else
					["0","Format and length of your job position descriptions is weak and must be improved.","The average length of the position descriptions inside the current and past employers are either much too low or much to high (the optimum number of characters are between 650-899). Please summarize the key achivements and resposibilities in a lean and structured way using bullet points like ►or ●. Increase or decrease the length of all descriptions close to 650 characters."]
			end
		end
		add_tag(__method__,values,checking_value)
	end

	def average_bullet_points_score
		values=[]
  	bullet_points=find_bullet_points(@all_companies.map{|a| a["description"]}.join)
  	checking_value="User don't have any company in his profile"
  	unless @all_companies.count==0
  		checking_value=bullet_points/@all_companies.count
			values=case checking_value
				when 8..10
					["50", "The number of bullet points used in your job position descriptions are too high (#{checking_value} bullet points in average) and a reader might be overwealmed and skip reading. Reduce the number of used bullet points for the benefit of short and targeted key messages.", "We count that the average number of bullet points used in the job position descriptions are high. Ensure that the candidate has at least 4-7 bullet points clearly stating his achivements and responsibilities per position. Most impressive achivements first. Use the same bullet points in all descriptions (either ► or ●)"]

				when 4..7
					["100", "Congratulation, the number of bullet points used in your job position descriptions are optimal (#{checking_value} bullet points in average). You found the right balance of focussing on the relevant and providing enough content.", "We count that the average number of bullet points used in the job position descriptions are optimal. Focus on the content and ensure that the candidate has at least 4-7 bullet points clearly stating his achivements and responsibilities per position. Most impressive achivements first. Use the same bullet points in all descriptions (either ► or ●)"]

				when 1..3
					["50", "The number of bullet points used in your job position descriptions are low (#{checking_value} bullet points in average) and should be increased for the benefit of more comprehensive and targeted key messages.", "We count that the average number of bullet points used in the job position descriptions are rather low. Ensure that the candidate has at least 4-7 bullet points clearly stating his achivements and responsibilities per position. Most impressive achivements first. Use the same bullet points in all descriptions (either ► or ●)"]

				else
					["0", "Using bullet points such as '- ► » ■ ♦ ◆ ● >' to list your achievements is best practise and provides the reader a good structure. You should start takeing advantage of this.", "The position descriptions of this candidate doesn't seem to use bullet points. Help the candidate with some structure and ensure that the candidate has at least 4-7 bullet points clearly stating his achivements and responsibilities per position. Most impressive achivements first. Use the same bullet points in all descriptions (either ► or ●)"]
			end
		end
		add_tag(__method__,values, checking_value)
	end

	def grammar_score
		# Description
			# Iterate through the profile 'title', 'summary' and all position 'title' and 'description' tags and append every text in one single string.
			# Then call up the /stats webservice of the following API in order to get back
			# a XML structure containing the statistics: http://www.afterthedeadline.com/api.slp.
			# Count the number of instances where the <type> tag contains 'grammar' OR 'spell'.
			# Ignor the rest of the values and tags.  Set the new tag 'language_errors_score' accordingly:
		values=[]
		specific_mistakes=get_all_gram_mistakes
		puts "-> #{specific_mistakes}"
		values=case specific_mistakes
			when 6..15
				["30", "#{specific_mistakes} grammar and spelling mistakes have been found in your profile. Find and correct them as readers will recognize grammar and spelling mistakes as a lack of detail.", "Grammar and spelling mistakes have been identifed in the profile. Please let a word spell-check run throught the summary text, any profile titles and any profile descriptions. 0 grammar and spelling mistakes is a must."]
			when 2..5
				["60", "#{specific_mistakes} grammar and spelling mistakes have been found in your profile. Find and correct them as readers will recognize grammar and spelling mistakes as a lack of detail.", "Grammar and spelling mistakes have been identifed in the profile. Please let a word spell-check run throught the summary text, any profile titles and any profile descriptions. 0 grammar and spelling mistakes is a must."]
			when 1
				["80", "#{specific_mistakes} grammar and spelling mistake has been found in your profile. Find and correct it as readers will recognize grammar and spelling mistakes as a lack of detail.", "Grammar and spelling mistakes have been identifed in the profile. Please let a word spell-check run throught the summary text, any profile titles and any profile descriptions. 0 grammar and spelling mistakes is a must."]
			when 0
				["100", "Congratulations, there are no grammar or spelling mistakes in your profile. A great impression is guaranteed.", "No action required."]
			else
				["30", "#{specific_mistakes} grammar and spelling mistakes have been found in your profile. Find and correct them as readers will recognize grammar and spelling mistakes as a lack of detail.", "Many grammar and spelling mistakes have been identifed in the profile. Please let a word spell-check run throught the summary text, any profile titles and any profile descriptions. 0 grammar and spelling mistakes is a must."]
		end
		add_tag(__method__,values,"Number of grammar and spelling mistakes #{specific_mistakes}")
	end

	def passive_language_score
		# Description
			# Same call as above but now count the number of instances where the <type> tag contains 'style' AND the <key> tag
			# contains 'passive voice'. Ignor the rest of the values and tags. Set the new tag 'passive_language_score' accordingly:
		values=[]
		specific_mistakes=get_all_style_and_pass_mistakes
		values=case specific_mistakes
			when 6..15
				["30", "#{specific_mistakes} instances of passive language have been found in your profile. Remember, your profile is a sales tool—and you’re the product. Increase the impact of your profile by strictly using active language.", "6-15 instances of passive language has been identifed in the candidates profile. Please review the summary text, any profile titles and any profile descriptions and turn passive language into active language e.g. in a achivement bullet point ""...sales increased by 15%"" is passive language and you should use strong action words and active languate like ""Increased sales by 15%""."]

			when 2..5
				["60", "#{specific_mistakes} instances of passive language have been found in your profile. Remember, your profile is a sales tool—and you’re the product. Increase the impact of your profile by strictly using active language.", "1-5 instances of passive language has been identifed in the candidates profile. Please review the summary text, any profile titles and any profile descriptions and turn passive language into active language e.g. in a achivement bullet point ""...sales increased by 15%"" is passive language and you should use strong action words and active languate like ""Increased sales by 15%""."]

			when 1
				["80", "#{specific_mistakes} instance of passive language has been found in your profile. Remember, your profile is a sales tool—and you’re the product. Increase the impact of your profile by strictly using active language.", "1-5 instances of passive language has been identifed in the candidates profile. Please review the summary text, any profile titles and any profile descriptions and turn passive language into active language e.g. in a achivement bullet point ""...sales increased by 15%"" is passive language and you should use strong action words and active languate like ""Increased sales by 15%""."]

			when 0
				["100", "Congratulations, no passive language has been found in your profile.", "No action required."]

			else
				["#{specific_mistakes} instances of passive language have been found in your profile. Remember, your profile is a sales tool—and you’re the product. Increase the impact of your profile by using active language.", "Over 15 instances of passive language has been identifed in the candidates profile. Please review the summary text, any profile titles and any profile descriptions and turn passive language into active language e.g. in a achivement bullet point ""...sales increased by 15%"" is passive language and you should use strong action words and active languate like ""Increased sales by 15%""."]
		end
		add_tag(__method__,values,"Number of style or passive voice mistakes #{specific_mistakes}")
	end

	def action_score
		# Description
			# Iterate through all profile 'description' tags and create a list per description of the first word used
			# after a bullet point. List of special characters that can be identified as bullet point: ★ ✪ ✯ ✰☛ ☝ ☞ ☟ ⇨ ► ◄ » ■ ♦ ◆ ●✔ ✘ ☐ ☑ ☒ - > <
			# Set the new tag 'action_score' accordingly:

			# Example:
			# ► Increased sales revenues by 12% within 8 months.
			# -Designed the target operating model of the OTC derivative trading business.
			# ⇨    Coordinated shirt supplieers and decreased average purchase costs by 4%
			# ★ ★ ★  Achivements ★ ★ ★

			# Result list from current job position: ['Increased', 'Designed', 'Coordinated', '★', '★', 'Achivements', '★', '★']
			# Results from e.g. a job position in past: ['Decreased','Management','The','A','Increased','-','*','The']

			# Calculation of the average number of action words used in the job descriptions:
			# Take the first list and count the number of instances in which a word from belwo ACTION WORD LIST is part of the list.
			# Do this for all lists and at the end sum up all numbers and devide into the number of lists.
			# The result will be the average amount of action words used across all job descriptions.
			# If we only would have the 2 lists from the example above then the result would be as follows:

			# List 1: 3
			# List 2: 2
			# Average number of action words used:  2.5
	  values=[]
	  words_amount=0
	  action_word_list=['administered','analyzed','appointed','approved','assigned','attained','authorized','chaired','considered','consolidated','contracted','controlled','converted','coordinated','decided','delegated','developed','directed','eliminated','emphasized','enforced','enhanced','established','executed','generated','handled','headed','hired','hosted','improved','incorporated','increased','initiated','inspected','instituted','led','managed','merged','motivated','organized','originated','overhauled','oversaw','planned','presided','prioritized','produced','recommended','reorganized','replaced','restored','reviewed','scheduled','streamlined','strengthened','supervised','terminated','addressed','advertised','arbitrated','arranged','articulated','authored','clarified','collaborated','communicated','composed','condensed','conferred','consulted','contacted','conveyed','convinced','corresponded','debated','defined','described','developed','directed','discussed','drafted','edited','elicited','enlisted','explained','expressed','formulated','furnished','incorporated','influenced','interacted','interpreted','interviewed','involved','joined','judged','lectured','listened','marketed','mediated','moderated','negotiated','observed','outlined','participated','persuaded','presented','promoted','proposed','publicized','reconciled','recruited','referred','reinforced','reported','resolved','responded','solicited','specified','spoke','suggested','summarized','synthesized','translated','wrote','analyzed','clarified','collected','compared','conducted','critiqued','detected','determined','diagnosed','evaluated','examined','experimented','explored','extracted','formulated','gathered','identified','inspected','interpreted','interviewed','invented','investigated','located','measured','organized','researched','searched','solved','summarized','surveyed','systematized','tested','adapted','assembled','built','calculated','computed','conserved','constructed','converted','debugged','designed','determined','developed','engineered','fabricated','fortified','installed','maintained','operated','overhauled','printed','programmed','rectified','regulated','remodeled','repaired','replaced','restored','solved','specialized','standardized','studied','upgraded','utilized','adapted','advised','clarified','coached','communicated','conducted','coordinated','critiqued','developed','enabled','encouraged','evaluated','explained','facilitated','focused','guided','individualized','informed','instilled','instructed','motivated','persuaded','set','goals','simulated','stimulated','taught','tested','trained','transmitted','tutored','administered','adjusted','allocated','analyzed','appraised','assessed','audited','balanced','calculated','computed','conserved','corrected','determined','developed','estimated','forecasted','managed','marketed','measured','planned','programmed','projected','reconciled','reduced','researched','retrieved','acted','adapted','began','combined','conceptualized','condensed','created','customized','designed','developed','directed','displayed','drew','entertained','established','fashioned','formulated','founded','illustrated','initiated','instituted','integrated','introduced','invented','modeled','modified','originated','performed','photographed','planned','revised','revitalized','shaped','solved','adapted','advocated','aided','answered','arranged','assessed','assisted','cared','for','clarified','coached','collaborated','contributed','cooperated','counseled','demonstrated','diagnosed','educated','encouraged','ensured','expedited','facilitated','familiarize','furthered','guided','helped','insured','intervened','motivated','provided','referred','rehabilitated','presented','resolved','simplified','supplied','supported','volunteered','approved','arranged','cataloged','categorized','charted','classified','coded','collected','compiled','corresponded','distributed','executed','filed','generated','implemented','incorporated','inspected','logged','maintained','monitored','obtained','operated','ordered','organized','prepared','processed','provided','purchased','recorded','registered','reserved','responded','reviewed','routed','scheduled','screened','set','up','submitted','supplied','standardized','systematized','updated','validated','verified','More','verbs','for','Accomplishments','achieved','completed','expanded','exceeded','improved','pioneered','reduced','resolved','restored','spearheaded','succeeded','surpassed','transformed','won']



	  get_description_list #call method that generate @description_list


	  @description_list.each do |description|
	  	 words_after_bp=get_first_words_after_bullet_points(description)
	  	 words_amount+= words_after_bp.select{|word| action_word_list.include?(word)}.length.to_i
	  end

	  ratio=@description_list.length!=0 ? (words_amount/@description_list.length).to_f : nil

	  if ratio
		  values=case ratio
		  	when 1..3
					["20", "#{ratio} -- Recruiters recommended starting your bullets with strong action-oriented words. Some of the most used action-verbs across high scoring profiles are Led, Increased, Managed, Analyzed and Created. This is a best practise and powerful tool that you should adopt and use in a consistent way across all bullet points of your positions.", "The candidates profile shows some achivement bullet points that start with a strong action word. Reveiw and increase the number in every position description and ensure that 4-7 bullet points do highlight the key achivements and that the FIRST word used in each achivement bullet point is a strong action word such as %s"]
					# -> please include the content of ACTION_WORD_LIST inside the placeholder %s

				when 0
					["0", "#{ratio} --- You don't seem to use strong action-oriented words to start an achievement bullet points. Recruiters recommended starting your bullets with strong action-oriented words. Some of the most used action-verbs across high scoring profiles are Led, Increased, Managed, Analyzed and Created. This is a best practise and powerful tool that you should adopt and use in a consistent way across all bullet points of your positions.", "The candidates profile either doesnt contain any bullet points to underline achivements OR the action words used within the bullet points are weak. Ensure that every position description contains 4-7 bullet points highlighting the key achivements and that the FIRST word used in each achivement bullet point is a strong action word such as INCREASED, MANAGED, CREATED, COORDINATED, DECREASED, DESIGNED, SUBMITTED, WROTE, DOCUMENTED ....."]
						# -> please include the content of ACTION_WORD_LIST inside the placeholder %s

				else
					["100", "#{ratio} - Congratulations, recruiters will recognize that you start your bullets with strong action-oriented words demonstrating what you have achieved. Your profile follows that best practise and will be recognized as impactfull. Keep in mind to quantify your achivements if possible.", "The candidates profile show position descriptions that contain bullets starting with strong action words such as  %s Ensure that this is done in a consistant way and that every position description contains 4-7 bullet points highlighting the key achivements and that the FIRST word used in each achivement bullet point is a strong action word"]
			end
		end

		add_tag(__method__,values,"Average number of action words used: #{ratio}. Total amount of action words #{words_amount} in description tags")
	end

	def specifics_score
		#Description
			# Iterate through all profile 'description' tags and count per description the number of times the below stated SPECIFICS
			# characters are used. After that sum up all numbers and devide into the number of descriptions to get the average number of used SPECIFICS.
			# Set the new tag 'specifics_score' accordingly:
			# SPECIFICS_WORD_LIST = ['%','$','USD','SGD','AUD','euro']
		values=[]
		specifics_word_list = ['%','\$','USD','SGD','AUD','euro','per day','per week','per month','per year']
		checking_value="No specific chars was found in description"
		count_specifics_words(specifics_word_list) #call method that generate @description_specifics_array
		unless @description_specifics_array.length==0
			checking_value=@description_specifics_array.inject(:+)/@description_specifics_array.length
			values=case checking_value
				when 1..2
					["50", "#{checking_value} --- >70% of High Scoring Resumes show scope of responsibilities with quantified impact. We have benchmarked your usage of specifics and recommend adding more specifics to showcase the impact/scope of your work.", "Look for more opportunities to quantify achivement bullet points in every job description. E.g. Managed to decrease project costs by 15% or Increased sales volume by 13% within 6 months"]

				when 0
					["0", "#{checking_value} --- >70% of High Scoring Resumes show scope of responsibilities with quantified impact. We have benchmarked your usage of specifics and recommend adding specifics to showcase the impact/scope of your work.", "Look for opportunities to quantify achivement bullet points in every job description. E.g. Managed to decrease project costs by 15% or Increased sales volume by 13% within 6 months"]

				else
					["100", "#{checking_value} --- Congratulations, you belong to the >70% of High Scoring Profiles that show scope of responsibilities with quantified impact.", "It seems that the profile quantifies achivement bullet points more than average. Review the achivement bullet points and ensure that quantifications are done properly and in a consistant manner across all job descriptions. E.g. Managed to decrease project costs by 15% or Increased sales volume by 13% within 6 months"]
			end
		end
		add_tag(__method__,values,checking_value)
	end

	def avoided_words_score
		# Description
			# Iterate through the 'title', 'summary' and all profile 'description' tags and count the number of times the below
			# stated AVOIDED_WORDS words are used. Set the new tag 'avoided_words_score' accordingly:

			# AVOIDED_WORDS = ['just','so','very','realy','and then','but','literally','quite','perhaps','in order','actually','rather','stuff']
		checking_value="No avoided words found"
		total_string="#{@json['title']} #{@json['summary']} #{@description_list.join('. ')}"
		avoided_words = ['just','so','very','realy','and then','but','literally','quite','perhaps','in order','actually','rather','stuff']
		avoided_words_regexp=Regexp.new(avoided_words.map!{|word| '\b'+word+'\b'}.join("|"),Regexp::IGNORECASE)
		matches=total_string.scan(avoided_words_regexp)
		checking_value=matches.uniq.join(',') if matches
		values=case matches.size

			when 2..5
				["40", "Your profile contains #{matches.size} words which are usually considered as filler words or informal language. Strictly avoid those words for the benefit of a formal and direct language.", "The candidate used #{matches.size} avoided words in the summary or in the job descriptions. Please remove those avoided words. Avoided words: #{matches.uniq.join(",")}"]

			when 1
				["60", "Your profile contains #{matches.size} word that is considered as filler words or informal language. Strictly avoid those words for the benefit of a formal and direct language.", "The candidate used #{matches.size} avoided words in the summary or in the job descriptions. Please remove those avoided words. Avoided words: #{matches.uniq.join(",")}"]

			when 0
				["100", "Congratulations, you haven't used any filler words or informal language. Recruiters will recognized you profile as formal.", "Look for opportunities to quantify achivement bullet points in every job description. E.g. Managed to decrease project costs by 15% or Increased sales volume by 13% within 6 months"]

			else
				["0", "Your profile contains #{matches.size} words which are usually considered as filler words or informal language. Strictly avoid those words for the benefit of a formal and direct language.", "The candidate used #{matches.size} avoided words in the summary or in the job descriptions. Please remove those avoided words. Avoided words: #{matches.uniq.join(",")}"]

		end
		checking_value
		add_tag(__method__,values, checking_value)
	end

	def profile_word_cloud
		# Description
			# This rule does not flow into the overall score. The purpose of this rule is to bild up a big string of sentences/words
			# and to discpay that as a wordcloud. There are some wordpress wordcloud plugins that i will be able to use.
			# What i would need is a big string. You  can just include this new 'profile_word_cloud' tag inside the JSON structure.
			# Below rule describes the way how to bild this string.


			# Iterate through below sections and merge all the text to 1 large string and then search and exclude the EXCLUDED_WORDS
			# out of the string. The content of some sections are more important than other sections hence you can replicate the words
			# per section as per below multiplication formula. The Profile Title is most important hence the multiplicator 5.

			# Example of a profile title: ""Senior Project Manager | OTC derivative trading regulatory change | FinReg | Business Transformation""
			# Result string: ""Senior Project Manager | OTC derivative trading regulatory change | FinReg | Business Transformation
			# Senior Project Manager | OTC derivative trading regulatory change | FinReg | Business Transformation
			# Senior Project Manager | OTC derivative trading regulatory change | FinReg | Business Transformation
			# Senior Project Manager | OTC derivative trading regulatory change | FinReg | Business Transformation
			# Senior Project Manager | OTC derivative trading regulatory change | FinReg | Business Transformation""

			# Sections:
			# 5 x Profile Title
			# 3 x Profile Summary
			# 5 x Country
			# 3 x Skills
			# 4 x Current_companies.Description title
			# 3 x Current_companies.Description
			# 1 x Past_companies.Description title
			# 1 x Past_companies.Description

			# EXCLUDED_WORDS=['the','a','an','on','from','for','why','as','at','by','but','for','off','|','?','!','*'] - The list is not complete yet and i'll complete that inside the code at a later stage.
			excluded_words=['the','a','an','on','from','for','why','as','at','by','but','for','off','\|','\?','\!','\*','►']
			current_companies_description=@json['current_companies'].map{|a| a["description"]}.join(' ')
			current_companies_title=@json['current_companies'].map{|a| a["title"]}.join(' ')
			past_companies_description=@json['past_companies'].map{|a| a["description"]}.join(' ')
			past_companies_title=@json['past_companies'].map{|a| a["title"]}.join(' ')
			title=@json['title']*5 if @json['title']
			summary=@json['summary']*3 if @json["summary"]
			country=@json['country']*7 if @json['country']
			skills=@json['skills'].join(' ')*4 if @json['skills']
			cur_descriptions=current_companies_description*3
			cur_title=current_companies_title*4
			big_string="#{title} #{summary} #{country} #{skills} #{cur_descriptions} #{cur_title} #{past_companies_title} #{past_companies_description}"
			excluded_words.each {|word| big_string=big_string.gsub(Regexp.new('\s'+word+'\s'), ' ')}
			result[__method__]=big_string
	end

	def generate
	  @json.merge!({:result=>@result})
	end

	def grade
		# Description
			# 1.) For all rules in the ""Format"" section (see colum 'B'):
			# Multiply every score with its weight (see colum 'G') and build the sum
			# and devide into the number of rules to get the average score.
			# 2.) For all rules in the ""Content"" section: Multiply every score with its weight
			# and build the sum and devide into the number of rules to get the average score.
			# 3.) Build total score: ((40*Format section score)+(60*Content section score))/100
		weight={
			:format => {
				:title_score => "15",
				:summary_score => "15",
				:summary_contact_score => "0",
				:linkedin_url_score => "0",
				:number_of_connections_score => "10",
				:skills_score => "12",
				:groups_score => "2",
				:organizations_score => "2",
				:average_title_score => "15",
				:average_description_score => "15",
				:average_bullet_points_score => "14"
				},
			:content => {
				:grammar_score => "30",
				:passive_language_score => "5",
				:action_score => "20",
				:specifics_score => "15",
				:avoided_words_score => "30"
			}
		}
		values=[]
		format_section_score=weight[:format].map{|k,v| @result[k][:score].to_i*v.to_i}.inject(:+)/100 #weight[:format].size
		content_section_score=weight[:content].map{|k,v| @result[k][:score].to_i*v.to_i}.inject(:+)/100 #weight[:content].size
		@total_score=((40*format_section_score)+(60*content_section_score))/100
		values=case @total_score
			when 0..30
				[ @total_score,"Your Linkedin profile belongs to the bottom performer and needs substantial improvement in several areas. The number of recruiters that land on your profile must be very low. Your profile shows up at the end of a linkedin search result list when recruiters search for candidates that match required hard and soft skills. Your profile is assessed as minimalistic and not optimized. Adjustments in the highlighted forces areas will substantially increase visibility and impact of your profile. You will recognize an increased number of visitors on your profile along with increased recruiter requests."]

			when 31..50
				[ @total_score,"Your Linkedin profile scores below average and needs improvement in several areas. The number of recruiters that land on your profile must be very low. Your profile shows up at the end of a linkedin search result list when recruiters search for candidates that match required hard and soft skills. Your profile is assessed as minimalistic and not optimized. Adjustments in the highlighted forces areas will substantially increase visibility and impact of your profile. You will recognize an increased number of visitors on your profile along with increased recruiter requests."]

			when 50..70
				[ @total_score,"Your Linkedin profile achieved an average score and needs improvement in some areas. The number of recruiters that land on your profile must be very low. Your profile shows up at the end of a linkedin search result list when recruiters search for candidates that match required hard and soft skills. Your profile is assessed as incomplete and not optimized. Adjustments in the highlighted forces areas will substantially increase visibility and impact of your profile. You will recognize an increased number of visitors on your profile along with increased recruiter requests."]

			when 70..87
				[ @total_score,"Your Linkedin profile achieved a good score, however can need improvement in some areas. The number of recruiters that land on your profile must be low. Your profile shows up somewhere in the middle of a linkedin search result list when recruiters search for candidates that match required hard and soft skills. Your profile is assessed as good, however can be optimized. Adjustments in the highlighted forces areas will substantially increase visibility and impact of your profile. You will recognize an increased number of visitors on your profile along with increased recruiter requests."]

			when 88..94
				[ @total_score," ""Cum Laude"" Congratulations! You achieved a very high score. Recruiters and peers find your profile using keywords that match your soft or hard skills. Your profile is assesed as very good. Improvements in the highlighted focus areas will further increase visibility and impact of your profile. Recruiters and peers will acknowledge your profile as the subject matter in your field. You will increasingly be featured in the ""People Also Viewed"" and ""Do you know"" section that will further expand your visibility national wide."]

			when 95..97
				[ @total_score," ""Magna Cum Laude"" Congratulations! You achieved an exceptional high score. Recruiters and peers easily find your profile using keywords matching your soft or hard skills. Your profile certainly is assessed as exceptional. Improvements in the highlighted focus areas will bring you to the top 2.5% and further increase visibility and impact of your profile. Recruiters and peers will acknowledge your profile as the subject matter in your field. You will be featured in the ""People Also Viewed"" and ""Do you know"" section that will further expand your visibility globally."]

			when 98..100
				[ @total_score," ""Summa Cum Laude"" Congratulations! You achieved the highest possible score. Your profile frequently appears on the screens of recruiters and peers within the linkedin network but also outside (e.g. inbound traffic from search engines). LinkedIn users constantly see your profile suggested under ""People Also Viewed"" and ""Do you know"" sections. Your profile appears in the result screen under the top 10 candidates by searching for keywords that match most of your soft or hard skills. There is nothing we can advise you. The mission of our company is to develop clients profiles where your profile is. We would be grateful to win you as an ambassador of our service!"]
		end
		add_tag(__method__,values, @total_score)
	end

	def benchmark
		# Description
			# 	Find the Normal Distribution formula in the Ruby math library. Example of the calculation: http://www.math.ucla.edu/~tom/distributions/normal.html

			# 	x-value = Grade as calculated in above calculation - Total score (variable)
			# 	Mean: 65.5 (static value)
			# 	Standard Dev: 17 (static value)

			# 	result = 1 - Normal Probability
			# 	Example:
			# 	x-value = 75
			# 	Mean: 65.5 (static)
			# 	Standard Dev: 17 (static)

			# 	result = 1 - 0.71186 = 28.8%   -> This means that 28.8% of other candidates score higher than the score of our candidate (75)

			# -> Please replace the #{result} with the calculation result:
		std=17
		mean=65.5
		values=[]

		result=(1-normdist(@total_score,mean,std,true)).round(2)*100
		values=case result
			when 0..2
				[result,"Only #{result} of other candidates scored higher than you."]

			when 3..5
				[result,"Only #{result} of other candidates scored higher than you."]

			when 6..13
				[result,"#{result} of other candidates scored higher than you."]

			when 14..30
				[result,"#{result} of other candidates scored higher than you."]

			when 31..50
				[result,"#{result} of other candidates scored higher than you."]

			when 51..70
				[result,"More than #{result} of other candidates scored higher than you."]

			when 71..100
				[result,"More than #{result} of other candidates scored higher than you."]
		end

		add_tag(__method__,values,result)
	end

private

	def add_tag(tag_name,values,debug='')
		result[tag_name]={score:"",u_text:"",w_text:""}
		result[tag_name].each_with_index{|h,i| result[tag_name][h[0]]=values[i]}
		result[tag_name][:debug]=debug
	end

	def get_description_list
		list=[]
		@json.each do |k,v|
			list<<v if k=='description'
			v.each{|a| list<<a["description"]} if v.class==Array
		end

		@description_list=list.compact
	end

	def get_first_words_after_bullet_points(description)
		list=[]
		description
		bullet_points=%w{★ ✪ ✯ ✰☛ ☝ ☞ ☟ ⇨ ► ◄ » ■ ♦ ◆ ●✔ ✘ ☐ ☑ ☒ - > <}
		bullet_indexes=description.chars.map.with_index {|char,index| index if bullet_points.include?(char)}.compact
		bullet_indexes.each do |index|
			word_after=description.chars[index+1..-1].join[/^\s?\w+/i]
			word_after.strip! if word_after
			list<<word_after
		end
		list
	end

	def count_specifics_words(chars)
		@description_specifics_array=[]
		specific_regexp=Regexp.new(chars.join("|"))
		@description_list.each do |description|
			@description_specifics_array<<description.scan(specific_regexp).size
		end
	end

	def grammar_checking
		AfterTheDeadline(nil,nil)
		whole_profile_content=''
		whole_profile_content="#{@json['summary'].to_s} #{@json['title'].to_s} #{@all_companies.map{|a| a["description"]}.join(' ')} #{@all_companies.map{|a| a["title"]}.join(' ')}"
		begin
			@mistakes=AfterTheDeadline.metrics whole_profile_content
		rescue
			retry
		end
	end

	def get_all_gram_mistakes
		@mistakes.grammar.map{|k,v| v.to_i}.inject(:+)||0
	end

	def get_all_style_and_pass_mistakes
		@mistakes.style['passive voice']||0
	end

	def find_bullet_points(text)
		bullet_points=%w{★ ✪ ✯ ✰☛ ☝ ☞ ☟ ⇨ ► ◄ » ■ ♦ ◆ ●✔ ✘ ☐ ☑ ☒ - > <}
		text.chars.select{|char| bullet_points.include?(char)}.length
	end

end
