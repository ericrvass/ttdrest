# {
# "AdvertiserId": "sample string 1",
# "CreativeId": "sample string 1",
# "CreativeName": "sample string 1",
# "Description": "sample string 1",
# "ImageAttributes": {
#   "ImageContent": "sample string 1",
#   "AdTechnologyIds": [
#     "sample string 1",
#     "sample string 2",
#     "sample string 3"
#   ],
#   "RightMediaOfferTypeId": 1,
#   "Width": 1,
#   "Height": 1,
#   "ImageUrl": "sample string 1",
#   "ThirdPartyImpressionTrackingUrl": "sample string 1",
#   "ThirdPartyImpressionTrackingUrl2": "sample string 1",
#   "ThirdPartyImpressionTrackingUrl3": "sample string 1",
#   "ThirdPartyTrackingTags": [
#     "sample string 1",
#     "sample string 2",
#     "sample string 3"
#   ],
#   "IsSecurable": true,
#   "ClickthroughUrl": "sample string 1",
#   "LandingPageUrl": "sample string 1"
# },
# "Html5Attributes": {
#     "HtmlFileContent": "sample string 1", # Base65 Encoded?
#     "ZipArchiveContent": "sample string 1", #Base64 Encoded
#     "PrimaryHtmlFileName": "sample string 1",
#     "BackupImageContent": "sample string 1",
#     "Width": 1,
#     "Height": 1,
#     "HtmlFileUrl": "sample string 1",
#     "BackupImageUrl": "sample string 1",
#     "AdTechnologyIds": [
#       "sample string 1",
#       "sample string 2",
#       "sample string 3"
#     ],
#     "RightMediaOfferTypeId": 1,
#     "ClickthroughUrl": "sample string 1",
#     "UseClickthroughAsDefault": true,
#     "LandingPageUrls": [
#       "sample string 1",
#       "sample string 2",
#       "sample string 3"
#     ],
#     "ClickTrackingParameterName": "sample string 1",
#     "ThirdPartyTrackingTags": [
#       "sample string 1",
#       "sample string 2",
#       "sample string 3"
#     ],
#     "IsSecurable": true
#   },
module Ttdrest
  module Concerns
    module CreativeTypes
      module Html
        def create_html_creative(name, html_zip_content, clickthrough_url, landing_page_url, width, height, click_tracking_parameter_name, options = {})
          advertiser_id = self.advertiser_id || options[:advertiser_id]
          path = "/creative"
          content_type = 'application/json'
          creative_data = {
            "AdvertiserId" => advertiser_id,
            "CreativeName" => name
          }
          params = options[:params] || {}

          # Get the Mime Substring

          if !params[:description].nil?
            creative_data = creative_data.merge({"Description" => params[:description]})
          end

          details = {
            "ZipArchiveContent" => html_zip_content,
            "ClickthroughUrl" => clickthrough_url,
            "LandingPageUrls" => [landing_page_url],
            "width" => width,
            "height" => height,
            "ClickTrackingParameterName" => click_tracking_parameter_name,
            "IsSecurable" => true,
            "UseClickthroughAsDefault" => true
          }

          if !params[:right_media_offer_type_id].nil?
            details = details.merge({"RightMediaOfferTypeId" => params[:right_media_offer_type_id]})
          end


          if !params[:third_party_tracking_tags].nil?
            creative_data = creative_data.merge({
              ImageAttributes: {
                ThirdPartyTrackingTags: [ params[:third_party_tracking_tags] ]
              }
            })
            details = details.merge({
              ThirdPartyTrackingTags: [ params[:third_party_tracking_tags] ]
            })
          end

          creative_data = creative_data.merge({"Html5Attributes" => details})

          data_post(path, content_type, creative_data.to_json)

        end
      end
    end
  end
end
