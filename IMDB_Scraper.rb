# IMDB_Scraper.rb
# A web scraping program that searches IMDB for movies
# currently in theaters and retrieves the age of each
# cast member for each movie

require 'mechanize'
require 'ruby-progressbar'
require_relative 'cast_member'
require_relative 'movie'

# A web scraper that scrapes IMDB  
class IMDB_Scraper

	attr_accessor :scraper

	# Default url's 
	BASE_URL = 'http://www.imdb.com/'
	IN_THEATERS = 'http://www.imdb.com/movies-in-theaters'

	def initialize(scraper = Mechanize.new)

		# Instantiates a mechanize object which provides web scraping functionality
		@scraper = scraper

		# Sleeps for .2 seconds every time the scraper does an action
		@scraper.history_added = Proc.new { sleep 0.2 }
	end	


	# finds all movies currently in theaters
	def get_movies_in_theaters
		movie_links = []
		scraper.get(IN_THEATERS) do |page|
			movies_raw = page.search('td.overview-top')
			movies_raw.each do |movie_link|
				link = movie_link.search('h4').css('a')[0]
				movie = Movie.new(link.attributes['title'].value, 
					link.attributes['href'].value)
				movie_links << movie
			end
		end
		return movie_links
	end

	# goes to each movie page and instantiates a movie object for each
	# movie showing in theaters
	def go_to_movie_page(links)
		links.each do |movie|
			full_cast_page = movie.link.link_with(text: 'See full cast').click
			full_cast_page.search('td.itemprop').each do |cast_list|
				cast_member_name = cast_member_link.text
				cast_member_link = cast_list.css('a')[0]
				cast_member = Cast_member.new(cast_member_name, cast_member_link)
				
			end
		end
	end	

end