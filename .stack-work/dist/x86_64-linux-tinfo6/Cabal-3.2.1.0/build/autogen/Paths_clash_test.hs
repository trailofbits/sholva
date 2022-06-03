{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_clash_test (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/jleightcap/r/sholva/.stack-work/install/x86_64-linux-tinfo6/d06672c3412c5175a6b6b5f541fcab9d49252037343ec7c47701986cd1f05a57/8.10.7/bin"
libdir     = "/home/jleightcap/r/sholva/.stack-work/install/x86_64-linux-tinfo6/d06672c3412c5175a6b6b5f541fcab9d49252037343ec7c47701986cd1f05a57/8.10.7/lib/x86_64-linux-ghc-8.10.7/clash-test-0.1-7w6XOugz4iM8hzHP6MR1E2"
dynlibdir  = "/home/jleightcap/r/sholva/.stack-work/install/x86_64-linux-tinfo6/d06672c3412c5175a6b6b5f541fcab9d49252037343ec7c47701986cd1f05a57/8.10.7/lib/x86_64-linux-ghc-8.10.7"
datadir    = "/home/jleightcap/r/sholva/.stack-work/install/x86_64-linux-tinfo6/d06672c3412c5175a6b6b5f541fcab9d49252037343ec7c47701986cd1f05a57/8.10.7/share/x86_64-linux-ghc-8.10.7/clash-test-0.1"
libexecdir = "/home/jleightcap/r/sholva/.stack-work/install/x86_64-linux-tinfo6/d06672c3412c5175a6b6b5f541fcab9d49252037343ec7c47701986cd1f05a57/8.10.7/libexec/x86_64-linux-ghc-8.10.7/clash-test-0.1"
sysconfdir = "/home/jleightcap/r/sholva/.stack-work/install/x86_64-linux-tinfo6/d06672c3412c5175a6b6b5f541fcab9d49252037343ec7c47701986cd1f05a57/8.10.7/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "clash_test_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "clash_test_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "clash_test_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "clash_test_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "clash_test_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "clash_test_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
