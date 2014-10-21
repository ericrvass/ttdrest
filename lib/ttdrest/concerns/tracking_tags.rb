module Ttdrest
  module Concerns
    module TrackingTags

      def get_tracking_tags(options = {})
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        path = "/trackingtags/#{advertiser_id}"
        params = {}
        result = get(path, params)
        return result
      end

      def create_tracking_tag(tracking_tag_name, tracking_tag_type_id, options = {})
        path = "/trackingtag"
        content_type = 'application/json'
        advertiser_id = self.advertiser_id || options[:advertiser_id]
        params = options[:params] || {}
        tracking_tag_data = build_tracking_tag_data(advertiser_id, nil, tracking_tag_name, tracking_tag_type_id, params)
        result = data_post(path, content_type, tracking_tag_data.to_json)
        return result
      end

      def build_tracking_tag_data(advertiser_id, tracking_tag_id, tracking_tag_name, tracking_tag_type_id, params = {})
        tracking_tag_data = {}
        if !advertiser_id.nil?
          tracking_tag_data = tracking_tag_data.merge({"AdvertiserId" => advertiser_id})
        end
        if !tracking_tag_id.nil?
          tracking_tag_data = tracking_tag_data.merge({"TrackingTagId" => tracking_tag_id})
        end
        if !tracking_tag_name.blank?
          tracking_tag_data = tracking_tag_data.merge({"TrackingTagName" => tracking_tag_name})
        end
        if !tracking_tag_type_id.blank?
          tracking_tag_data = tracking_tag_data.merge({"TrackingTagTypeId" => tracking_tag_type_id})
        end
        if !params[:tracking_tag_location].nil?
          tracking_tag_data = tracking_tag_data.merge({"TrackingTagLocation" => params[:tracking_tag_location]})
        end
        if !params[:revenue].nil?
          tracking_tag_data = tracking_tag_data.merge({"Revenue" => params[:revenue]})
        end
        if !params[:currency].nil?
          tracking_tag_data = tracking_tag_data.merge({"Currency" => params[:currency]})
        end
        if !params[:container_tag_body].nil?
          tracking_tag_data = tracking_tag_data.merge({"ContainerTagBody" => params[:container_tag_body]})
        end
        if !params[:right_media_recency_window_in_minutes].nil?
          tracking_tag_data = tracking_tag_data.merge({"RightMediaRecencyWindowInMinutes" => params[:right_media_recency_window_in_minutes]})
        end
        return tracking_tag_data
      end

    end
  end
end