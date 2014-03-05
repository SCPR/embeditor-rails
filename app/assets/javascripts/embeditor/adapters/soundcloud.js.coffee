# Soundcloud embed for the horizontal-type embed type.
class Embeditor.Adapters.Soundcloud extends Embeditor.Adapters.StaticTemplate
    className: "Soundcloud"

    @Template = Embeditor.Template('soundcloud')

    @QueryDefaults =
        maxwidth  : 612
        maxheight : 710

    @Matchers = [
        # https://soundcloud.com/bryanricker/deinus
        new RegExp /soundcloud\.com\/([^\/]+)\/([^\/]+)/i
    ]


    swap: ->
        match = @_parseUrl()
        return false if not match

        username = match[1]
        track = match[2]

        @embed Soundcloud.Template
            maxheight   : @queryParams.maxheight
            maxwidth    : @queryParams.maxwidth
