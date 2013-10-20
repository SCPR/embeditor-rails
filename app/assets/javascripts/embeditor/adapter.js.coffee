# Your Adapter SHOULD define:
# * @QueryDefaults - The default parameters if no others are passed in.

class Embeditor.Adapter
    className: "Adapter"

    @QueryDefaults = {}

    @DisplayDefaults =
        placement : 'after'


    constructor: (@element, @options={}) ->
        @adapter    = Embeditor.Adapters[@className]
        @href       = @element.attr('href')
        @wrapper    = $("<div />", class: @options.wrapperClass)

        displayData     = @_extractData('DisplayDefaults')
        @display        = @_buildDisplayOptions(displayData)

        queryData       = @_extractData('QueryDefaults')
        @dataOptions    = queryData # Deprecated
        @queryParams    = @_buildQueryParams(queryData)


    # @Override
    swap: ->
        return


    embed: (html) ->
        @wrapper.html(html)
        @element[Embeditor.PlacementFunctions(@display.placement)](@wrapper)



    _extractData: (defaults) ->
        data = {}

        for key,val of @element.data()
            # Make sure we care about this attribute
            if @adapter[defaults]?[key]
                data[key] = val

        data


    _buildDisplayOptions: (data) ->
        _.defaults(data, # What the user wants
            @options[@adapter]?['display'], # What the developer wants
            @options['display'], # What the developer wants globally
            @adapter.DisplayDefaults # What Embeditor wants
        )


    # We're combining a few things (in order of precedence):
    # 1. The `data-attributes` of the placeholder,
    # 2. The adapter-specific options specified at Embeditor
    #    initialization,
    # 3. The global options specified at Embeditor initialization,
    # 4. This adapter's default options (fallback options).
    _buildQueryParams: (data) ->
        _.defaults(data,
            @options[@adapter]?['query'],
            @options['query'],
            @adapter.QueryDefaults
        )
