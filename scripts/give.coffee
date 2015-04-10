﻿request = require 'request'

giving_service_api = process.env.giving_service_api
giving_service_token = process.env.giving_service_token

giveroom = "#give"

module.exports = (robot) ->
    robot.respond /give gift receipt (\d*)/i, (res) ->
        return if res.envelope.room != giveroom
        
        receipt = res.match[1]
        res.reply "Looking for gift with receipt " + receipt " ..."

        options =
            url: "#{giving_service_api}/gifts/#{receipt}"
            timeout: 2000
            headers: y
                "X-Auth-Token": giving_service_token

        request options, (error, response, body) ->
            json = JSON.parse body
            res.reply json