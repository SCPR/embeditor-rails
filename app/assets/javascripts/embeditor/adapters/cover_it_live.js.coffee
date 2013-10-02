class Embeditor.Adapters.CoverItLive extends Embeditor.Adapter
    @Template = JST[Embeditor.Adapter.TemplatePath + 'cover_it_live_embed']

    @QueryDefaults =
        maxheight : 550,
        maxwidth  : 620


    constructor: (@element, options={}) ->
        @dataOptions = @_extractData()
        @queryParams = @_buildParams(@dataOptions, options)

        super


    swap: ->
        re = new RegExp "/altcast_code=([^/]+)/", "gi"
        event_id = re.exec(@href)[1]

        @element.replaceWith CoverItLive.Template
            maxheight   : @queryParams.maxheight,
            maxwidth    : @queryParams.maxwidth,
            event_id    : @event_id
