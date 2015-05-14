babygif = ['https://files.slack.com/files-pri/T042YLLUU-F04SU6D49/20150412_225548000_ios.gif']

module.exports = (robot) ->
    robot.respond /get me that dancing baby gif/i, (res) ->
        res.reply babygif