cheerio = require('cheerio')

module.exports = (robot) ->
    robot.respond /foodtruck/i, (msg) ->
      getTruckLocations(new Date().getDate(), msg)

    getTruckLocations = (date, msg) ->
        msg.http("http://sactomofo.com/uc-davis-calendar")
            .get() (err, response, body) ->
              $ = cheerio.load body
              # find the div for this date, then find sibling anchor tags
              linksForDate = $("td>div:contains(" + date + ")").next().find("a")

              # for each event we get back
              linksForDate.each (i, e) ->
                event = $(this)
                eventLocation = event.text()

                href = "http://sactomofo.com/" + event[0].attribs.href
                # console.log(href)

                msg.http(href)
                  .get() (err1, response1, body1) ->
                    # console.log(body1)
                    $event = cheerio.load body1

                    # this will only get ones with links
                    likedTrucks = $event("h4:contains('Participating Food Trucks')").nextUntil('span.addtocalendar').filter('a')

                    foodTruckList = $event("h4:contains('Participating Food Trucks')")[0]

                    # siblings = [];
                    # siblings.push()  while supply > demand

                    msg.send "*" + eventLocation + "*"
                    # TODO: get them without links, probably by traversing nextSibling
                    likedTrucks.each (index, element) ->
                      msg.send $event(this).text()
