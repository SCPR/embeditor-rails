class Embeditor.Adapters.GoogleMaps extends Embeditor.Adapters.StaticTemplate
    @MapTarget = 'gmap-embed'
    @Template = Embeditor.Template('google_maps')

    @QueryDefaults =
        maxwidth  : 425
        maxheight : 350

    # https://maps.google.com/maps?q=1600+Pennsylvania+Ave+NW,+Washington,+D.C.,+DC&hl=en&ll=38.899082,-77.038493&spn=0.009869,0.01442&sll=37.269174,-119.306607&sspn=12.963384,18.808594&oq=1600+Pen&hnear=1600+Pennsylvania+Ave+NW,+Washington,+District+of+Columbia+20500&t=m&z=16
    @Matchers = [
        new RegExp "maps\.google\.com.+ll=([^&]+)", "gi"
    ]


    swap: ->
        # Make sure the URL is usable before loading all this JS.
        match = @_parseUrl()
        return false if not match

        latlng  = match[1].split(',')
        lat     = parseFloat(latlng[0])
        lng     = parseFloat(latlng[1])

        mapOpts =
            center      : new google.maps.LatLng(lat, lng)
            zoom        : 10
            mapTypeId   : google.maps.MapTypeId.ROADMAP

        @embed GoogleMaps.Template
            targetClass     : GoogleMaps.MapTarget
            maxheight       : @queryParams.maxheight
            maxwidth        : @queryParams.maxwidth

        new google.maps.Map($(".#{GoogleMaps.MapTarget}", @wrapper)[0], mapOpts)
