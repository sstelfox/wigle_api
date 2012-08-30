# encoding: utf-8

=begin
  Descriptions of all the valid search options and information about them:

  addresscode - Street address, max length 30
  statecode   - Two character state code
  zipcode     - Five character integer zip code, maxlength 5
  variance    - The latitude/longitude variance in degrees, values available in the form: 0.001, 0.002, 0.005, 0.010 (default), 0.020, 0.050, 0.100, 0.200
  latrange1   - Begin latitude range, max length 14
  latrange2   - End latitude range, max length 14
  longrange1  - Begin longitude range, max length 14
  longrange2  - End longitude range, max length 14
  lastupdt    - A timestamp used to filter based on the last time the access point database was updated in the format of 20010925174546
  netid       - BSSID / AP Max Address, expects either just the colon delimited vendor code or a full MAC such as either 0A:2C:EF or 0A:2C:EF:3D:25:1B, max length 14
  ssid        - SSID / Network Name, max length 50
  freenet     - Must be a freenet (Not sure what that means), set the value to on to filter with this, should be excluded completely otherwise
  paynet      - Must be a Commercial Pay Net (Not sure what that means either...), same deal with on to filter with this
  dhcp        - Must have DHCP enable, on again to filter with this...
  onlymine    - Only search on the networks that the authenticated user has found
  pagestart   - The search result offset
  Query       - This is the submit button...
=end

module WigleApi
  module Scraper
    class Search
      def initialize(args)
        @search_arguments = {
          "variance"    => "0.010",
          "Query"       => "Query"
        }

        @search_arguments.merge!(clean(args))
      end

      def where(args)
        @search_arguments.merge!(clean(args))
        self
      end

      def results
        conn = WigleApi::Connection.new
        response = conn.search(@search_arguments)

        unless [200, 301, 302, 303].include?(response.code.to_i)
          return nil
        end

        WigleApi::Scraper::Parser.new(response.body)
      end

      def each
        results.each { |r| yield(r) }
      end

      private

      def clean(options)
        options = options.inject({}) do |opt, (key, value)|
          opt[key.to_s] = value.to_s
          opt
        end

        options.delete_if { |k,v| !valid_keys.include?(k) }
      end

      def valid_keys
        [
          "addresscode",
          "statecode",
          "zipcode",
          "variance",
          "latrange1",
          "latrange2",
          "longrange1",
          "longrange2",
          "lastupdt",
          "netid",
          "ssid",
          "freenet",
          "paynet",
          "dhcp",
          "onlymine",
          "Query"
        ]
      end
    end
  end
end

