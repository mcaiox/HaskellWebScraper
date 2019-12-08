{-
  This module defines the database interaction functions
-}

module ScraperDatabase where

import TweetDataTypes
import Database.HDBC
import Database.HDBC.Sqlite3
import Control.Monad
import Data.List

database :: String -> String
database a = a

-- |Method to create the database tweets.db
dbConnection :: IO Connection
dbConnection = do
   conn <- connectSqlite3 "tweets.db"
   run conn "CREATE TABLE IF NOT EXISTS tweets (contents TEXT, author TEXT, likes Int, shares Int)" []
   commit conn
   return conn

dbDisconnect :: Connection -> IO ()
dbDisconnect = disconnect

-- |Method to store a list of tweets into the database (table tweets)
storeTweets :: Connection 
          -> [TypedTweet] -- ^ List of URLs to be stored on the database
          -> IO ()
storeTweets _ [] = return ()
storeTweets conn xs = do
   stmt <- prepare conn "INSERT INTO tweets (contents, author, likes, shares) VALUES (?,?,?,?)"
   putStrLn "Adding:"
   mapM_ (\x -> putStrLn $ " - " ++ show x) xs
   executeMany stmt (map (\x -> [toSql (content x), toSql (author x), toSql (likes x), toSql (shares x)]) xs)
   commit conn
