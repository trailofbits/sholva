{-# LANGUAGE BinaryLiterals, TemplateHaskell #-}

module PropSyscall where

import Syscall.Internal
import Syscall.Receive
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
    ecx' <- arbitrary
    edx' <- arbitrary
    (ValidSyscallState state') <- arbitrary
    return $ ValidSyscallDFAState $ MkDFAState eax' ecx' edx' state'

prop_syscall_receive_none :: ValidSyscallDFAState -> Property
prop_syscall_receive_none (ValidSyscallDFAState s) =
  (state s == SYSCALL_STATE_DONE) ==> syscallReceiveDFA s == s

prop_syscall_receive_read :: ValidSyscallDFAState -> Property
prop_syscall_receive_read (ValidSyscallDFAState s) =
  (state s == SYSCALL_STATE_WRITE && ecx s > toEnum stepDataBytes)
  -- WRITE state with bytes remaining to recieve
   ==>
  let s' = syscallReceiveDFA s -- computed next state
   in (eax s == eax s') -- %eax unchanged
       &&
      (ebx s + toEnum stepPtrBytes  == ebx s') -- pointer incremented
      &&
      (ecx s - toEnum stepDataBytes == ecx s') -- data count decremeneted

-- QUICKCHECK
return []

check :: IO Bool
check = $quickCheckAll
