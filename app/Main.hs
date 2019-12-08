module Main where

import Parser
import Database
import HTTP
import System.Environment
import System.Exit
import System.IO
import Text.HTML.TagSoup

main :: IO ()
main = do  
   args <- getArgs
   let url = head args
   r <- downloadURL url
   let tweets = parse r
   putStrLn $ show tweets
