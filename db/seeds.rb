# create a dictionary and populate it with words
beginning_time = Time.now

dictionary = Dictionary.create!(title: "test dictionary")

path = File.join(Rails.root, 'lib', 'assets', 'words')

File.open(path, "r") do |f|
  ActiveRecord::Base.transaction do
    f.each_line do |line|
      if Word.create(word: line.upcase.chomp, dictionary: dictionary).valid?
        Word.create!(word: line.upcase.chomp, dictionary: dictionary)
      end
    end
  end
end

end_time = Time.now
puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"


# File.open(path, "r") do |f|
#   lines = File.foreach(path, "r").first(1000)
#   lines.each do |line|
#     Word.create(word: line.upcase.chomp, dictionary: test_dictionary)
#   end
# end

# for first 1000 lines
# in console: Time elapsed 5866.023 milliseconds
# out of console:Time elapsed 1896.884 milliseconds
#the whole things for some reason took Time elapsed 3692237.653 milliseconds
