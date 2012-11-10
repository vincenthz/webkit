module Graphics.UI.Gtk.WebKit.DOM.Console
       (consoleTime, consoleGroupEnd, consoleGetMemory) where
import System.Glib.FFI
import System.Glib.UTFString
import Control.Applicative
{#import Graphics.UI.Gtk.WebKit.Types#}
import System.Glib.GError
import Graphics.UI.Gtk.WebKit.DOM.EventM
 
consoleTime :: (ConsoleClass self) => self -> String -> IO ()
consoleTime self title
  = withUTFString title $
      \ titlePtr ->
        {# call webkit_dom_console_time #} (toConsole self) titlePtr
 
consoleGroupEnd :: (ConsoleClass self) => self -> IO ()
consoleGroupEnd self
  = {# call webkit_dom_console_group_end #} (toConsole self)
 
consoleGetMemory ::
                 (ConsoleClass self) => self -> IO (Maybe MemoryInfo)
consoleGetMemory self
  = maybeNull (makeNewGObject mkMemoryInfo)
      ({# call webkit_dom_console_get_memory #} (toConsole self))
