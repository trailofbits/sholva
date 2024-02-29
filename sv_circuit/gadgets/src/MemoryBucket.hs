module MemoryBucket
    ( MemoryBucket(..)
    ) where

import Clash.Prelude
import MemoryHint

data MemoryBucket = MkMemoryBucket
    { address :: BitVector 64
    , hints :: Vec 10 MemoryHint -- NOTE: precondition of being sorted by timestamp.
    } deriving (Eq)
