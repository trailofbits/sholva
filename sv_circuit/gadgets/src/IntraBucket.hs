module IntraBucket where

import Clash.Annotations.TH
import Clash.Prelude

top :: ("a" ::: Signal System Bit) -> ("b" ::: Signal System Bit)
top = id

makeTopEntityWithName 'top "intra_bucket"
