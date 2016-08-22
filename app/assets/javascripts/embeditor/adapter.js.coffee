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
        @service    = @element.data('service')

        @wrapper    = $("<#{@options.wrapperElement} />", {
            class: @options.wrapperClass + ' ' + @service
        })

        displayData     = @_extractData('DisplayDefaults')
        @display        = @_buildDisplayOptions(displayData)

        queryData       = @_extractData('QueryDefaults')
        @dataOptions    = queryData # Deprecated
        @queryParams    = @_buildQueryParams(queryData)


    # @Override
    #
    # Use this method to swap a placeholder with an embed. It should be
    # specified on a per-adapter basis.
    #
    # This method could have some logic to figure out the parameters,
    # parse the URL, whatever, and then will probably call `this.embed()`
    # to actually modify the DOM.
    swap: ->
        return


    # Put the embed inside the wrapper element, and then move the wrapper
    # element into place (relative to the placeholder link).
    #
    # This is a good function to call at the end of the swap() function.
    embed: (html) ->
        @wrapper.html(html)

        placementFunc = Embeditor.PlacementFunctions[@display.placement] ||
                        Embeditor.PlacementFunctions[@options.defaultPlacement]

        @element[placementFunc](@wrapper)



    _extractData: (defaults) ->
        data = {}

        for key,val of @element.data()
            # Make sure we care about this attribute
            if @adapter[defaults]?[key]
                data[key] = val

        data


    _buildDisplayOptions: (data) ->
        @_defaultsWithoutEmptyStrings(data, # What the user wants
            @options[@className]?['display'], # What the developer wants
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
        @_defaultsWithoutEmptyStrings(data,
            @options[@className]?['query'],
            @options['query'],
            @adapter.QueryDefaults
        )

    # Like Underscore.defaults, but it will also fill in empty strings.
    # This should be used when merging objects that includes any user
    # input.
    _defaultsWithoutEmptyStrings: (obj) ->
        args = Array.prototype.slice.call(arguments, 1)

        for source in args
            continue if !source

            for prop,value of source
                obj[prop] = source[prop] if !obj[prop] and value

        obj
