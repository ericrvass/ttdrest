# frozen_string_literal: true

# Provides API for getting HDReports
# Documented https://api.thetradedesk.com/v3/doc/api/post-myreports-reportexecution-query-advertisers

module Ttdrest
  module Concerns
    module HdReports

      def get_reports(report_date, options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = '/hdreports'
        report_data = {}.tap do |search_params|
          search_params['AdvertiserId'] = advertiser_id
          search_params['ReportDateUTC'] = report_date.strftime("%Y-%m-%d")
          search_params['Type'] = options[:type] if options[:type]
          search_params['Duration'] = options[:duration] if options[:duration]
        end

        data_post(path, 'application/json', report_data.to_json)
      end
    end
  end
end
