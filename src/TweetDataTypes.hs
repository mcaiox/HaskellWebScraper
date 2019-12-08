module TweetDataTypes where

type Content = String
type Author = String
type Likes = String
type Shares = String

data Tweet = Tweet Likes Author Content Shares
             deriving (Show)

data TypedTweet = TypedTweet
                  {
                     content :: String
                   , author :: String
                   , likes :: Int
                   , shares :: Int
                  } 
                  deriving (Show)
