video = "https://www.youtube.com/watch?v=kfVsfOSbJY0"
notvideo = "Today is not Friday ;-("

module.exports = (robot) ->
    robot.respond /friday me(\sanyway)?/i, (res) ->

        if (new Date()).getDay() == 5 || msg.match[1]     
            res.reply video
        else
            res.reply notvideo

    robot.respond /friday @(\w)(\sanyway)?/i, (res) ->
        recipient = msg.match[1]
        if (new Date()).getDay() == 5 || msg.match[2]
            res.reply "Okay!"
            res.messageRoom recipient, "#{recipient}: #{video}"
        else
            res.reply notvideo
            