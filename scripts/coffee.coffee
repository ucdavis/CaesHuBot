module.exports = (robot) ->
    robot.respond /coffee me/i, (res) ->        
        res.reply "Sure thing, I just need to find some beans... (this may take a while)"

        setTimeout () ->
            res.reply "_grinds beans_"
            , 60 * 1000

        setTimeout () ->
            res.reply "_heats up water_"
            , 2 * 60 * 1000

        setTimeout () ->
            res.reply "Water is ready!"
            , 3 * 60 * 1000

        setTimeout () ->
            res.reply "_pours water_"
            , 3.1 * 60 * 1000

        setTimeout () ->
            res.reply "Here you go! :coffee:"
            , 9 * 60 * 1000