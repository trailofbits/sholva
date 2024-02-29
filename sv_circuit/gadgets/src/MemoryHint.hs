-- represents an atomic memory operation for memory proof constructions.
-- diverges slightly from contents of a MemoryHint defined in mttn.
module MemoryHint
    ( MemoryOp(..)
    , MemoryMask(..)
    , MemoryHint(..)
    ) where

import Clash.Prelude

type TimeStamp = BitVector 16

data MemoryOp
    = OpRead
    | OpWrite
    deriving (Eq)

data MemoryMask
    = Byte
    | Word
    | DWord
    | QWord
    deriving (Eq)

data MemoryHint = MkMemoryHint
    { address :: BitVector 64
    , operation :: MemoryOp
    , mask :: MemoryMask
    , val :: Vec 8 (BitVector 8) -- 8-byte buffer with mask field
    , timestamp :: TimeStamp
    } deriving (Eq)
