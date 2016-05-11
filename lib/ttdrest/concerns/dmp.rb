module Ttdrest
  module Concerns
    module Dmp

      def get_first_party_data(page_start_index, page_size, options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/dmp/firstparty/advertiser"
        content_type = 'application/json'
        data_group_data = {
          "AdvertiserId" => advertiser_id,
          "PageStartIndex" => page_start_index,
          "PageSize" => page_size
        }
        params = options[:params] || {}
        if !params[:search_terms].nil?
          data_group_data = data_group_data.merge({"SearchTerms" => params[:search_terms]})
        end
        if !params[:data_types].nil?
          data_group_data = data_group_data.merge({"DataTypes" => params[:data_types]})
        end

        #TODO: SortFields

        result = data_post(path, content_type, data_group_data.to_json)
        return result
      end

      def get_third_party_data(page_start_index, page_size, options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/dmp/thirdparty/advertiser"
        content_type = 'application/json'
        data_group_data = {
          "AdvertiserId" => advertiser_id,
          "PageStartIndex" => page_start_index,
          "PageSize" => page_size
        }
        params = options[:params] || {}
        if !params[:search_terms].nil?
          data_group_data = data_group_data.merge({"SearchTerms" => params[:search_terms]})
        end
        if !params[:category_ids].nil?
          data_group_data = data_group_data.merge({"CategoryIds" => params[:category_ids]})
        end
        if !params[:brand_ids].nil?
          data_group_data = data_group_data.merge({"BrandIds" => params[:brand_ids]})
        end

        #TODO: SortFields
        #TODO: DataRateFilters

        result = data_post(path, content_type, data_group_data.to_json)
        return result
      end

      def get_third_party_facets
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/dmp/thirdparty/facets/#{advertiser_id}"
        params = {}
        result = get(path, params)
        return result
      end

    end
  end
end
