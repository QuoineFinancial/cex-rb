module Cex
  module Transactions
    def self.all(options = {})
      Cex.sanity_check!
      result = Cex::Net.post("/get_order_tx/", options)
      result = JSON.parse(result)
      return if result["error"]
      order = Cex::Order.new(result["data"])
      order.transactions = result["data"]["vtx"]
      order
    end
  end
end
