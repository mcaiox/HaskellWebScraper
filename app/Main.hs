module Main where

import Parser
import ScraperDatabase
import HTTP
import System.Environment
import System.Exit
import System.IO
import Text.HTML.TagSoup

main :: IO ()
main = do  
   conn <- dbConnection
   args <- getArgs
   let url = head args
   r <- downloadURL url
   let tweets = parse r
   storeTweets conn tweets
   dbDisconnect conn
