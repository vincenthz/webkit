-- -*-haskell-*-
--  GIMP Toolkit (GTK) @entry Widget Scale@
--
--  Author : Axel Simon
--          
--  Created: 23 May 2001
--
--  Version $Revision: 1.2 $ from $Date: 2002/05/24 09:43:24 $
--
--  Copyright (c) 1999..2002 Axel Simon
--
--  This file is free software; you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation; either version 2 of the License, or
--  (at your option) any later version.
--
--  This file is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
-- @description@ --------------------------------------------------------------
--
-- * This is the abstract base class for HScale and VScale. It implements the
--   management of an adjustable value.
--
-- @documentation@ ------------------------------------------------------------
--
--
-- @todo@ ---------------------------------------------------------------------

module Scale(
  Scale,
  ScaleClass,
  castToScale,
  scaleSetDigits,
  scaleSetDrawValue,
  PositionType(..),
  scaleSetValuePos
  ) where

import Monad	(liftM)
import Foreign
import UTFCForeign
import Object	(makeNewObject)
{#import Hierarchy#}
{#import Signal#}
import Enums	(PositionType(..))

{# context lib="gtk" prefix="gtk" #}

-- methods

-- @method scaleSetDigits@ Set the number of displayed digits after the comma.
--
scaleSetDigits :: ScaleClass s => s -> Int -> IO ()
scaleSetDigits s prec = 
  {#call scale_set_digits#} (toScale s) (fromIntegral prec)

-- @method scaleSetDrawValue@ Specify if the current value is to be drawn next
-- to the slider.
--
scaleSetDrawValue :: ScaleClass s => s -> Bool -> IO ()
scaleSetDrawValue s draw =
  {#call scale_set_draw_value#} (toScale s) (fromBool draw)

-- @method scaleSetValuePos@ Specify where the value is to be displayed
-- (relative to the slider).
--
scaleSetValuePos :: ScaleClass s => s -> PositionType -> IO ()
scaleSetValuePos s pos =
  {#call scale_set_value_pos#} (toScale s) ((fromIntegral.fromEnum) pos)


