module.exports = (robot) ->
    robot.respond /friday me/i, (res) ->

        if (new Date()).getDay() == 5        
            res.reply "https://www.youtube.com/watch?v=kfVsfOSbJY0"
        else
            res.reply "Today is not Friday ;-("