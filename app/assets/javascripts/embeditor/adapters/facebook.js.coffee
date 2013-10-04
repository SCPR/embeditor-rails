class Embeditor.Adapters.Facebook extends Embeditor.Adapters.StaticTemplate
    @Template = Embeditor.Template('facebook')

    @QueryDefaults =
        maxwidth  : 550
        maxheight : 600

    # For facebook, we just use the full URL, so no matchers are needed.
    @Matchers = []


    swap: ->
        @embed Facebook.Template
            maxheight   : @queryParams.maxheight,
            maxwidth    : @queryParams.maxwidth,
            url         : @href
