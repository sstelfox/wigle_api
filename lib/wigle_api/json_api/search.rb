module WigleApi
  module JsonApi
    class Search
      def initialize(args)
        @search_arguments = {
            "variance"    => "0.010",
            "Query"       => "Query"
        }

        @search_arguments.merge!(clean(args))
      end

      def offset(num)
        @search_arguments.merge!(clean({pagestart: num}))
        self
      end

      def where(args)
        @search_arguments.merge!(clean(args))
        self
      end

      def results
        @connection ||= WigleApi::Connection.new
        response = @connection.get_json_search(@search_arguments)

        parsed_response = JSON.parse(response.body)

        if parsed_response["success"]
          parsed_response["results"].map{ |r| OpenStruct.new(r) }
        else
          nil
        end
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
        %w(
          addresscode
          statecode
          zipcode
          variance
          latrange1
          latrange2
          longrange1
          longrange2
          lastupdt
          netid
          ssid
          freenet
          paynet
          dhcp
          onlymine
          pagestart
        )
      end
    end
  end
end