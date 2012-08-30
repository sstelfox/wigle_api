# encoding: utf-8

# Gem requirements
require "net/https"
require "nokogiri"
require "rubygems"
require "uri"

# Misc pieces of this gem
require "wigle_api/connection"
require "wigle_api/exceptions"
require "wigle_api/version"

# Web scraper portions
require "wigle_api/scraper/parser"
require "wigle_api/scraper/search"

# Web API portions

module WigleApi
  WIGLE_URI       = URI.parse("https://wigle.net/")
  WIGLE_LOGIN_URL = "/gps/gps/main/login"
  WIGLE_QUERY_URL = "/gps/gps/main/confirmquery/"

  def self.login(username, password)
    @connection ||= WigleApi::Connection.new
    @connection.login(username, password)
  end

  def self.where(args)
    WigleApi::Scraper::Search.new(args)
  end
end

# How to use:
# WigleApi.login("myusername", "mypassword")
# @results = WigleApi.where(ssid: "linksys").results

