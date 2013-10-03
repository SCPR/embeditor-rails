class Embeditor.Adapters.Storify extends Embeditor.Adapters.StaticTemplate
    @Template = Embeditor.Template('storify')

    @QueryDefaults =
        maxheight : 750
        maxwidth  : 550

    # For storify, we just use the full URL, so no matchers are needed.
    @Matchers = []


    swap: ->
        # Storify's embed code doesn't provide a scheme (http/s), so let's
        # strip it out. We also want to make sure that there is no trailing
        # slash so that we can concatenate other things to the URL.
        url = @href.replace(/^https?:/, "").replace(/\/$/, "")

        # Storify embed is responsive, so we don't need to provide a width.
        @embed Storify.Template
            maxheight   : @queryParams.maxheight
            url         : url
