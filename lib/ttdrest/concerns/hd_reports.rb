module Ttdrest
  module Concerns
    module HdReports

      def get_reports(report_date, options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/hdreports"
        content_type = 'application/json'
        report_data = {
          "AdvertiserId" => advertiser_id,
          "ReportDateUTC" => report_date.strftime("%Y-%m-%d")
          }
        
        result = data_post(path, content_type, report_data.to_json)
        return result
      end
      
    end
  end
end