module Cex
  module Transactions
    def self.all(options = {})
      Cex.sanity_check!
      result = Cex::Net.post("/get_order_tx", options)
      result = JSON.parse(result)
      return unless result["ok"]

      Cex::Order.new(result["data"], transactions: result["data"]["vtx"])
    end
  end
end
