{-# LANGUAGE BinaryLiterals, TemplateHaskell #-}

module PropSyscall where

import Syscall.Internal
import Syscall.Recieve

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

prop_syscall_recieve_none :: ValidSyscallDFAState -> Property
prop_syscall_recieve_none (ValidSyscallDFAState s) =
    (state s == SYSCALL_STATE_DONE) ==> syscallRecieveDFA s == s

prop_syscall_recieve_read :: ValidSyscallDFAState -> Property
prop_syscall_recieve_read (ValidSyscallDFAState s) =
    (state s == SYSCALL_STATE_READ && ecx s > 0) ==>
    let s' = syscallRecieveDFA s
     in (eax s) == (eax s') &&
        (ebx s) + 1 == (ebx s') && (ecx s) - 1 == (ecx s')

-- QUICKCHECK
return []

check :: IO Bool
check = $quickCheckAll
