require "rest_client"
require "net/http"
require 'base64'
require 'openssl'

module Cex
  module Net
    def self.to_uri(path)
      "https://cex.io/api#{path}"
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
        nonce = (Time.now.to_f * 1_000_000_000).to_i.to_s
        signature = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha256"), Cex.secret, nonce + Cex.username + Cex.key)
        options.merge!(nonce: nonce, key: Cex.key, signature: signature)
        header = {
          "Content-Type" => "application/json",
          "Accept" => "application/json"
        }
        RestClient.post(self.to_uri(path), options.to_json, header)
      rescue Exception => e
        raise BadRequest.new(e.response)
      end
    end

    def self.nonce
      (Time.now.to_f * 1_000_000_000).to_i.to_s
    end

    class BadRequest < RuntimeError; end
  end
end
