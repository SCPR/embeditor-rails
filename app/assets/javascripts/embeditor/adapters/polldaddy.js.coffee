class Embeditor.Adapters.Polldaddy extends Embeditor.Adapter
    @Template = JST[Embeditor.Adapter.TemplatePath + 'polldaddy']

    @QueryDefaults =
        maxheight : 550
        maxwidth  : 620

    @Matcher = new RegExp "http:\/\/([^/]+)/s/([^/]+)", "gi"


    constructor: (@element, options={}) ->
        @dataOptions = @_extractData()
        @queryParams = @_buildParams(@dataOptions, options)

        super


    swap: ->
        match       = Polldaddy.Matcher.exec(@href)
        domain      = match[1]
        poll_id     = match[2]

        console.log poll_id, domain
        @element.after Polldaddy.Template
            poll_id   : poll_id,
            domain    : domain
