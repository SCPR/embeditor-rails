# Oembed adapters MUST define:
# * @Endpoint      - The URL to the oembed endpoint
#
# Oembed adapters SHOULD defined:
# * @QueryDefaults - The fallback query parameters if no others are specified.
class Embeditor.Adapters.Oembed extends Embeditor.Adapter
    className: "Oembed"

    # @Override
    #
    # The Oembed endpoint for the adapter.
    # Example: http://projects.scpr.org/firetracker/oembed
    @Endpoint = null


    swap: ->
        $.ajax
            url         : @adapter.Endpoint
            type        : 'GET'
            dataType    : 'json'
            data        :  _.extend(@queryParams, {url: @href})

            success: (data, textStatus, jqXHR) =>
                @embedData(data)

            error: (jqXHR, textStatus, errorThrown) =>
                console.log('[embeditor oembed] error.', jqXHR)


    # Embed differently based on the oEmbed response we got.
    #
    # If we have data.html, then use it.
    # If not, then that could mean one of a few things:
    # * It's a `photo` type, which we handle by just wrapping an <img> tag
    #   around the URL.
    # * It's a `link` type, which we can just leave alone because the
    #   embed placeholder is already there.
    # * It's an invalid oEmbed response, which we should also just leave alone
    #   and let the link serve its purpose.
    embedData: (data) ->
        return @embed(data.html) if data.html
        @_embedPhoto(data) if data.type is 'photo'



    # Embed a photo.
    # Pass in an object containing:
    # * URL to the image
    # * width of the image
    # * height of hte image
    _embedPhoto: (data) ->
        img = $('<img />', {
            src     : data.url,
            width   : data.width,
            height  : data.height
        })

        @embed(img)
