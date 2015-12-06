module WigleApi
  module JsonApi
    class Find
      def initialize(netid_argument)
        self.find(netid_argument)
      end

      def result(netid_argument=@searched_netid_argument)
        @connection ||= WigleApi::Connection.new
        response = @connection.get_json_location({netid: @searched_netid_argument})

        parsed_response = JSON.parse(response.body)

        if parsed_response["success"] && !(result = parsed_response["result"].first).nil?
          OpenStruct.new(result)
        else
          nil
        end
      end

      def find(netid_argument)
        raise "Argument must be string" unless netid_argument.is_a? String
        @searched_netid_argument = netid_argument
      end

    end
  end
end