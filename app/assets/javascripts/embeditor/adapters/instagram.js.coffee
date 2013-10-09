# Instagram's oembed endpoint returns "photo" oembed types (instead of "rich"),
# and only a URL to the photo, not an actual embed code. Therefore, we need to
# use StaticTemplate to use the iframe embed code.
class Embeditor.Adapters.Instagram extends Embeditor.Adapters.StaticTemplate
    className: "Instagram"

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

        photoId = match[1]

        @embed Instagram.Template
            maxheight   : @queryParams.maxheight
            maxwidth    : @queryParams.maxwidth
            photoId     : photoId
