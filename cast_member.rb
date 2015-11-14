require 'Date'
class Cast_Member
	attr_accessor :name, :dob_day, :dob_month, :dob_year, :movie

	def initialize(name, dob_year, dob_month, dob_day, movie)
		@name = name
		@dob_day = dob_day
		@dob_month = Date::MONTHNAMES.index(dob_month) 
		@dob_year = dob_year
		@movie = movie
	end

	def calculate_age
		now = DateTime.now
		dob = DateTime.new(dob_year.to_i, dob_month.to_i, dob_day.to_i)
		age = now.year - dob.year
		age -= 1 if now.yday < dob.yday
		return age
	end	

	def display_age
		puts calculate_age
	end
end

# simple unit test to test correct age
def test_calculate_age

	cast_member = Cast_Member.new(1994, "November", 14, "storm of war")
	cast_member.calculate_age
	cast_member.display_age

	cast_member = Cast_Member.new(1994, "January", 26, "Life of Matthew")
	cast_member.calculate_age
	cast_member.display_age
end
