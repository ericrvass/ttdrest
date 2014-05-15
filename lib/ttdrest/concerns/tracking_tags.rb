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

    end
  end
end