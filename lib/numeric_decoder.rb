module NumericDecoder

	@@encoded_map = {
		2 => ["a", "b", "c"], 
		3 => ["d", "e", "f"], 
		4 => ["g", "h", "i"], 
		5 => ["j", "k", "l"], 
		6 => ["m", "n", "o"], 
		7 => ["p", "q", "r", "s"], 
		8 => ["t", "u", "v"], 
		9 => ["w", "x", "y", "z"]
	}

	@@dictionary = File.readlines('dictionary.txt').map{ |w| w.strip }

	##checks in dictionary whether work exists
	##input: string
	##output: array of string
	def self.check_dictionary_exists(word)
		upcase_word = word.upcase
		return @@dictionary.bsearch{|x| upcase_word <=> x  }
	end

	##decodes value to combination of words from dictionary
	##input: single set of number ex: 6686787825
	##output: array of string ex: ["abc"]
	def self.words_from_dictionary(val)
		combinations = nil
		val.each_char do |char|
			codes_arr = @@encoded_map[char.to_i]
			raise "Invalid symbol '#{char}' in the phone" if codes_arr.nil?
			combinations = combinations.nil? ? codes_arr : combinations.product(codes_arr)
		end

		comb_word = combinations.map(&:join)
		return comb_word.select! { |w| check_dictionary_exists(w) }
	end

	# decodes value to set of words from dictionary
	##input: single set of number ex: 6686787825
	##output: multi-array of string ex: ["abc", ["abc"]]
	def self.decode_numeric(val)
		temp_val = val.dup
		s_word = ''
		all_val_words = words_from_dictionary(val)
		all_words = all_val_words
		while temp_val.length > 3 do
			s_word += temp_val.slice!(0)
			next if s_word.length < 3
			first_slice = words_from_dictionary(s_word)
			last_slice = words_from_dictionary(temp_val)

			if first_slice.length > 0 && last_slice.length > 0
				combinations = first_slice.product(last_slice)
				all_words += combinations
			end
		
			all_words.select!{ |w| !all_val_words.include?( w[0] + w[1] ) }
		end
		return all_words.reverse
	end
	
end