--  -*-haskell-*-
--  GIMP Toolkit (GTK) Keys
--
--  Author : Jens Petersen
--  Created: 24 May 2002
--
--  Version $Revision: 1.4 $ from $Date: 2004/12/09 18:26:01 $
--
--  Copyright (c) 2002 Jens Petersen
--
--  This library is free software; you can redistribute it and/or
--  modify it under the terms of the GNU Library General Public
--  License as published by the Free Software Foundation; either
--  version 2 of the License, or (at your option) any later version.
--
--  This library is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
--  Library General Public License for more details.
--
-- |
--
-- Gdk keyval functions.
--
-- TODO
--
--  * Documentation
--
module Keys(
  keyvalName,
  keyvalFromName
  ) where


import FFI
import Foreign (unsafePerformIO)

{#context lib="libgdk" prefix ="gdk"#}

{#fun pure keyval_name as ^ {fromIntegral `Integer'} -> `Maybe String'
    maybePeekUTFString#}
  where
  maybePeekUTFString = unsafePerformIO . (maybePeek peekCString)
--   maybePeekUTFString = maybePeek peekCString

{#fun pure keyval_from_name as ^ {`String'} -> `Integer' fromIntegral#}

