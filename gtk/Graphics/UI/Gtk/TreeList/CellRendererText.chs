-- -*-haskell-*-
--  GIMP Toolkit (GTK) CellRendererText TreeView
--
--  Author : Axel Simon
--
--  Created: 23 May 2001
--
--  Version $Revision: 1.8 $ from $Date: 2005/11/18 15:54:57 $
--
--  Copyright (C) 1999-2006 Axel Simon
--
--  This library is free software; you can redistribute it and/or
--  modify it under the terms of the GNU Lesser General Public
--  License as published by the Free Software Foundation; either
--  version 2.1 of the License, or (at your option) any later version.
--
--  This library is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
--  Lesser General Public License for more details.
--
-- |
-- Maintainer  : gtk2hs-users@lists.sourceforge.net
-- Stability   : provisional
-- Portability : portable (depends on GHC)
--
-- A 'CellRenderer' which displays a single-line text.
--
module Graphics.UI.Gtk.TreeList.CellRendererText (
-- * Detail
-- 
-- | This widget derives from 'CellRenderer'. It provides the 
-- possibility to display some text by setting the 'Attribute' 
-- 'cellText' to the column of a 'TreeModel' by means of 
-- 'Graphics.UI.Gtk.TreeList.TreeView.treeViewAddAttribute' from
-- 'TreeViewColumn'.

-- * Class Hierarchy
-- |
-- @
-- |  'GObject'
-- |   +----'Object'
-- |         +----'CellRenderer'
-- |               +----CellRendererText
-- |                     +----'CellRendererCombo'
-- @

-- * Types
  CellRendererText,
  CellRendererTextClass,
  castToCellRendererText,
  toCellRendererText,

-- * Constructors
  cellRendererTextNew,

-- * Attributes
  cellText,
  cellMarkup,

-- * Signals
  onEdited,
  afterEdited
  ) where

import Maybe	(fromMaybe)
import Monad	(liftM)

import System.Glib.FFI
import System.Glib.Properties
import System.Glib.Attributes ( Attr, WriteAttr, ReadAttr )
import Graphics.UI.Gtk.Abstract.Object		(makeNewObject)
{#import Graphics.UI.Gtk.Types#}
{#import Graphics.UI.Gtk.Signals#}
{#import Graphics.UI.Gtk.TreeList.TreeIter#}
import Graphics.UI.Gtk.General.Structs		(treeIterSize)

{# context lib="gtk" prefix="gtk" #}

--------------------
-- Constructors

-- | Create a new CellRendererText object.
--
cellRendererTextNew :: IO CellRendererText
cellRendererTextNew =
  makeNewObject mkCellRendererText $
  liftM (castPtr :: Ptr CellRenderer -> Ptr CellRendererText) $
  {# call unsafe cell_renderer_text_new #}

--------------------
-- Properties

-- | Define the attribute that specifies the text to be rendered.
--
cellText :: CellRendererTextClass cr => Attr cr (Maybe String)
cellText  = newAttrFromMaybeStringProperty "text"

-- | Define a markup string instead of a text.
--
cellMarkup :: CellRendererTextClass cr => WriteAttr cr (Maybe String)
cellMarkup  = writeAttrFromMaybeStringProperty "markup"

-- | Emitted when the user finished editing a cell.
--
-- * This signal is not emitted when editing is disabled (see 
--   'cellEditable') or when the user aborts editing.
--
onEdited, afterEdited :: TreeModelClass tm => CellRendererText -> tm ->
			 (TreeIter -> String -> IO ()) ->
			 IO (ConnectId CellRendererText)
onEdited = internalEdited False
afterEdited = internalEdited True

internalEdited :: TreeModelClass tm => Bool -> 
                  CellRendererText -> tm ->
                  (TreeIter -> String -> IO ()) ->
                  IO (ConnectId CellRendererText)
internalEdited after cr tm user =
  connect_PTR_STRING__NONE "edited" after cr $ \strPtr string ->
  (receiveTreeIter $ \iterPtr ->
  {# call gtk_tree_model_get_iter_from_string #}
    (toTreeModel tm)
    iterPtr
    strPtr)
  >>= \res ->
  case res of
    Nothing -> fail "edited signal: invalid tree path"
    Just iter -> user iter string

