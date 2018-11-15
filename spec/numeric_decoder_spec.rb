require_relative '../lib/numeric_decoder'
require 'rspec'

RSpec.describe NumericDecoder do
	it 'raises error for invalid symbols (0) in the phone' do
		expect {NumericDecoder.decode_numeric('0')}.to raise_error(RuntimeError, "Invalid symbol '0' in the phone")
	end

	it 'raises error for invalid symbols (1) in the phone' do
		expect {NumericDecoder.decode_numeric('1')}.to raise_error(RuntimeError, "Invalid symbol '1' in the phone")
	end

	it 'convert 6686787825 phone to expected words' do
		expect(NumericDecoder.decode_numeric('6686787825')).to match_array( [["motor", "usual"], ["noun", "struck"], ["nouns", "truck"], ["nouns", "usual"], ["onto", "struck"], "motortruck"] )
	end

	it 'convert 2282668687 phone to expected words' do
		expect(NumericDecoder.decode_numeric('2282668687')).to match_array( [["act", "amounts"], ["act", "contour"], ["acta", "mounts"], ["bat", "amounts"], ["bat", "contour"], ["cat", "contour"], "catamounts"] )
	end
end
