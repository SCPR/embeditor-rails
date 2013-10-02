class Embeditor.Adapters.CoverItLive extends Embeditor.Adapters.StaticTemplate
    @Template = JST[Embeditor.Adapter.TemplatePath + 'cover_it_live']

    @QueryDefaults =
        maxheight : 550
        maxwidth  : 620

    @Matcher = new RegExp "/altcast_code=([^/]+)/", "gi"


    swap: ->
        event_id = CoverItLive.Matcher.exec(@href)[1]

        @element.after CoverItLive.Template
            maxheight   : @queryParams.maxheight,
            maxwidth    : @queryParams.maxwidth,
            event_id    : @event_id
