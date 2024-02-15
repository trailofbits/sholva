{-# LANGUAGE BinaryLiterals, TemplateHaskell #-}

module PropSyscall where

import Syscall.Internal
import Syscall.Read
import Prelude

import Test.QuickCheck

newtype ValidSyscallState =
  ValidSyscallState SyscallState
  deriving (Eq, Show)

instance Arbitrary ValidSyscallState where
  arbitrary = ValidSyscallState <$> elements [minBound .. maxBound]

newtype ValidSyscallDFAState =
  ValidSyscallDFAState SyscallDFAState
  deriving (Eq, Show)

instance Arbitrary ValidSyscallDFAState where
  arbitrary = do
    eax' <- arbitrary
    ebx' <- arbitrary
    ecx' <- arbitrary
    edx' <- arbitrary
    (ValidSyscallState state') <- arbitrary
    return $ ValidSyscallDFAState $ MkDFAState eax' ebx' ecx' edx' state'

prop_syscall_read_none :: ValidSyscallDFAState -> Property
prop_syscall_read_none (ValidSyscallDFAState s) =
  (state s == SYSCALL_STATE_DONE) ==> syscallReadDFA s == s

prop_syscall_read_read :: ValidSyscallDFAState -> Property
prop_syscall_read_read (ValidSyscallDFAState s) =
  (state s == SYSCALL_STATE_WRITE && ecx s > toEnum stepDataBytes)
  -- WRITE state with bytes remaining to recieve
   ==>
  let s' = syscallReadDFA s -- computed next state
   in (eax s == eax s') -- %eax unchanged
       &&
      (ebx s + toEnum stepPtrBytes  == ebx s') -- pointer incremented
      &&
      (ecx s - toEnum stepDataBytes == ecx s') -- data count decremeneted

-- QUICKCHECK
return []

check :: IO Bool
check = $quickCheckAll
