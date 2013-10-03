class Embeditor.Adapters.CoverItLive extends Embeditor.Adapters.StaticTemplate
    @Template = Embeditor.Template('cover_it_live')

    @QueryDefaults =
        maxheight : 550
        maxwidth  : 620

    @Matchers = [
        new RegExp "/altcast_code=([^/]+)/", "gi"
    ]


    swap: ->
        # If the href doesn't match our known URL schemes
        # for this adapter, then let's not bother trying.
        match = @_parseUrl()
        return false if not match

        event_id = match[1]

        @embed CoverItLive.Template
            maxheight   : @queryParams.maxheight,
            maxwidth    : @queryParams.maxwidth,
            event_id    : event_id
