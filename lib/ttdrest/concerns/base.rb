require 'date'
require 'active_support/notifications'

module Ttdrest
  class AuthorizationFailedError < StandardError; end
  class RecoverableHttpError < StandardError
    def initialize(message = nil, data = {})
      super(message)

      @data = data
    end
  end

  module Concerns
    module Base

      #TODO: PUT Updates

      VERSION = "v3"
      RETRIES = 2
      ERROR_RETRIES = 3
      MAXIMUM_WAIT_TIME = 120

      def authenticate(options = {})
        client_id = self.client_login || options[:client_login]
        client_secret = self.client_password || options[:client_password]
        result = auth_post(client_id, client_secret)
        self.auth_token = result["Token"]
        return self.auth_token
      end

      def check_response(response)
        # TTD API Token Error Code Updates : https://api.thetradedesk.com/v3/portal/api/doc/UpgradeSupportArchives#auth-token-error-code-updates
        if response.code.in?(["401", "403"])
          raise AuthorizationFailedError
        elsif retryable_http_error?(response)
          raise RecoverableHttpError.new('', response)
        end
      end

      def retryable_http_error?(response)
        response && (
          response.code == '429' || (500..599).include?(response.code.to_i)
        )
      end

      def parse_header_retry(response)
        return nil unless response && response['Retry-After']

        if response['Retry-After'] =~ /^\d+$/
          response['Retry-After'].to_i
        else
          date = Time.rfc2822(response['Retry-After'])
          wait_time = date.to_i - Time.now.to_i
          return nil unless wait_time.positive?
          wait_time > MAXIMUM_WAIT_TIME ? MAXIMUM_WAIT_TIME :  wait_time
        end
      rescue ArgumentError
        nil
      end

      def perform_request(request, connection = http_connection)
        retries = 0
        response = nil

        begin
          ActiveSupport::Notifications.instrument('ttd.request') do |payload|
            payload[:request] = request
            payload[:retries] = retries

            response = connection.request(request)
            payload[:response] = response
          end

          check_response(response)
        rescue RecoverableHttpError, SocketError
          raise if retries >= ERROR_RETRIES
          retries += 1

          if sleep_time = parse_header_retry(response)
            sleep(sleep_time)
          else
            sleep((1.25 ** retries) * 1 - (0.3 * rand))
          end

          retry
        end

        response
      end

      def get(path, params)
        tries = RETRIES
        begin
          request = Net::HTTP::Get.new(params.blank? ? "/#{VERSION}#{path}" : "/#{VERSION}#{path}?".concat(params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')))
          request['TTD-Auth'] = self.auth_token
          response = perform_request(request)
          result = response.body.blank? ? "" : JSON.parse(response.body)
          return result
        rescue AuthorizationFailedError
          tries -= 1
          if tries > 0
            self.auth_token = authenticate
            retry
          end
        rescue => e
          puts 'Error In GET: ' + e.message
        end
      end

      def data_post(path, content_type, json_data)
        tries = RETRIES
        begin
          request = Net::HTTP::Post.new("/#{VERSION}#{path}", initheader = {'Content-Type' => content_type})
          request['TTD-Auth'] = self.auth_token
          request.body = json_data
          response = perform_request(request)
          result = response.body.blank? ? "" : JSON.parse(response.body)
          return result
        rescue AuthorizationFailedError
          tries -= 1
          if tries > 0
            self.auth_token = authenticate
            retry
          end
        rescue => e
          puts 'Error In Data POST: ' + e.message
        end
      end

      def data_put(path, content_type, json_data)
        tries = RETRIES
        begin
          request = Net::HTTP::Put.new("/#{VERSION}#{path}", initheader = {'Content-Type' => content_type})
          request['TTD-Auth'] = self.auth_token
          request.body = json_data
          response = perform_request(request)
          result = response.body.blank? ? "" : JSON.parse(response.body)
          return result
        rescue AuthorizationFailedError
          tries -= 1
          if tries > 0
            self.auth_token = authenticate
            retry
          end
        rescue => e
          puts 'Error In Data POST: ' + e.message
        end
      end

      # Defaulting to a 1 hour timeout
      def auth_post(client_login, client_password, expiration_minutes = 60 * 24 * 30)
        begin
          path = "/#{VERSION}/authentication"
          request = Net::HTTP::Post.new(path, initheader = {'Content-Type' =>'application/json'})
          auth_data = {
            "Login" => client_login,
            "Password" => client_password,
            "TokenExpirationInMinutes" => expiration_minutes
          }.delete_if{|_,v| v.nil? }.to_json
          request.body = auth_data
          response = http_connection.request(request)
          result = JSON.parse(response.body)
          return result
        rescue => e
          puts 'Error Authenticating: ' + e.message
        end
      end

      def http_connection(options = {})
        uri = URI.parse("https://#{self.host || options[:host]}")
        connection = Net::HTTP.new(uri.host, uri.port)
        connection.use_ssl = true
        connection.read_timeout = 500
        connection.verify_mode = OpenSSL::SSL::VERIFY_NONE
        return connection
      end
    end
  end
end
