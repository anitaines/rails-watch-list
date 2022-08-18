# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"

url = "https://tmdb.lewagon.com/movie/top_rated"

website = URI.open(url).read
parsed_info = JSON.parse(website)

# p parsed_info["results"][0]["original_title"]
# p parsed_info["results"][0]["overview"]
# p parsed_info["results"][0]["vote_average"]

if !parsed_info["results"].size.zero?
  puts "Cleaning database..."
  Movie.destroy_all
  puts "Creating Movies..."

  parsed_info["results"].each do |movie|
    Movie.create(title: movie["original_title"], overview: movie["overview"], poster_url: movie["poster_path"], rating: movie["vote_average"])

    puts "#{movie["original_title"]} created"
  end

else
  puts "No data found in API"
end

puts "Proccess finished"

# WHERE IS THE DB???????????