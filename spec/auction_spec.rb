require 'pry'
require 'rspec'
require './lib/auction'
require './lib/item'
require './lib/attendee'

RSpec.describe Auction do
	let(:auction){ Auction.new }
	let(:item1){ Item.new('Chalkware Piggy Bank') }
	let(:item2) { Item.new('Bamboo Picture Frame') }
	
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
end