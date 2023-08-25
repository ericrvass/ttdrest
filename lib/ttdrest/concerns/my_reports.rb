# frozen_string_literal: true

# Provides API for getting MyReports
# Documented https://api.thetradedesk.com/v3/doc/api/post-myreports

module Ttdrest
  module Concerns
    module MyReports

      def get_my_reports(report_date, options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        if advertiser_id == nil then
            return
        end
        path = '/myreports/reportexecution/query/advertisers'
        report_data = {}.tap do |search_params|
          search_params['AdvertiserIds'] = [advertiser_id]
          search_params['ReportDateUTC'] = report_date.strftime("%Y-%m-%d")
          search_params['ReportScheduleNameContains'] = options[:report_schedule_name_contains] if options[:report_schedule_name_contains]
          search_params['ExecutionStates'] = present_or_default(options[:execution_states],["Complete"])
          search_params['ExecutionSpansStartDate'] = present_or_default(options[:execution_spans_start_date], report_date.strftime("%Y-%m-%dT00:00:00.0000000+00:00"))
          search_params['ExecutionSpansEndDate'] = present_or_default(options[:execution_spans_end_date], (report_date + 1.day).strftime("%Y-%m-%dT00:00:00.0000000+00:00"))
          search_params['PageStartIndex'] = present_or_default(options[:page], 0)
          search_params['PageSize'] = present_or_default(options[:page_size],1)
          search_params['SortFields'] = options[:sort_fields] if options[:sort_fields]
        end

        data_post(path, 'application/json', report_data.to_json)
      end

      def present_or_default(value, default)
        if value.present?
          value
        else
          default
        end
      end
    end
  end
end
