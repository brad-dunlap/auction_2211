class Auction
	attr_reader :items
	
	def initialize
		@items = []
	end

	def add_item(item)
		@items << item
	end

	def item_names
		@items.map do |item|
			item.name
		end
	end

	def unpopular_items
		unpopular = []
		 items.each do |item|
			if item.bids.empty?
				unpopular << item				
			end
		end
		unpopular
	end

	def potential_revenue
		revenue = 0
		items.each do |item|			
			revenue += item.current_high_bid.to_i
		end
		revenue
	end

	def bidders
		bidders = []
		items.each do |item|
			item.bids.each do |attendee, bid|
				bidders << attendee.name				
			end
		end
		bidders.uniq
	end

	
end