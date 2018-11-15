require_relative '../lib/numeric_decoder'
require 'rspec'

RSpec.describe NumericDecoder do
	it 'raises error for invalid symbols (0) in the phone' do
		expect {NumericDecoder.decode_numeric('0')}.to raise_error(RuntimeError, "Invalid symbol '0' in the phone")
	end

	it 'raises error for invalid symbols (1) in the phone' do
		expect {NumericDecoder.decode_numeric('1')}.to raise_error(RuntimeError, "Invalid symbol '1' in the phone")
	end
end