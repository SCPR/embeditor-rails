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

        oldDocumentWrite = document.write
        document.write = (html) => @wrapper.append(html)

        # Document embed
        if not isAnnotation and not window.DV
            $.getScript DocumentCloud.Scripts.Document,
                (script, textStatus, jqXHR) =>
                    @embed DocumentCloud.Template.Document
                        maxheight       : @queryParams.maxheight
                        maxwidth        : @queryParams.maxwidth
                        documentId      : documentId

                    @_resetDocumentWriteOverwrite(oldDocumentWrite)
            return true

        # Annotation embed
        if isAnnotation and not window.dc
            $.getScript DocumentCloud.Scripts.Annotation,
                (script, textStatus, jqXHR) =>
                    @embed DocumentCloud.Template.Annotation
                        maxheight       : @queryParams.maxheight
                        maxwidth        : @queryParams.maxwidth
                        documentId      : documentId
                        annotationId    : annotationId

                    @_resetDocumentWriteOverwrite(oldDocumentWrite)
            return true


    _resetDocumentWriteOverwrite: (oldDocumentWrite) ->
        setTimeout ->
            document.write = oldDocumentWrite
        , 500
