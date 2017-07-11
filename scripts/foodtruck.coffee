cheerio = require('cheerio')

module.exports = (robot) ->
    robot.hear /foodtruck/i, (msg) ->
      getTruckLocations(16, msg)

    getTruckLocations = (date, msg) ->
        msg.http("http://sactomofo.com/uc-davis-calendar")
            .get() (err, response, body) ->
              $ = cheerio.load body
              # find the div for this date, then find sibling anchor tags
              linksForDate = $("td>div:contains(12)").next().find("a")

              # for now, just choose first one
              firstEvent = linksForDate[0]

              href = "http://sactomofo.com/" + firstEvent.attribs.href

              # console.log(href)
              msg.http(href)
                .get() (err1, response1, body1) ->
                  # console.log(body1)
                  $event = cheerio.load body1

                  location = $event("article>section h3>span").text()

                  msg.send "**" + location + "**"

                  # this will only get ones with links
                  likedTrucks = $event("h4:contains('Participating Food Trucks')").nextUntil('span.addtocalendar').filter('a')

                  # TODO: get them without links
                  likedTrucks.each (index, element) ->
                    msg.send $event(this).text()
