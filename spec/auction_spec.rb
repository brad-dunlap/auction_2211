require './lib/auction'

RSpec.describe Auction do
	let(:auction) { Auction.new }
	
	describe '#initialize' do
		it 'exists' do
			expect(auction).to be_instance_of(Auction)
		end
	end
end