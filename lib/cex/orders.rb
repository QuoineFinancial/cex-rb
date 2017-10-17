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

    def self.cancel_all
      Cex.sanity_check!
      Cex::Net.post("/cancel_orders/BTC/USD")
    end

    def open_orders
      Cex.sanity_check!
      result = Cex::Net.post("/open_orders/")
      JSON.parse(result).map do |order|
        Cex::OpenOrder.new(order)
      end
    end

    def archived_orders(options = {})
      Cex.sanity_check!
      result = Cex::Net.post("/archived_orders/BTC/USD", options)
      JSON.parse(result).map do |order|
        Cex::ArchivedOrder.new(order)
      end
    end
  end
end
