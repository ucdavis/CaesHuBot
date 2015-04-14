request = require 'request'

giving_service_api = process.env.giving_service_api
giving_service_token = process.env.giving_service_token

giveroom = "give"

module.exports = (robot) ->
    robot.respond /give gift receipt (\d+)/i, (res) ->
        return if res.message.room != giveroom
        
        res.send
            "attachments": [
                "fallback": "Required plain-text summary of the attachment."
                "color": "#36a64f"
                "pretext": "Optional text that appears above the attachment block"
                "author_name": "Bobby Tables"
                "author_link": "http://flickr.com/bobby/"
                "author_icon": "http://flickr.com/icons/bobby.jpg"
                "title": "Slack API Documentation"
                "title_link": "https://api.slack.com/"
                "text": "Optional text that appears within the attachment"
                "fields": [
                    "title": "Priority"
                    "value": "High"
                    "short": false
                ],
                "image_url": "http://my-website.com/path/to/image.jpg"
            ]

        receipt = res.match[1]
        res.reply "Looking for gift with receipt #{receipt}..."

        options =
            url: "#{giving_service_api}/gifts/#{receipt}"
            timeout: 2000
            headers:
                "X-Auth-Token": giving_service_token

        request options, (error, response, body) ->
            if body == ""
                res.reply "no gift found"
            else
                res.send
                    text: "Gift #{receipt}"
                    content: 
                        title: 'gift.js'
                        text: body