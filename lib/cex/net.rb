require "rest_client"
require "net/http"
require 'digest/hmac'
require 'digest/sha2'
require 'base64'

module Cex
  module Net
    def self.to_uri(path)
      return "https://cex.io/api#{path}"
    end

    def self.get(path, options = {}, private_api = false)
      begin
        path += "?#{URI.encode_www_form(options)}" unless options.empty?
        RestClient.get(self.to_uri(path))
      rescue Exception => e
        raise BadRequest.new(e.response)
      end
    end

    def self.post(path, options = {})
      begin
        nonce = (Time.now.to_f * 10000).to_i.to_s
        signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha256'), Cex.secret, nonce + Cex.username + Cex.key)
        options.merge!(nonce: nonce, key: Cex.key, signature: signature)
        RestClient.post(self.to_uri(path), options.to_json)
      rescue Exception => e
        raise BadRequest.new(e.response)
      end
    end

    def self.nonce
      (Time.now.to_f * 10000).to_i.to_s
    end

    class BadRequest < RuntimeError; end
  end
end
