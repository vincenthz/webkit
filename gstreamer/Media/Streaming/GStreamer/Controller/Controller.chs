--  GIMP Toolkit (GTK) Binding for Haskell: binding to gstreamer -*-haskell-*-
--
--  Author : Peter Gavin
--  Created: 1-Apr-2007
--
--  Copyright (c) 2007 Peter Gavin
--
--  This library is free software: you can redistribute it and/or
--  modify it under the terms of the GNU Lesser General Public License
--  as published by the Free Software Foundation, either version 3 of
--  the License, or (at your option) any later version.
--  
--  This library is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
--  Lesser General Public License for more details.
--  
--  You should have received a copy of the GNU Lesser General Public
--  License along with this program.  If not, see
--  <http://www.gnu.org/licenses/>.
--  
--  GStreamer, the C library which this Haskell library depends on, is
--  available under LGPL Version 2. The documentation included with
--  this library is based on the original GStreamer documentation.
--  
-- | Maintainer  : gtk2hs-devel@lists.sourceforge.net
--   Stability   : alpha
--   Portability : portable (depends on GHC)
module Media.Streaming.GStreamer.Controller.Controller (
  
  Controller,
  ControllerClass,
  
  ) where

import Control.Monad (liftM)
{#import Media.Streaming.GStreamer.Controller.Types#}
{#import System.Glib.GList#}
{#import System.Glib.GObject#}
import System.Glib.FFI
import System.Glib.UTFString

{# context lib = "gstreamer" prefix = "gst" #}

controllerInit :: IO Bool
controllerInit =
    liftM toBool $ {# call controller_init #} nullPtr nullPtr

controllerNew :: GObjectClass gObjectT
              => gObjectT
              -> [String]
              -> IO Controller
controllerNew object properties =
    withMany withUTFString properties $ \cProperties ->
        do cPropertiesGList <- toGList cProperties
           cController <- {# call controller_new_list #} (toGObject object) cPropertiesGList
           {# call g_list_free #} cPropertiesGList
           constructNewGObject Controller $ return cController

controllerRemoveProperties :: ControllerClass controllerT
                           => controllerT
                           -> [String]
                           -> IO Bool
controllerRemoveProperties controller properties =
    withMany withUTFString properties $ \cProperties ->
        do cPropertiesGList <- toGList cProperties
           success <- {# call controller_remove_properties_list #} (toController controller) cPropertiesGList
           {# call g_list_free #} cPropertiesGList
           return $ toBool success
