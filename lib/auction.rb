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

	def bidder_info
		bidders = Hash.new(0)
		bids = []
		items.each do |item|
			if !item.bids.empty?
				bids << item.bids.keys
			end
		end
		flattened = bids.flatten
		flattened.each do |attendee|
			bidders[attendee] = {:budget => (attendee.budget), :items => []}
		end
		bidders
		items.each do |item|
			bidders.each do |attendee, info|
				if item.bids.keys.include?(attendee)
					info[:items] << item
				end
			end
		end
		bidders
	end
end