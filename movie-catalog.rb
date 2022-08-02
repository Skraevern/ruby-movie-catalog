require 'json'

FILE_PATH = "catalog.json"

def save_to_file(data)
  File.open(FILE_PATH, "w+") do |f|
    f << data.to_json
  end
end

def add_movie_and_save(movies, title, rating)
  movies[title.to_sym] = rating.to_sym
  save_to_file(movies)
end

file = File.read(FILE_PATH)
movies = JSON.parse(file)

movies.transform_keys!(&:to_sym)

puts "What would you like to do?"
puts "-- add"
puts "-- update"
puts "-- display"
puts "-- delete"
choice = gets.chomp
  
case choice
  when "add"
    puts "Movie title: "
    title = gets.chomp
    if movies[title.to_sym] != nil
      puts "Error. Movie already listed!"
    else
      puts "Rating: "
      rating = gets.chomp
      add_movie_and_save(movies, title, rating)
      puts "#{title} added with a rating of #{rating}"
    end
  
  when "update"
    puts "Movie title:"
    title = gets.chomp
    if movies[title.to_sym] == nil
      puts "Movie not listed!"
    else 
      puts "Rating: "
      rating = gets.chomp
      add_movie_and_save(movies, title, rating)
      puts "#{title} updated to a rating of #{rating}"
    end
  
  when "display"
    movies.each { |movie, rating| puts "#{movie}: #{rating}" }

  when "delete"
    puts "What movie would you like to delete? "
    title = gets.chomp
    if movies[title.to_sym].nil? 
      puts "Movie does not listed."
    else
      movies.delete(title.to_sym)
      save_to_file(movies)
      puts "Deleted"
    end
  else 
    puts "Error!"
  end