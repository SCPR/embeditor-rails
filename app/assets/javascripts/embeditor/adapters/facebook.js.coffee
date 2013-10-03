class Embeditor.Adapters.Facebook extends Embeditor.Adapters.StaticTemplate
    @Template = Embeditor.Template('facebook')

    @QueryDefaults =
        maxheight : 600
        maxwidth  : 550

    # For facebook, we just use the full URL, so no matchers are needed.
    @Matchers = []


    swap: ->
        @embed Facebook.Template(url : @href)
