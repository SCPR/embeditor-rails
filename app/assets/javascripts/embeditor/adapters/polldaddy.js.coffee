class Embeditor.Adapters.Polldaddy extends Embeditor.Adapters.StaticTemplate
    @Template = JST[Embeditor.Adapter.TemplatePath + 'polldaddy']

    @QueryDefaults =
        maxheight : 550
        maxwidth  : 620

    @Matcher = new RegExp "http:\/\/([^/]+)/s/([^/]+)", "gi"


    swap: ->
        match       = Polldaddy.Matcher.exec(@href)
        domain      = match[1]
        poll_id     = match[2]

        @element.after Polldaddy.Template
            poll_id   : poll_id,
            domain    : domain
