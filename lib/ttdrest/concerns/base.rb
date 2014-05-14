module Ttdrest
  class AuthorizationFailedError < StandardError; end
  
  module Concerns
    module Base
      
      #TODO: PUT Updates
      
      VERSION = "v2"
      RETRIES = 2
      
      def authenticate(options = {})
        client_id = self.client_login || options[:client_login]
        client_secret = self.client_password || options[:client_password]
        result = auth_post(client_login, client_password)
        self.auth_token = result["Token"]     
        return self.auth_token
      end

      def check_response(response)
        if response.code.eql?("403") 
          raise AuthorizationFailedError
        end
      end

      def get(path, params)
        tries = RETRIES
        begin
          request = Net::HTTP::Get.new(params.blank? ? path : "#{path}?".concat(params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')))
          request['TTD-Auth'] = self.auth_token
          response = http_connection.request(request)
          check_response(response)
          result = response.body.blank? ? "" : JSON.parse(response.body)
          return result
        rescue AuthorizationFailedError
          tries -= 1
          if tries > 0
            self.auth_token = authenticate
            retry
          end
        rescue Exception => e 
          puts 'Error In GET: ' + e.message 
        end 
      end

      def data_post(path, content_type, json_data)
        tries = RETRIES
        begin
          request = Net::HTTP::Post.new(path, initheader = {'Content-Type' => content_type})
          request['TTD-Auth'] = self.auth_token
          request.body = json_data
          response = http_connection.request(request)
          check_response(response)
          result = response.body.blank? ? "" : JSON.parse(response.body)
          return result
        rescue AuthorizationFailedError
          tries -= 1
          if tries > 0
            self.auth_token = authenticate
            retry
          end
        rescue Exception => e 
          puts 'Error In Data POST: ' + e.message 
        end 
      end

      def auth_post(client_login, client_password)
        begin
          path = "/#{VERSION}/authentication"
          request = Net::HTTP::Post.new(path, initheader = {'Content-Type' =>'application/json'})
          auth_data = {"Login" => client_login, "Password" => client_password}.to_json
          request.body = auth_data
          response = http_connection.request(request)
          result = JSON.parse(response.body)
          return result
        rescue Exception => e 
          puts 'Error Authenticating: ' + e.message 
        end 
      end

      def http_connection(options = {})
        uri = URI.parse("https://#{self.host || options[:host]}")
        connection = Net::HTTP.new(uri.host, uri.port)
        connection.use_ssl = true
        connection.verify_mode = OpenSSL::SSL::VERIFY_NONE
        return connection
      end

      def auth_header(client_id, client_secret)
        credential = "#{client_id}:#{client_secret}"
        "Basic #{Base64.encode64(credential)}".delete("\n")
      end

      def api_header(oauth_token)
        "Bearer #{oauth_token}"
      end  
    end
  end
end