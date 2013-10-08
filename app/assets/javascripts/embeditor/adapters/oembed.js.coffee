# Oembed adapters MUST define:
# * @Endpoint      - The URL to the oembed endpoint
#
# Oembed adapters SHOULD defined:
# * @QueryDefaults - The fallback query parameters if no others are specified.
class Embeditor.Adapters.Oembed extends Embeditor.Adapter
    className: "Oembed"

    # Override this. Oembed endpoint.
    @Endpoint = null

    swap: ->
        $.ajax
            url         : @adapter.Endpoint
            type        : 'GET'
            dataType    : 'json'
            data        :  _.extend(@queryParams, {url: @href})

            success: (data, textStatus, jqXHR) =>
                @embed data.html

            error: (jqXHR, textStatus, errorThrown) =>
                console.log('[embeditor oembed] error.', jqXHR)
