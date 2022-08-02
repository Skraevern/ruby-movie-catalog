require 'json'

FILE_PATH = "catalog.json"

# def load
#   data = nil
#   File.open(FILE_PATH) do |f|
#     data = JSON.parse(f.read)
#   end
#   data
# end



def save(data)
  File.open(FILE_PATH, "w+") do |f|
    f << data.to_json
  end
end

# def process
#   catalog = load

#   p catalog

#   catalog["Memento"] = 3
#   save(catalog)
# end

# process
# # => {"Memento"=>3, "Primer"=>4, "Ishtar"=>1}
# catalog = load

# p catalog
# {"Memento"=>4, "Primer"=>4, "Ishtar"=>1}
# movies = catalog
file = File.read(FILE_PATH)
movies = JSON.parse(file)
#puts movies[:lars]

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
    puts "Rating: "
    rating = gets.chomp
    if movies[title.to_sym] == nil
      movies[title.to_sym] = rating.to_i
      save(movies)
      puts "#{title} added with a rating of #{rating}"
    else 
      puts "Error. Movie already listed!"
    end
  
  when "update"
    puts "Movie title:"
    title = gets.chomp
    if movies[title.to_sym] == nil
      puts "Movie not listed!"
    else 
      puts "Rating: "
      rating = gets.chomp
      movies[title.to_sym] = rating.to_i
      puts "#{title} updated to a rating of #{rating}"
      save(movies)
    end
  
  when "display"
    movies.each { |movie, rating| puts "#{movie}: #{rating}" }

  when "delete"
    puts "What movie would you like to delete? "
    title = gets.chomp
    if movies[title.to_sym].nil? 
      puts "That movie does not exist."
    else
      movies.delete(title.to_sym)
      puts "Deleted"
    end
  else 
    puts "Error!"
  end