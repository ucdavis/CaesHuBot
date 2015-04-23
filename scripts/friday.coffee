monday_video = "https://www.youtube.com/watch?v=eWM2joNb9NE"
friday_video = "https://www.youtube.com/watch?v=kfVsfOSbJY0"

days = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]

notvideo = (notday) -> 
    today = days[(new Date()).getDay()]
    "Today is #{today}, not #{notday} ;-("

module.exports = (robot) ->
    robot.response /monday me(\sanyway)?/i, (res) ->
        if (new Date()).getDay() == 1 || res.match[1]     
            res.reply monday_video
        else
            res.reply notvideo days[1]

    robot.respond /friday me(\sanyway)?/i, (res) ->
        if (new Date()).getDay() == 5 || res.match[1]     
            res.reply friday_video
        else
            res.reply notvideo days[5]

    robot.respond /friday @(\w+)(\sanyway)?/i, (res) ->
        recipient = res.match[1]
        if (new Date()).getDay() == 5 || res.match[2]
            res.reply "Okay!"
            robot.messageRoom recipient, "#{recipient}: #{friday_video}"
        else
            res.reply notvideo days[5]
            