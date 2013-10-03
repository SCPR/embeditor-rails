class Embeditor.Adapters.Oembed extends Embeditor.Adapter
    # Override this. Oembed endpoint.
    @Path = null

    swap: ->
        $.ajax
            url         : @adapter.Path
            type        : 'GET'
            dataType    : 'json'
            data        :  _.extend(@queryParams, {url: @href})

            success: (data, textStatus, jqXHR) =>
                @embed data.html

            error: (jqXHR, textStatus, errorThrown) =>
                console.log('[embeditor oembed] error.', jqXHR)
