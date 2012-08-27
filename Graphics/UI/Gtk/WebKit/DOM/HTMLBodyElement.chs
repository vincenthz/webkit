module Graphics.UI.Gtk.WebKit.DOM.HTMLBodyElement
       (htmlBodyElementSetALink, htmlBodyElementGetALink,
        htmlBodyElementSetBackground, htmlBodyElementGetBackground,
        htmlBodyElementSetBgColor, htmlBodyElementGetBgColor,
        htmlBodyElementSetLink, htmlBodyElementGetLink,
        htmlBodyElementSetText, htmlBodyElementGetText,
        htmlBodyElementSetVLink, htmlBodyElementGetVLink,
        htmlBodyElementOnbeforeunload, htmlBodyElementOnhashchange,
        htmlBodyElementOnmessage, htmlBodyElementOnoffline,
        htmlBodyElementOnonline, htmlBodyElementOnpopstate,
        htmlBodyElementOnresize, htmlBodyElementOnstorage,
        htmlBodyElementOnunload, htmlBodyElementOnorientationchange,
        htmlBodyElementOnblur, htmlBodyElementOnerror,
        htmlBodyElementOnfocus, htmlBodyElementOnload)
       where
import System.Glib.FFI
import System.Glib.UTFString
import Control.Applicative
{#import Graphics.UI.Gtk.WebKit.Types#}
import System.Glib.GError
import Graphics.UI.Gtk.WebKit.DOM.EventM
 
htmlBodyElementSetALink ::
                        (HTMLBodyElementClass self) => self -> String -> IO ()
htmlBodyElementSetALink self val
  = withUTFString val $
      \ valPtr ->
        {# call webkit_dom_html_body_element_set_a_link #}
          (toHTMLBodyElement self)
          valPtr
 
htmlBodyElementGetALink ::
                        (HTMLBodyElementClass self) => self -> IO String
htmlBodyElementGetALink self
  = ({# call webkit_dom_html_body_element_get_a_link #}
       (toHTMLBodyElement self))
      >>=
      readUTFString
 
htmlBodyElementSetBackground ::
                             (HTMLBodyElementClass self) => self -> String -> IO ()
htmlBodyElementSetBackground self val
  = withUTFString val $
      \ valPtr ->
        {# call webkit_dom_html_body_element_set_background #}
          (toHTMLBodyElement self)
          valPtr
 
htmlBodyElementGetBackground ::
                             (HTMLBodyElementClass self) => self -> IO String
htmlBodyElementGetBackground self
  = ({# call webkit_dom_html_body_element_get_background #}
       (toHTMLBodyElement self))
      >>=
      readUTFString
 
htmlBodyElementSetBgColor ::
                          (HTMLBodyElementClass self) => self -> String -> IO ()
htmlBodyElementSetBgColor self val
  = withUTFString val $
      \ valPtr ->
        {# call webkit_dom_html_body_element_set_bg_color #}
          (toHTMLBodyElement self)
          valPtr
 
htmlBodyElementGetBgColor ::
                          (HTMLBodyElementClass self) => self -> IO String
htmlBodyElementGetBgColor self
  = ({# call webkit_dom_html_body_element_get_bg_color #}
       (toHTMLBodyElement self))
      >>=
      readUTFString
 
htmlBodyElementSetLink ::
                       (HTMLBodyElementClass self) => self -> String -> IO ()
htmlBodyElementSetLink self val
  = withUTFString val $
      \ valPtr ->
        {# call webkit_dom_html_body_element_set_link #}
          (toHTMLBodyElement self)
          valPtr
 
htmlBodyElementGetLink ::
                       (HTMLBodyElementClass self) => self -> IO String
htmlBodyElementGetLink self
  = ({# call webkit_dom_html_body_element_get_link #}
       (toHTMLBodyElement self))
      >>=
      readUTFString
 
htmlBodyElementSetText ::
                       (HTMLBodyElementClass self) => self -> String -> IO ()
htmlBodyElementSetText self val
  = withUTFString val $
      \ valPtr ->
        {# call webkit_dom_html_body_element_set_text #}
          (toHTMLBodyElement self)
          valPtr
 
htmlBodyElementGetText ::
                       (HTMLBodyElementClass self) => self -> IO String
htmlBodyElementGetText self
  = ({# call webkit_dom_html_body_element_get_text #}
       (toHTMLBodyElement self))
      >>=
      readUTFString
 
htmlBodyElementSetVLink ::
                        (HTMLBodyElementClass self) => self -> String -> IO ()
htmlBodyElementSetVLink self val
  = withUTFString val $
      \ valPtr ->
        {# call webkit_dom_html_body_element_set_v_link #}
          (toHTMLBodyElement self)
          valPtr
 
htmlBodyElementGetVLink ::
                        (HTMLBodyElementClass self) => self -> IO String
htmlBodyElementGetVLink self
  = ({# call webkit_dom_html_body_element_get_v_link #}
       (toHTMLBodyElement self))
      >>=
      readUTFString
 
htmlBodyElementOnbeforeunload ::
                              (HTMLBodyElementClass self) => Signal self (EventM UIEvent self ())
htmlBodyElementOnbeforeunload = (connect "beforeunload")
 
htmlBodyElementOnhashchange ::
                            (HTMLBodyElementClass self) => Signal self (EventM UIEvent self ())
htmlBodyElementOnhashchange = (connect "hashchange")
 
htmlBodyElementOnmessage ::
                         (HTMLBodyElementClass self) => Signal self (EventM UIEvent self ())
htmlBodyElementOnmessage = (connect "message")
 
htmlBodyElementOnoffline ::
                         (HTMLBodyElementClass self) => Signal self (EventM UIEvent self ())
htmlBodyElementOnoffline = (connect "offline")
 
htmlBodyElementOnonline ::
                        (HTMLBodyElementClass self) => Signal self (EventM UIEvent self ())
htmlBodyElementOnonline = (connect "online")
 
htmlBodyElementOnpopstate ::
                          (HTMLBodyElementClass self) => Signal self (EventM UIEvent self ())
htmlBodyElementOnpopstate = (connect "popstate")
 
htmlBodyElementOnresize ::
                        (HTMLBodyElementClass self) => Signal self (EventM UIEvent self ())
htmlBodyElementOnresize = (connect "resize")
 
htmlBodyElementOnstorage ::
                         (HTMLBodyElementClass self) => Signal self (EventM UIEvent self ())
htmlBodyElementOnstorage = (connect "storage")
 
htmlBodyElementOnunload ::
                        (HTMLBodyElementClass self) => Signal self (EventM UIEvent self ())
htmlBodyElementOnunload = (connect "unload")
 
htmlBodyElementOnorientationchange ::
                                   (HTMLBodyElementClass self) =>
                                     Signal self (EventM UIEvent self ())
htmlBodyElementOnorientationchange = (connect "orientationchange")
 
htmlBodyElementOnblur ::
                      (HTMLBodyElementClass self) => Signal self (EventM UIEvent self ())
htmlBodyElementOnblur = (connect "blur")
 
htmlBodyElementOnerror ::
                       (HTMLBodyElementClass self) => Signal self (EventM UIEvent self ())
htmlBodyElementOnerror = (connect "error")
 
htmlBodyElementOnfocus ::
                       (HTMLBodyElementClass self) => Signal self (EventM UIEvent self ())
htmlBodyElementOnfocus = (connect "focus")
 
htmlBodyElementOnload ::
                      (HTMLBodyElementClass self) => Signal self (EventM UIEvent self ())
htmlBodyElementOnload = (connect "load")
