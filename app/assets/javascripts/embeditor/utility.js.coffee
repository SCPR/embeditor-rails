class Embeditor.Utility
    @stripProtocol: (str) ->
        str.replace(/^https?:/, "")


    @stripTrailingSlash: (str) ->
        str.replace(/\/$/, "")


    @convertProtocolToHttp: (str) ->
        str.replace(/^https:/, 'http:')


    @convertProtocolToHttps: (str) ->
        str.replace(/^http:/, 'https:')
