class Embeditor.Adapters.Twitter extends Embeditor.Adapters.StaticTemplate
    @Template = Embeditor.Template('twitter')

    @QueryDefaults =
        maxheight : 550
        maxwidth  : 620

    # For twitter, we just use the full URL, so no matchers are needed.
    @Matchers = []


    swap: ->
        @embed Twitter.Template(url : @href)
