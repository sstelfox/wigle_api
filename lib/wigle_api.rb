# encoding: utf-8

# Gem requirements
require "net/https"
require "nokogiri"
require "rubygems"
require "uri"
require "json"
require 'ostruct'
require 'deepstruct'

# Misc pieces of this gem
require "wigle_api/connection"
require "wigle_api/exceptions"
require "wigle_api/version"

# Web scraper portions
require "wigle_api/json_api/find"
require "wigle_api/json_api/search"

# Web API portions

module WigleApi
  WIGLE_ENDPOINT  = URI.parse("https://wigle.net/")
  WIGLE_LOGIN_URL = "/api/v1/jsonLogin"
  WIGLE_USER_URL  = "/api/v1/jsonUser"
  WIGLE_INDEX_URL = "/api/v1/jsonSearch"
  WIGLE_SHOW_URL  = "/api/v1/jsonLocation"

  def self.login(username, password)
    @connection ||= WigleApi::Connection.new
    @connection.post_login(username, password)
  end

  def self.current_user
    @connection ||= WigleApi::Connection.new
    @connection.get_current_user
  end

  def self.where(args)
    WigleApi::JsonApi::Search.new(args)
  end

  def self.find(args)
    WigleApi::JsonApi::Find.new(args)
  end
end

# How to use the web scraper (will only return 100 results):
# WigleApi.login("myusername", "mypassword")
# @results = WigleApi.where(ssid: "linksys").results

