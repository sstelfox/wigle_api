# encoding: utf-8

module WigleApi
  class Connection
    def self.new(*args)
      @@instance ||= super
    end

    def initialize
      @connection = Net::HTTP.new(WIGLE_ENDPOINT.host, WIGLE_ENDPOINT.port)
      @connection.use_ssl = true
      @connection.verify_mode = OpenSSL::SSL::VERIFY_NONE

      @logged_in = false
    end

    def post_login(username, password)
      return true if @logged_in

      login_form_data = {
        'credential_0' => username,
        'credential_1' => password,
        'noexpire' => 'off',
        'destination' => '/',
      }

      response = post(WIGLE_LOGIN_URL, login_form_data)

      if response["Set-Cookie"].nil?
        return false
      end
      
      @auth_cookie = response["Set-Cookie"]
      @logged_in = true
    end

    def get_current_user
      JSON.parse(get(WIGLE_USER_URL, {}).body)
    end

    def get_json_search(data)
      raise NotLoggedIn unless @logged_in
      response = self.get(WIGLE_INDEX_URL, data)
    end

    def get_json_location(data)
      raise NotLoggedIn unless @logged_in
      response = self.get(WIGLE_SHOW_URL, data)
    end

    # private

    def http_request(type, path, data)
      puts "http_request: type=#{type}, path=#{path}, data=#{data}"
      request = if type.to_sym == :post
                  Net::HTTP::Post.new(path)
                elsif type.to_sym == :get
                  Net::HTTP::Get.new(path)
                else
                  raise "Unknown http type!"
                end

      request.initialize_http_header(
          {
              "User-Agent" => "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0"
          })

      request.set_form_data(data)
      request.add_field("Cookie", @auth_cookie) if @auth_cookie

      response = @connection.start do |http|
        http.request(request)
      end
      puts response.inspect
      response
    end

    def post(path, data)
      self.http_request(:post, path, data)
    end

    def get(path, data)
      self.http_request(:get, path, data)
    end
  end
end

