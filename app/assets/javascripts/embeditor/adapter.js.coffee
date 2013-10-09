# Your Adapter SHOULD define:
# * @QueryDefaults - The default parameters if no others are passed in.

class Embeditor.Adapter
    className: "Adapter"

    @QueryDefaults = {}

    constructor: (@element, @options={}) ->
        @adapter        = Embeditor.Adapters[@className]
        @href           = @element.attr('href')
        @dataOptions    = @_extractData()
        @queryParams    = @_buildParams(@dataOptions, options)

        @wrapper        = $("<div />", class: @options.wrapperClass)


    swap: ->
        return


    embed: (html) ->
        @wrapper.html(html)
        @element.after @wrapper


    _extractData: ->
        dataOptions = {}

        for key,val of @element.data()
            # Make sure we care about this attribute
            if @adapter.QueryDefaults?[key]
                dataOptions[key] = val

        dataOptions


    # We're combining a few things (in order of precedence):
    # 1. The `data-attributes` of the placeholder,
    # 2. The adapter-specific options specified at Embeditor
    #    initialization,
    # 3. The global options specified at Embeditor initialization,
    # 4. This adapter's default options (fallback options).
    _buildParams: (dataOptions, options) ->
        _.defaults(dataOptions,
            @adapter.query,
            options['query'],
            @adapter.QueryDefaults
        )
