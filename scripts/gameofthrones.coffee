module.exports = (robot) ->
    robot.hear /game of thrones/i, (res) ->
        res.reply "_And Now My Watch Is Ended_"
