# encoding: utf-8

module WigleApi
  module Scraper
    class Parser
      def self.new(*args)
        p = super
        p.output
      end

      def initialize(html_body)
        @parser = Nokogiri::HTML(html_body)

        headers = parse_headers
        results = parse_results

        @output = results.map! { |r| Hash[headers.zip(r)] }
      end

      def output
        @output
      end

      private

      def parse_headers
        @parser.css("th[@class='searchhead']").map do |node|
          node.text.strip
        end
      end

      def parse_results
        @parser.css("tr[@class='search']").map do |sr|
          sr.css("td").map do |v|
            v.text.strip
          end
        end
      end
    end
  end
end

