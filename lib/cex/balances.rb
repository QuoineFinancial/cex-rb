module Cex
  module Balances
    def self.all
      Cex.sanity_check!
      balance = Cex::Net.post("/balance/")
      JSON.parse(balance)
    end
  end
end
