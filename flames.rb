def flames name1, name2
	name1 = name1.downcase.split(" ").join ""
	name2 = name2.downcase.split(" ").join ""
	name1.each_char do |i|
		if name2.include? i 
			name1[name1.index i] = ""
			name2[name2.index i] = ""
 		end
 	end

 	flamesSize = name1.length + name2.length
 	letters = "flames"

 	if flamesSize == 0
 		return "x"
 	end

 	until letters.length == 1
 		unless flamesSize > letters.length
 			letters = letters[flamesSize...letters.length] + letters[0...(flamesSize-1)] 
 			flamesSize = name1.length + name2.length
 		else
 			flamesSize -= letters.length
 		end
 	end
 	letters
end


def expand ch 
	case ch
	when "f" then "Friend"
	when "l" then "Love"
	when "a" then "Affection"
	when "m" then "marriage"
	when "e" then "Enemy"
	when "s" then "Sibling"
	end
end


