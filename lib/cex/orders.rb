module Cex
  module Orders
    def self.create(options = {})
      Cex.sanity_check!
      result = Cex::Net.post("/place_order/BTC/USD/", options)
      Cex::Order.new(JSON.parse(result))
    end

    def self.cancel(options = {})
      Cex.sanity_check!
      Cex::Net.post("/cancel_order/", options)
    end
  end
end
