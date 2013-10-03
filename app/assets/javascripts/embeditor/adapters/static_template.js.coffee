# StaticTemplate is for when you just want to hard-code the embed code
# into the /templates directory. This is either to avoid an expensive
# call to an oEmbed endpoint, or if there simply isn't another way to
# programatically retrieve the embed code.
class Embeditor.Adapters.StaticTemplate extends Embeditor.Adapter
    # The template to use.
    @Template = null

    # Query parameter defaults
    @QueryDefaults = {}

    # The matchers to extract the info out of the URL.
    @Matchers = []


    swap: ->
        # Extract the info and render the template
        return


    _parseUrl: ->
        match = null

        _.find @adapter.Matchers, (m) =>
            match = m.exec(@href)

        match
