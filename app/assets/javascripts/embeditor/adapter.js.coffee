# Your Adapter should define:
# * QueryDefaults - an object of defaults to send as query parameters

class Embeditor.Adapter
    @TemplatePath = "embeditor/templates/"

    constructor: (@element, options={}) ->
        @href = @element.attr('href')


    swap: ->
        return


    _extractData: ->
        adapter = @constructor.name
        dataOptions = {}

        for key,val of @element.data()
            # Make sure we care about this attribute
            if Embeditor.Adapters[adapter].QueryDefaults?[key]
                dataOptions[key] = val

        dataOptions


    # We're combining a few things (in order of precedence):
    # 1. The `data-attributes` of the placeholder,
    # 2. The adapter-specific options specified at Embeditor
    #    initialization,
    # 3. The global options specified at Embeditor initialization,
    # 4. This adapter's default options (fallback options).
    _buildParams: (dataOptions, options) ->
        adapter = @constructor.name

        _.defaults(dataOptions,
            options[adapter]?['query'], options['query']
            Embeditor.Adapters[adapter].QueryDefaults)
