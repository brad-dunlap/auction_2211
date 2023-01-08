class Item
	attr_reader :name,
							:bids,
							:closed

	def initialize(name)
		@name = name
		@bids = Hash.new(0)
		@closed = false
	end

	def add_bid(attendee, bid)
		if @closed == false
			bids[attendee] = bid
		else
			"Bidding is closed on this item"
		end
	end

	def current_high_bid
		current_bids = []
		bids.each do |attendee, bid|
			current_bids << bid
		end
		current_bids.max
	end

	def closed?
		@closed
	end
		
	def close_bidding
		@closed = true
	end
end