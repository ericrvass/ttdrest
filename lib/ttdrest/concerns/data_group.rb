module Ttdrest
  module Concerns
    module DataGroup

      def get_data_groups(options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/datagroup/query/advertiser"
        params = { AdvertiserId: advertiser_id, PageStartIndex: 0, PageSize: nil }
        content_type = 'application/json'
        result = data_post(path, content_type, params.to_json)
        return result
      end

      def get_data_group(data_group_id, options = {})
        path = "/datagroup/#{data_group_id}"
        params = {}
        result = get(path, params)
        return result
      end

      def create_data_group(name, options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/datagroup"
        content_type = 'application/json'
        data_group_data = {
          "AdvertiserId" => advertiser_id,
          "DataGroupName" => name
          }
        params = options[:params] || {}
        if !params[:description].nil?
          data_group_data = data_group_data.merge({"Description" => params[:description]})
        end
        if !params[:first_party_data_ids].nil?
          data_group_data = data_group_data.merge({"FirstPartyDataIds" => params[:first_party_data_ids]})
        end
        if !params[:third_party_data_ids].nil?
          data_group_data = data_group_data.merge({"ThirdPartyDataIds" => params[:third_party_data_ids]})
        end

        result = data_post(path, content_type, data_group_data.to_json)
        return result
      end

      def update_data_group(data_group_id, options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/datagroup"
        content_type = 'application/json'
        data_group_data = {
          "AdvertiserId" => advertiser_id,
          "DataGroupId" => data_group_id
          }
        params = options[:params] || {}
        if !params[:name].nil?
          data_group_data = data_group_data.merge({"DataGroupName" => params[:name]})
        end
        if !params[:description].nil?
          data_group_data = data_group_data.merge({"Description" => params[:description]})
        end
        if !params[:first_party_data_ids].nil?
          data_group_data = data_group_data.merge({"FirstPartyDataIds" => params[:first_party_data_ids]})
        end
        if !params[:third_party_data_ids].nil?
          data_group_data = data_group_data.merge({"ThirdPartyDataIds" => params[:third_party_data_ids]})
        end

        result = data_put(path, content_type, data_group_data.to_json)
        return result
      end

    end
  end
end
