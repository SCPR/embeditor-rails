class Embeditor.Adapters.StaticTemplate extends Embeditor.Adapter
    # The template to use.
    @Template = null

    # Query parameter defaults
    @QueryDefaults = {}

    # The matcher to extract the info out of the URL.
    @Matcher = new RegExp "http:\/\/([^/]+)/s/([^/]+)", "gi"


    constructor: (@element, options={}) ->
        @dataOptions = @_extractData()
        @queryParams = @_buildParams(@dataOptions, options)

        super


    swap: ->
        # Extract the info and render the template
        return
