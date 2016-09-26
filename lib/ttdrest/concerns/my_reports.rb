module Ttdrest
  module Concerns
    module MyReports

      def get_my_reports(report_date, options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/myreports/reportexecution/query/advertisers"
        content_type = 'application/json'
        report_data = {
          "AdvertiserIds" => [advertiser_id],
          "ExecutionSpansStartDate" => options[:execution_spans_start_date].present? ? options[:execution_spans_start_date] : report_date.strftime("%Y-%m-%dT00:00:00.0000000+00:00"),
          "ExecutionSpansEndDate" => options[:execution_spans_end_date].present? ? options[:execution_spans_end_date] : (report_date + 1.day).strftime("%Y-%m-%dT00:00:00.0000000+00:00"),
          "PageStartIndex" => options[:page].present? ? options[:page] : 0,
          "PageSize" => 1,
          "ExecutionStates" => options[:execution_states].present? ? options[:execution_states] : ["Complete"]
        }
        if options[:sort_fields].present?
          report_data["SortFields"] = options[:sort_fields]
        end
        result = data_post(path, content_type, report_data.to_json)
        return result
      end

    end
  end
end