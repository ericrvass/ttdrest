# Built against TTD Api documentation
# https://api.thetradedesk.com/v3/portal/api/ref/post-additionalfees

module Ttdrest
  module Concerns
    module AdditionalFee
      # There is no "updating" existing fees, only creating new ones with a start_date as soon as possible.
      def create_additional_fees(owner_id, owner_type, start_date, fees)
        path = '/additionalfees'
        context_type = 'application/json'

        additional_fees_body = {
          'StartDateUtc' => start_date.utc.strftime("%Y-%m-%dT%H:%M:%SZ"),
          'OwnerId' = owner_id,
          'OwnerType' => owner_typem
          'Fees' => parse_fees(fees),
        }

        data_post(path, context_type, additional_fees_body.to_json)
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
