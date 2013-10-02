class Embeditor.Adapters.Oembed extends Embeditor.Adapter
    # Override this. Oembed endpoint.
    @Path = null

    constructor: (@element, options={}) ->
        @dataOptions = @_extractData()
        @queryParams = @_buildParams(@dataOptions, options)

        super


    swap: ->
        $.getJSON(
            Embeditor.Adapters[@constructor.name].Path,
            _.extend({url: @href}, @queryParams),
            (data, textStatus, jqXHR) => @element.after(data.html)
        )
