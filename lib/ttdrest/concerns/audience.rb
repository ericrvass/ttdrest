module Ttdrest
  module Concerns
    module Audience

      def get_audiences(options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/audiences/#{advertiser_id}"
        params = {}
        result = get(path, params)
        return result
      end
      
      def get_audience(audience_id, options = {})
        path = "/audience/#{audience_id}"
        params = {}
        result = get(path, params)
        return result
      end
      
      def create_audience(name, budget_in_dollars, start_date, included_data_group_ids = [], options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/audience"
        content_type = 'application/json'
        audience_data = {
          "AdvertiserId" => advertiser_id,
          "AudienceName" => name,
          "IncludedDataGroupIds " => included_data_group_ids
          }
        params = options[:params] || {}
        if !params[:description].nil?
          audience_data = audience_data.merge({"Description" => params[:description]})
        end
        if !params[:excluded_data_group_ids].nil?
          audience_data = audience_data.merge({"ExcludedDataGroupIds" => params[:excluded_data_group_ids]})
        end
     
        result = data_post(path, content_type, audience_data.to_json)
        return result
      end
      
    end
  end
end