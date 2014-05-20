module Ttdrest
  module Concerns
    module IpTargetingList

      def get_ip_targeting_lists(options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/iptargetinglists/#{advertiser_id}"
        params = {}
        result = get(path, params)
        return result
      end
      
      def get_ip_targeting_list(ip_targeting_list_id, options = {})
        path = "/iptargetinglist/#{ip_targeting_list_id}"
        params = {}
        result = get(path, params)
        return result
      end
      
      # ip_targeting_range_format [{:min_ip => '100.0.0.1', :max_ip => '100.0.0.2'}, {:min_ip => '100.0.0.3', :max_ip => '100.0.0.4'}]
      def create_ip_targeting_list(name, ip_targeting_ranges = [], options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/iptargetinglist"
        content_type = 'application/json'
        ip_list_data = []
        ip_targeting_ranges.each do |range|
          ip_list_data << {"MinIP" => range[:min_ip], "MaxIP" => range[:max_ip]}
        end
        ip_targeting_data = {
          "AdvertiserId" => advertiser_id,
          "IPTargetingDataName" => name,
          "IPTargetingRanges" => ip_list_data
          }
     
        result = data_post(path, content_type, ip_targeting_data.to_json)
        return result
      end
      
    end
  end
end