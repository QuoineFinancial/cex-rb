require "cex/version"
require "cex/net"
require "cex/model"
require "cex/orders"
require "cex/transactions"
require "cex/balances"

module Cex
  class << self
    # API Key
    attr_accessor :key
    # API secret
    attr_accessor :secret
    # API username
    attr_accessor :username
  end

  def self.setup
    yield self
  end

  def self.configured?
    key && secret && username
  end

  def self.sanity_check!
    unless configured?
      raise MissingConfigExeception.new("Cex Gem not properly configured")
    end
  end

  class MissingConfigExeception < RuntimeError; end
end
