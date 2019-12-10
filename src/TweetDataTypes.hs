module TweetDataTypes where

type Content = String
type Author = String
type Likes = String
type Shares = String

data Tweet = Tweet Author Content Likes Shares
             deriving (Show)

data TypedTweet = TypedTweet
                  {
                     author :: String
                   , content :: String 
                   , likes :: Int
                   , shares :: Int
                  }
                  deriving (Show)
