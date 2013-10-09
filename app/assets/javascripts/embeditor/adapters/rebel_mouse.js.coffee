class Embeditor.Adapters.RebelMouse extends Embeditor.Adapters.StaticTemplate
    className: "RebelMouse"

    @Template = Embeditor.Template('rebel_mouse')

    @QueryDefaults =
        maxwidth  : 620
        maxheight : 550

    @Matchers = [
        new RegExp /rebelmouse\.com\/(.+?)\/?$/i
    ]

    swap: ->
        match = @_parseUrl()
        return false if not match

        site = encodeURIComponent(match[1])

        @embed RebelMouse.Template
            maxheight   : @queryParams.maxheight
            maxwidth    : @queryParams.maxwidth
            site        : site
