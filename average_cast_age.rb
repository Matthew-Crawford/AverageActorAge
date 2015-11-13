require 'open-uri'
open('top10boxoffice.rss', 'wb') do |file| 
	file << open('http://www.fandango.com/rss/top10boxoffice.rss').read
end