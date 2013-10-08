class Embeditor.Adapters.Storify extends Embeditor.Adapters.StaticTemplate
    className: "Storify"

    @Template = Embeditor.Template('storify')

    @QueryDefaults =
        maxwidth  : 550
        maxheight : 750

    # For storify, we just use the full URL, so no matchers are needed.
    @Matchers = []


    swap: ->
        # Storify's embed code doesn't provide a protocol (http/s), so let's
        # strip it out. We also want to make sure that there is no trailing
        # slash so that we can concatenate other things to the URL.
        url = Embeditor.Utility.stripProtocol(
                Embeditor.Utility.stripTrailingSlash(@href))

        # Storify embed is responsive, so we don't need to provide a width.
        @embed Storify.Template
            maxheight   : @queryParams.maxheight
            url         : url
