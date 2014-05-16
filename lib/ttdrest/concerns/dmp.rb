module Ttdrest
  module Concerns
    module Dmp

      def get_first_party_data(page_start_index, page_size, options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/#{VERSION}/dmp/firstparty/data"
        content_type = 'application/json'
        data_group_data = {
          "AdvertiserId" => advertiser_id,
          "PageStartIndex" => page_start_index,
          "PageSize" => page_size
          }
        params = options[:params] || {}
        if !params[:search_term].nil?
          data_group_data = data_group_data.merge({"SearchTerm" => params[:search_term]})
        end
        if !params[:data_types].nil?
          data_group_data = data_group_data.merge({"DataTypes" => params[:data_types]})
        end

        #TODO: query DataTypes 
        #TODO: SortFields
        
        result = data_post(path, content_type, data_group_data.to_json)
        return result
      end
      
      #TODO: 3rd Party Data
    end
  end
end