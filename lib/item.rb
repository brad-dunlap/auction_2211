class Item
	attr_reader :name,
							:bids

	def initialize(name)
		@name = name
		@bids = Hash.new(0)
	end

	def add_bid(attendee, bid)
		bids[attendee] = bid
	end

	def current_high_bid
		current_bids = []
		bids.each do |attendee, bid|
			current_bids << bid
		end
		current_bids.max
	end
end