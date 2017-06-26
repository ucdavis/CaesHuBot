module.exports = (robot) ->
    robot.hear /, but don't quote me on that/i, (res) ->
        res.send "_"+ input_data.replace(/^(.*), but don't quote me on that/i, "\"$1\" - you said, here, just now" + "_")
