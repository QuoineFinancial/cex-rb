require "virtus"

module Cex
  class Transaction
    include Virtus.model

    values do
      attribute :id, String
      attribute :type, String
      attribute :time, String
      attribute :user, String
      attribute :amount, Decimal
      attribute :balance, Decimal
      attribute :symbol, String
      attribute :order, String
      attribute :fee, Decimal
      attribute :price, Decimal
      attribute :fee_amount, Decimal
    end
  end

  class Order
    include Virtus.model

    values do
      attribute :id, String
      attribute :timestamp, Integer
      attribute :type, String
      attribute :status, String
      attribute :price, Decimal
      attribute :amount, Decimal
      attribute :pending, Decimal
      attribute :lastTxTime, String
      attribute :lastTx, String
      attribute :symbol1, String
      attribute :fa_usd, Decimal
      attribute :ta_usd, Decimal
      attribute :remains, Decimal
      attribute :tradingFeeMaker, Decimal
      attribute :tradingFeeTaker, Decimal
      attribute :transactions, Array[Cex::Transaction]
    end

    def trading_fee_maker
      self.tradingFeeMaker
    end

    def trading_fee_taker
      self.tradingFeeTaker
    end
  end

  class Balance
    include Virtus.value_object

    values do
      attribute :available, Decimal
      attribute :orders, Decimal
      attribute :bonus, Decimal
    end
  end

  class OpenOrder 
    include Virtus.model

    values do
      attribute :id, String
      attribute :time, Integer
      attribute :type, String
      attribute :price, Decimal
      attribute :amount, Decimal
      attribute :pending, Decimal
      attribute :symbol1, String
      attribute :symbol2, String
    end
  end

  class ArchivedOrder 
    include Virtus.model

    values do
      attribute :id, String
      attribute :type, String
      attribute :time, Integer
      attribute :lastTxTime, Decimal
      attribute :lastTx, Decimal
      attribute :status, Decimal
      attribute :pending, Decimal
      attribute :symbol1, String
      attribute :symbol2, String
      attribute :amount, String
      attribute :price, String
      attribute :remains, String
      attribute :tradingFeeMaker, String
      attribute :tradingFeeTaker, String
      attribute :orderId, String
    end
  end
end
