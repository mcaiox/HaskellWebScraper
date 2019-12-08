{- This module defines the functions to make HTTP calls and extract data
    from a web page 
-}

module HTTP where

import Network.HTTP.Conduit
import Network.URI
import Data.Maybe
import Data.Either
import Control.Exception
import qualified Data.ByteString.Lazy as L
import Data.ByteString.Lazy.Char8


type URL = String

makeHttpRequest :: String -> String
makeHttpRequest a = a

downloadURL :: URL              -- String containing the URL to be downloaded
            -> IO String
downloadURL url =  do
       res <- simpleHttp url
       return $ unpack res

