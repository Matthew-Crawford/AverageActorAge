require 'open-uri'
require 'rss'

url = 'http://www.fandango.com/rss/top10boxoffice.rss'
movie_titles = []
open(url) do |rss|
	feed = RSS::Parser.parse(rss)
	movie_titles = []
	feed.items.each do |item|
		if item == feed.items.last
			break
		end
		box_office = item.title.split(" ")
		title = []
		count = 0
		box_office.each do |element|
			if count == 0
				count += 1
				next
			elsif count == 1
				title << element
			elsif count > 1
				if element[0] == '$' and element[-1] == 'M'
					break
				else
					title << element
				end
			end
			count += 1
		end
		title_string = ""
		title.each do |element|
			if element == title.last
				title_string += element
				break
			end
			title_string += element + " "
		end
		movie_titles << title_string
	end
	puts movie_titles
	puts movie_titles.class
end

# open('top10boxoffice.rss', 'wb') do |file| 
# 	file << open('http://www.fandango.com/rss/top10boxoffice.rss').read
# end