# Built against TTD Api documentation
# https://api.thetradedesk.com/v3/portal/api/ref/post-additionalfees

module Ttdrest
  module Concerns
    module AdditionalFees
      def get_additional_fees(owner_id, owner_type)
        path = "/additionalfees/#{owner_type}/#{owner_id}"
        get(path, {})
      end

      def update_additional_fees(owner_id, owner_type, start_date, fees)
        path = '/additionalfees'
        content_type = 'application/json'
        body = additional_fees_body(owner_id, owner_type, start_date, fees)

        data_put(path, content_type, body.to_json) 
      end

      def create_additional_fees(owner_id, owner_type, start_date, fees)
        path = '/additionalfees'
        content_type = 'application/json'
        body = additional_fees_body(owner_id, owner_type, start_date, fees)

        data_post(path, content_type, body.to_json)
      end

      def additional_fees_body(owner_id, owner_type, start_date, fees)
        {
          'StartDateUtc' => start_date.utc.strftime("%Y-%m-%dT%H:%M:%SZ"),
          'OwnerId' => owner_id,
          'OwnerType' => owner_type,
          'Fees' => parse_fees(fees),
        }
      end

      def parse_fees(fees)
        # Allowing ruby symbol use and naming
        fees.map do |fee|
          {
            'Description' => (fee[:description] || fee['Description']),
            'Amount' => (fee[:amount] || fee['Amount']),
            'FeeType' => (fee[:fee_type] || fee['FeeType']),
          }
        end
      end
    end
  end
end
