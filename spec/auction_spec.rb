require 'pry'
require 'rspec'
require './lib/auction'
require './lib/item'
require './lib/attendee'

RSpec.describe Auction do
	let(:auction) { Auction.new }
	let(:item1) { Item.new('Chalkware Piggy Bank') }
	let(:item2) { Item.new('Bamboo Picture Frame') }
	let(:item3) { Item.new('Homemade Chocolate Chip Cookies') }	
	let(:item4) { Item.new('2 Days Dogsitting') }
	let(:item5) { Item.new('Forever Stamps') }
	let(:attendee1) { Attendee.new(name: 'Megan', budget: '$50') }
	let(:attendee2) { Attendee.new(name: 'Bob', budget: '$75') }
	let(:attendee3) { Attendee.new(name: 'Mike', budget: '$100') }
	
	describe '#initialize' do
		it 'exists' do
			expect(auction).to be_instance_of(Auction)
		end

		it 'has attributes' do
			expect(auction.items).to eq([])
		end
	end

	describe '#add_items' do
		it 'can add items to the auction' do
			auction.add_item(item1)
			auction.add_item(item2)
			expect(auction.items).to eq([item1, item2])
		end
	end

	describe '#item_names' do
		it 'can return the names of items in an auction' do
			auction.add_item(item1)
			auction.add_item(item2)
			expect(auction.item_names).to eq(['Chalkware Piggy Bank','Bamboo Picture Frame'])
		end
	end

	describe 'bidding' do
		it 'can add a bid' do
			auction.add_item(item1)
			auction.add_item(item2)
			auction.add_item(item3)
			auction.add_item(item4)
			auction.add_item(item5)
			expect(item1.bids).to eq({})
			item1.add_bid(attendee2, 20)
			item1.add_bid(attendee1, 22)
		end

		it 'can determine current_high_bid' do
			auction.add_item(item1)
			auction.add_item(item2)
			auction.add_item(item3)
			auction.add_item(item4)
			auction.add_item(item5)
			expect(item1.bids).to eq({})
			item1.add_bid(attendee2, 20)
			item1.add_bid(attendee1, 22)
			expect(item1.current_high_bid).to eq(22)
		end

		it 'can determine unpopular items' do
			auction.add_item(item1)
			auction.add_item(item2)
			auction.add_item(item3)
			auction.add_item(item4)
			auction.add_item(item5)
			item1.add_bid(attendee2, 20)
			item1.add_bid(attendee1, 22)
			item4.add_bid(attendee3, 50)
			expect(auction.unpopular_items).to eq([item2, item3, item5])
			item3.add_bid(attendee2, 15)
			expect(auction.unpopular_items).to eq([item2, item5])
		end
	end

	describe 'revenue' do
		it 'can determine #potential_revenue' do
			auction.add_item(item1)
			auction.add_item(item2)
			auction.add_item(item3)
			auction.add_item(item4)
			auction.add_item(item5)
			item1.add_bid(attendee2, 20)
			item1.add_bid(attendee1, 22)
			item4.add_bid(attendee3, 50)
			item3.add_bid(attendee2, 15)
			expect(auction.potential_revenue).to eq(87)
		end
	end

	describe 'bidders' do
		it 'can return an array of attendees that have place a bid' do
			auction.add_item(item1)
			auction.add_item(item2)
			auction.add_item(item3)
			auction.add_item(item4)
			auction.add_item(item5)
			item1.add_bid(attendee2, 20)
			item1.add_bid(attendee1, 22)
			item4.add_bid(attendee3, 50)
			item3.add_bid(attendee2, 15)
			expect(auction.bidders).to match_array(["Megan", "Bob", "Mike"])
		end

		it 'can return #bidder_info' do
			auction.add_item(item1)
			auction.add_item(item2)
			auction.add_item(item3)
			auction.add_item(item4)
			auction.add_item(item5)
			item1.add_bid(attendee1, 22)
			item1.add_bid(attendee2, 20)
			item3.add_bid(attendee2, 15)
			item4.add_bid(attendee3, 50)
			expect(auction.bidder_info).to be_a(Hash)

			expected_hash = {
				attendee1 => { :budget => 50, :items => [item1] },
				attendee2 => { :budget => 75, :items => [item1, item3] },
				attendee3 => { :budget => 100, :items => [item4] }
			}

			expect(auction.bidder_info).to eq(expected_hash)
		end
	end
end