class Embeditor.Adapters.DocumentCloud extends Embeditor.Adapters.StaticTemplate
    className: "DocumentCloud"

    @Template =
        Document    : Embeditor.Template('document_cloud_document')
        Annotation  : Embeditor.Template('document_cloud_annotation')

    @QueryDefaults =
        maxwidth  : 620
        maxheight : 550

    @Matchers = [
        new RegExp /\/documents\/([^\.]+)/i
        new RegExp(/\/documents\/(\d+)\/\/annotations\/(\d+)/i)
    ]

    @Scripts =
        Annotation : "http://s3.documentcloud.org/notes/loader.js"
        Document   : "http://s3.documentcloud.org/viewer/loader.js"


    swap: ->
        match = @_parseUrl()
        return false if not match

        # Did we get a third match group?
        # If so then it was an annotation URL.
        documentId   = match[1]
        annotationId = match[2]

        isAnnotation = !!annotationId

        oldDocumentWriteFunc = document.write
        document.write = (html) => @wrapper.append(html)

        # Document embed
        if not isAnnotation
            @embed DocumentCloud.Template.Document
                maxheight       : @queryParams.maxheight
                maxwidth        : @queryParams.maxwidth
                documentId      : documentId

            @_resetDocumentWrite(oldDocumentWriteFunc)
            return true

        # Annotation embed
        if isAnnotation
            @embed DocumentCloud.Template.Annotation
                maxheight       : @queryParams.maxheight
                maxwidth        : @queryParams.maxwidth
                documentId      : documentId
                annotationId    : annotationId

            @_resetDocumentWrite(oldDocumentWriteFunc)
            return true


    _resetDocumentWrite: (oldFunc) ->
        setTimeout ->
            document.write = oldFunc
        , 500
