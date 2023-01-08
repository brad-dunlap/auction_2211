require './lib/item'

RSpec.describe Item do
	let(:item1){ Item.new('Chalkware Piggy Bank') }
	let(:item2) { Item.new('Bamboo Picture Frame') }
	it 'initializes' do
		expect(item1). to be_instance_of(Item)
	end
end