require_relative '../db/config'
require_relative '../app/models/legislator'

# Given any state, first print out the senators for that state (sorted by last name), 
# then print out the representatives (also sorted by last name). 
# Include the party affiliation next to the name.

senators = Legislator.where(state: "CA", title: "Sen")
reps = Legislator.where(state: "CA", title: "Rep")
puts "Senators:"
senators.each do |senator|
	if senator.middlename == ""
	  name = senator.firstname + " " + senator.lastname
	elsif senator.middlename != ""
      name = senator.firstname + " " + senator.middlename + " " + senator.lastname
    end 
  letter = senator.party

  puts " #{name} (#{letter})"
end

puts "Representatives:"
reps.each do |rep|
  	if rep.middlename == ""
	  name = rep.firstname + " " + rep.lastname
	elsif rep.middlename != ""
      name = rep.firstname + " " + rep.middlename + " " + rep.lastname
    end 
  letter = rep.party

  puts " #{name} (#{letter})"
end

malesens = Legislator.where(gender: "M", in_office: "1", title: "Sen")
malereps = Legislator.where(gender: "M", in_office: "1", title: "Rep")
total_in_office_sens = Legislator.where(in_office: "1", title: "Sen")
total_in_office_reps = Legislator.where(in_office: "1", title: "Rep")
x = malesens.count.to_i
y = malereps.count.to_i
a = x*100/total_in_office_sens.count.to_i
b = y*100/total_in_office_reps.count.to_i
puts "Male Senators: #{malesens.count} (#{a}%)" 
puts "Male Representatives: #{malereps.count} (#{b}%)" 



active_senators = Legislator.where(in_office: "1", title: "Sen").group(:state).count
sorted_senators = active_senators.sort_by {|_key, value| value}.reverse
p sorted_senators


active_reps = Legislator.where(in_office: "1", title: "Rep").group(:state).count
sorted_reps = active_reps.sort_by {|_key, value| value}.reverse
p sorted_reps

sorted_reps.each_with_index do |rep_array, rep_index|
	puts "#{rep_array[0]}: 2 Senators, #{rep_array[1]} Representative(s)"

end



totalsens = Legislator.where(title: "Sen")
totalreps = Legislator.where(title: "Rep")

puts "Senators: #{totalsens.count}"
puts "Representatives: #{totalreps.count}"


lazysen = Legislator.where(in_office: "0", title: "Sen")
lazyrep = Legislator.where(in_office: "0", title: "Rep")
p lazysen.count
p lazyrep.count
# Legislator.where(in_office: "0", title: "Sen").destroy_all
# Legislator.where(in_office: "0", title: "Rep").destroy_all

puts "Senators: #{totalsens.count}"
puts "Representatives: #{totalreps.count}"
