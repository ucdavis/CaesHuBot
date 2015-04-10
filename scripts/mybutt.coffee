module.exports = (robot) ->
    robot.hear /the cloud/i, (res) ->
        res.send "_" + res.message.text.replace(/the cloud/gi, "my butt") + "_"