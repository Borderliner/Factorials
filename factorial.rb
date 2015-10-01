require 'pry'

class Factorial
	
	def initialize(part)
		raise ArgumentError, "\"part\" must be between 0 and 3." if part < 0 or part > 3

		@part = part
		@result = 1
	end

	def start_counting(number)
		n = 1 + @part
		while n < number
			@result *= n
			n += 4
		end
	end

	def get_result
		return @result
	end

	def set_part(part)
		@part = part unless part < 0 or part > 3
	end

	def get_part
		return @part
	end
end

def main

	#Check if user has passed in a number
	raise ArgumentError, "Invalid number of arguments. Please pass in one number to count the factorials." if ARGV.empty? or ARGV.count > 1

	#Set Start Timer
	start_time = Time.now
	puts start_time.strftime("Started at %H:%M:%S on %A, %B %d of %Y")

	#Initialize Factorials
	factorials = Array.new
	
	4.times do |i|
		factorials[i] = Factorial.new(i)
	end

	#Initialize Threads, and start counting
	must_count = ARGV[0].to_i
	threads = Array.new

	4.times do |i|
		threads[i] = Thread.new{factorials[i].start_counting(must_count)}
	end

	#Join the threads and multiply all the answers
	threads.each do |thread|
		thread.join
	end

	final_result = 1
	factorials.each do |factorial|
		final_result *= factorial.get_result
	end

	#Set End Time and calculate overall duration
	end_time = Time.now
	puts end_time.strftime("Ended at %H:%M:%S on %A, %B %d of %Y")
	puts ''
	total_time = end_time - start_time
	puts "Calculation took #{total_time} seconds, or #{total_time / 60} minutes!"

	#Write everything to file named result.txt
	File.open('result.txt', 'w') { |file|
		file << final_result
		file.close
	}

end

#Call Main Method
main