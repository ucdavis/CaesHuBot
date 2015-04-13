module.exports = (robot) ->
    robot.hear /summer/i, (res) ->
        res.reply "_Winter is coming_"