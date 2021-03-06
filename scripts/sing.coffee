﻿# Description:
#   Sing song lyrics
#   Limited to snippets due to copyright stuff
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot lyrics for <song> by <artist> - returns snippet of lyrics for this song
#
# Author:
#   mportiz08

cheerio = require('cheerio')

module.exports = (robot) ->
    current = null

    robot.respond /sing me (.*) by (.*)/i, (msg) ->
        song = msg.match[1]
        artist = msg.match[2]
        getLyrics msg, song, artist, msg.message.room
  
    robot.respond /sing (.*) by (.*) to @(\w+)/i, (msg) ->
        song = msg.match[1]
        artist = msg.match[2]
        target = msg.match[3]
        getLyrics msg, song, artist, target

    robot.respond /shut up/i, (msg) ->
        clearTimeout current if current != null
        current = null

    getLyrics = (msg, song, artist, room) ->
        msg.http("http://lyrics.wikia.com/api.php")
            .query(artist: artist, song: song, fmt: "json")
            .get() (err, res, body) ->
                meta = eval body # can't use JSON.parse :(

                msg.http(meta.url)
                    .query(action: 'edit')
                    .get() (err, res, body) ->
                        $ = cheerio.load body
                        lyrics = $("#wpTextbox1").val()
                        matches = lyrics.match /<lyrics>(.*\n)*<\/lyrics>/ig
                        match = matches[0]
                        match = match.substr 8, match.length - 17
                        singLyrics msg, match.split('\n'), 0, room

    singLyrics = (msg, lyrics, delay, room) ->
        line = lyrics.shift()
        current = setTimeout () ->
            robot.messageRoom room, line
            singLyrics msg, lyrics, line.length * 100, room
        , delay