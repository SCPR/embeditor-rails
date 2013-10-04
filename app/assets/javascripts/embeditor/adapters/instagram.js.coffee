# Instagram's oembed endpoint returns "photo" oembed types (instead of "rich"),
# and only a URL to the photo, not an actual embed code. Therefore, we need to
# use StaticTemplate to use the iframe embed code.
class Embeditor.Adapters.Instagram extends Embeditor.Adapters.StaticTemplate
    @Template = Embeditor.Template('instagram')

    @QueryDefaults =
        maxwidth  : 612
        maxheight : 710

    @Matchers = [
        # http://instagram.com/p/e8hJe6CvTW/
        new RegExp "instagram\.com\/p\/([^/]+)", "gi"
    ]


    swap: ->
        match = @_parseUrl()
        return false if not match

        photo_id = match[1]

        @embed Instagram.Template
            maxheight   : @queryParams.maxheight
            maxwidth    : @queryParams.maxwidth
            photo_id    : photo_id
