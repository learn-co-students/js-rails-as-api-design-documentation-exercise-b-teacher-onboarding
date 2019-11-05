class CoffeeController < ApplicationController
    def index
        # These parameters set the pagination, page, and search query for coffee.
        # These parameters look like: 
        # http://localhost:3000/coffee/index?limit=10&page=2&origin=kenya
        limit = (params[:limit] || 10).to_i
        page = (params[:page] || 0).to_i
        origin_filter = params[:origin] || ""

        # Here we grab all instances of Coffee, and change the AR::Relation instance of coffees
        # to a simpler array of Coffee instances
        # We select coffees based on origin,
        # then break the filtered array into an array of arrays of our pagination length,
        # and grab the subarray!
        all = Coffee.all.to_a
        filtered = all.select { |coffee| coffee.origin.include? origin_filter }
        chunks = filtered.each_slice(limit).to_a
        coffees = chunks[page]
        
        render json: coffees
    end
end
