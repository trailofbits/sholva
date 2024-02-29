module IntraBucket where

import Clash.Annotations.TH
import Clash.Prelude

import MemoryBucket
import MemoryHint

-- if the public hint's address does not match the bucket's label, return TRUE.
-- if the public hint's address falls outside of the .text section, return FALSE.
-- otherwise, validate:
intraBucket :: MemoryBucket -> MemoryHint -> Bool
intraBucket bucket hint =
    if (MemoryBucket.address bucket /= MemoryHint.address hint)
        then True
        else memoryInitialization bucket && association bucket

-- verify that the first entry in bucket is a write, either at T=0,
-- or as an instruction side effect (i.e. if the byte is written before it is read during an execution.)
memoryInitialization :: MemoryBucket -> Bool
memoryInitialization bucket =
    MemoryHint.timestamp (MemoryBucket.hints bucket !! 0) == 0

-- verify that every read has an associated write: a value read must be the most recently
-- written, and a read and write cannot happen at the same time.
association :: MemoryBucket -> Bool
association bucket =
    foldr
        (\hint acc -> hasAssoc bucket hint && acc)
        True
        (MemoryBucket.hints bucket)
  where
    hasAssoc :: MemoryBucket -> MemoryHint -> Bool
    hasAssoc bucket write =
        foldr
            (\hint acc ->
                 ((MemoryHint.val hint) == (MemoryHint.val write) &&
                  (MemoryHint.operation hint) == OpWrite) &&
                 (MemoryHint.timestamp write) < (MemoryHint.timestamp hint) ||
                 acc)
            False
            (MemoryBucket.hints bucket)

top :: ( "bucket" ::: Signal System MemoryBucket
       , "hint" ::: Signal System MemoryHint)
    -> ("valid" ::: Signal System Bool)
top (bucket, hint) = intraBucket <$> bucket <*> hint

makeTopEntityWithName 'top "intra_bucket"
