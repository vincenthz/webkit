module Graphics.UI.Gtk.WebKit.DOM.XMLHttpRequest
       (xmlHttpRequestSetRequestHeader, xmlHttpRequestAbort,
        xmlHttpRequestGetAllResponseHeaders,
        xmlHttpRequestGetResponseHeader, xmlHttpRequestOverrideMimeType,
        xmlHttpRequestDispatchEvent, cUNSENT, cOPENED, cHEADERS_RECEIVED,
        cLOADING, cDONE, xmlHttpRequestOnabort, xmlHttpRequestOnerror,
        xmlHttpRequestOnload, xmlHttpRequestOnloadend,
        xmlHttpRequestOnloadstart, xmlHttpRequestOnprogress,
        xmlHttpRequestOnreadystatechange, xmlHttpRequestGetReadyState,
        xmlHttpRequestSetAsBlob, xmlHttpRequestGetAsBlob,
        xmlHttpRequestSetWithCredentials, xmlHttpRequestGetWithCredentials,
        xmlHttpRequestGetUpload, xmlHttpRequestGetResponseXML,
        xmlHttpRequestGetResponseBlob, xmlHttpRequestSetResponseType,
        xmlHttpRequestGetResponseType, xmlHttpRequestGetStatus,
        xmlHttpRequestGetStatusText)
       where
import System.Glib.FFI
import System.Glib.UTFString
import Control.Applicative
{#import Graphics.UI.Gtk.WebKit.Types#}
import System.Glib.GError
import Graphics.UI.Gtk.WebKit.DOM.EventM
 
xmlHttpRequestSetRequestHeader ::
                               (XMLHttpRequestClass self) => self -> String -> String -> IO ()
xmlHttpRequestSetRequestHeader self header value
  = propagateGError $
      \ errorPtr_ ->
        withUTFString value $
          \ valuePtr ->
            withUTFString header $
              \ headerPtr ->
                {# call webkit_dom_xml_http_request_set_request_header #}
                  (toXMLHttpRequest self)
                  headerPtr
              valuePtr
          errorPtr_
 
xmlHttpRequestAbort :: (XMLHttpRequestClass self) => self -> IO ()
xmlHttpRequestAbort self
  = {# call webkit_dom_xml_http_request_abort #}
      (toXMLHttpRequest self)
 
xmlHttpRequestGetAllResponseHeaders ::
                                    (XMLHttpRequestClass self) => self -> IO String
xmlHttpRequestGetAllResponseHeaders self
  = (propagateGError $
       \ errorPtr_ ->
         {# call webkit_dom_xml_http_request_get_all_response_headers #}
           (toXMLHttpRequest self)
           errorPtr_)
      >>=
      readUTFString
 
xmlHttpRequestGetResponseHeader ::
                                (XMLHttpRequestClass self) => self -> String -> IO String
xmlHttpRequestGetResponseHeader self header
  = (propagateGError $
       \ errorPtr_ ->
         withUTFString header $
           \ headerPtr ->
             {# call webkit_dom_xml_http_request_get_response_header #}
               (toXMLHttpRequest self)
               headerPtr
           errorPtr_)
      >>=
      readUTFString
 
xmlHttpRequestOverrideMimeType ::
                               (XMLHttpRequestClass self) => self -> String -> IO ()
xmlHttpRequestOverrideMimeType self override
  = withUTFString override $
      \ overridePtr ->
        {# call webkit_dom_xml_http_request_override_mime_type #}
          (toXMLHttpRequest self)
          overridePtr
 
xmlHttpRequestDispatchEvent ::
                            (XMLHttpRequestClass self, EventClass evt) =>
                              self -> Maybe evt -> IO Bool
xmlHttpRequestDispatchEvent self evt
  = toBool <$>
      (propagateGError $
         \ errorPtr_ ->
           {# call webkit_dom_xml_http_request_dispatch_event #}
             (toXMLHttpRequest self)
             (maybe (Event nullForeignPtr) toEvent evt)
             errorPtr_)
cUNSENT = 0
cOPENED = 1
cHEADERS_RECEIVED = 2
cLOADING = 3
cDONE = 4
 
xmlHttpRequestOnabort ::
                      (XMLHttpRequestClass self) => Signal self (EventM UIEvent self ())
xmlHttpRequestOnabort = (connect "abort")
 
xmlHttpRequestOnerror ::
                      (XMLHttpRequestClass self) => Signal self (EventM UIEvent self ())
xmlHttpRequestOnerror = (connect "error")
 
xmlHttpRequestOnload ::
                     (XMLHttpRequestClass self) => Signal self (EventM UIEvent self ())
xmlHttpRequestOnload = (connect "load")
 
xmlHttpRequestOnloadend ::
                        (XMLHttpRequestClass self) => Signal self (EventM UIEvent self ())
xmlHttpRequestOnloadend = (connect "loadend")
 
xmlHttpRequestOnloadstart ::
                          (XMLHttpRequestClass self) => Signal self (EventM UIEvent self ())
xmlHttpRequestOnloadstart = (connect "loadstart")
 
xmlHttpRequestOnprogress ::
                         (XMLHttpRequestClass self) => Signal self (EventM UIEvent self ())
xmlHttpRequestOnprogress = (connect "progress")
 
xmlHttpRequestOnreadystatechange ::
                                 (XMLHttpRequestClass self) => Signal self (EventM UIEvent self ())
xmlHttpRequestOnreadystatechange = (connect "readystatechange")
 
xmlHttpRequestGetReadyState ::
                            (XMLHttpRequestClass self) => self -> IO Word
xmlHttpRequestGetReadyState self
  = fromIntegral <$>
      ({# call webkit_dom_xml_http_request_get_ready_state #}
         (toXMLHttpRequest self))
 
xmlHttpRequestSetAsBlob ::
                        (XMLHttpRequestClass self) => self -> Bool -> IO ()
xmlHttpRequestSetAsBlob self val
  = propagateGError $
      \ errorPtr_ ->
        {# call webkit_dom_xml_http_request_set_as_blob #}
          (toXMLHttpRequest self)
          (fromBool val)
          errorPtr_
 
xmlHttpRequestGetAsBlob ::
                        (XMLHttpRequestClass self) => self -> IO Bool
xmlHttpRequestGetAsBlob self
  = toBool <$>
      ({# call webkit_dom_xml_http_request_get_as_blob #}
         (toXMLHttpRequest self))
 
xmlHttpRequestSetWithCredentials ::
                                 (XMLHttpRequestClass self) => self -> Bool -> IO ()
xmlHttpRequestSetWithCredentials self val
  = propagateGError $
      \ errorPtr_ ->
        {# call webkit_dom_xml_http_request_set_with_credentials #}
          (toXMLHttpRequest self)
          (fromBool val)
          errorPtr_
 
xmlHttpRequestGetWithCredentials ::
                                 (XMLHttpRequestClass self) => self -> IO Bool
xmlHttpRequestGetWithCredentials self
  = toBool <$>
      ({# call webkit_dom_xml_http_request_get_with_credentials #}
         (toXMLHttpRequest self))
 
xmlHttpRequestGetUpload ::
                        (XMLHttpRequestClass self) =>
                          self -> IO (Maybe XMLHttpRequestUpload)
xmlHttpRequestGetUpload self
  = maybeNull (makeNewGObject mkXMLHttpRequestUpload)
      ({# call webkit_dom_xml_http_request_get_upload #}
         (toXMLHttpRequest self))
 
xmlHttpRequestGetResponseXML ::
                             (XMLHttpRequestClass self) => self -> IO (Maybe Document)
xmlHttpRequestGetResponseXML self
  = maybeNull (makeNewGObject mkDocument)
      (propagateGError $
         \ errorPtr_ ->
           {# call webkit_dom_xml_http_request_get_response_xml #}
             (toXMLHttpRequest self)
             errorPtr_)
 
xmlHttpRequestGetResponseBlob ::
                              (XMLHttpRequestClass self) => self -> IO (Maybe Blob)
xmlHttpRequestGetResponseBlob self
  = maybeNull (makeNewGObject mkBlob)
      (propagateGError $
         \ errorPtr_ ->
           {# call webkit_dom_xml_http_request_get_response_blob #}
             (toXMLHttpRequest self)
             errorPtr_)
 
xmlHttpRequestSetResponseType ::
                              (XMLHttpRequestClass self) => self -> String -> IO ()
xmlHttpRequestSetResponseType self val
  = propagateGError $
      \ errorPtr_ ->
        withUTFString val $
          \ valPtr ->
            {# call webkit_dom_xml_http_request_set_response_type #}
              (toXMLHttpRequest self)
              valPtr
          errorPtr_
 
xmlHttpRequestGetResponseType ::
                              (XMLHttpRequestClass self) => self -> IO String
xmlHttpRequestGetResponseType self
  = ({# call webkit_dom_xml_http_request_get_response_type #}
       (toXMLHttpRequest self))
      >>=
      readUTFString
 
xmlHttpRequestGetStatus ::
                        (XMLHttpRequestClass self) => self -> IO Word
xmlHttpRequestGetStatus self
  = fromIntegral <$>
      (propagateGError $
         \ errorPtr_ ->
           {# call webkit_dom_xml_http_request_get_status #}
             (toXMLHttpRequest self)
             errorPtr_)
 
xmlHttpRequestGetStatusText ::
                            (XMLHttpRequestClass self) => self -> IO String
xmlHttpRequestGetStatusText self
  = (propagateGError $
       \ errorPtr_ ->
         {# call webkit_dom_xml_http_request_get_status_text #}
           (toXMLHttpRequest self)
           errorPtr_)
      >>=
      readUTFString
