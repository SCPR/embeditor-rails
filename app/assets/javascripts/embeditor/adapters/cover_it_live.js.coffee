class Embeditor.Adapters.CoverItLive extends Embeditor.Adapter
    @Template = JST[Embeditor.Adapter.TemplatePath + 'cover_it_live']

    @QueryDefaults =
        maxheight : 550
        maxwidth  : 620

    @Matcher = new RegExp "/altcast_code=([^/]+)/", "gi"


    constructor: (@element, options={}) ->
        @dataOptions = @_extractData()
        @queryParams = @_buildParams(@dataOptions, options)

        super


    swap: ->
        event_id = CoverItLive.Matcher.exec(@href)[1]

        @element.after CoverItLive.Template
            maxheight   : @queryParams.maxheight,
            maxwidth    : @queryParams.maxwidth,
            event_id    : @event_id
