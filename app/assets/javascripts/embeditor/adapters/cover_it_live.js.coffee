class Embeditor.Adapters.CoverItLive extends Embeditor.Adapters.StaticTemplate
    className: "CoverItLive"

    @Template = Embeditor.Template('cover_it_live')

    @QueryDefaults =
        maxwidth  : 620
        maxheight : 550

    @Matchers = [
        new RegExp /\/altcast_code=([^\/]+)\//i
    ]

    swap: ->
        # If the href doesn't match our known URL schemes
        # for this adapter, then let's not bother trying.
        match = @_parseUrl()
        return false if not match

        eventId = match[1]

        @embed CoverItLive.Template
            maxheight   : @queryParams.maxheight
            maxwidth    : @queryParams.maxwidth
            eventId     : eventId
