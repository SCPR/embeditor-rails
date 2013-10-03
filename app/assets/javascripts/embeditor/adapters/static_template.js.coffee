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
        console.log @adapter.Matchers
        _.find @adapter.Matchers, (matcher) =>
            matcher.exec(@href)
