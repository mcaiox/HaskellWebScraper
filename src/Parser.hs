{-
  This module defines the parser to extract required contents
-}

module Parser where

import System.Environment
import System.Exit
import System.IO
import Text.HTML.TagSoup
import Data.Char

type Content = String
type Author = String
type Likes = String
type Shares = String

data Tweet = Tweet Likes Author Content Shares
             deriving (Show)

data TypedTweet = TypedTweet String String Int Int
                  deriving (Show)

parse :: String -> [TypedTweet]
parse a = createTypedTweets cleanedTweets
   where
    cleanedTweets = clean res
    tags = parseTags a
    tweetContainers = takeWhile (~/= TagClose "body") . dropWhile (~/= TagOpen "div" [("class", "tweetcontainer")]) $ tags
    res = convertToTweets tweetContainers

createTypedTweets [] = []
createTypedTweets (Tweet l a c s:ts) = TypedTweet a c (read l) (read s) : createTypedTweets ts

clean :: [Tweet] -> [Tweet]
clean xs = filter checkTweet xs

checkTweet :: Tweet -> Bool
checkTweet (Tweet likes author content shares)
 | shares == "" || likes == "" = False
 | content == "" = False
 | author == "" = False
 | otherwise = True

convertToTweets [] = []
convertToTweets xs = tweet : convertToTweets remTweets
  where
  (tweet, remTweets) = getTweet xs

getTweet xs = (makeTwt singleTweet, remTweets)
  where
   singleTweet = takeWhile (~/= TagClose "div") xs
   remTweets = drop 3 . dropWhile (~/= TagClose "div") $ xs
  
makeTwt singleTweet = Tweet likes author content shares
  where
   author = innerText . take 2 . dropWhile (~/= TagOpen "h2" [("class", "author")]) $ singleTweet
   content = innerText . take 2 . dropWhile (~/= TagOpen "p" [("class", "content")]) $ singleTweet
   likes = filter (not . isSpace) . filter (not . isAlpha) . innerText . take 2 . dropWhile (~/= TagOpen "p" [("class", "likes")]) $ singleTweet
   shares = filter (not . isSpace) . filter (not . isAlpha) . innerText . take 2 . dropWhile (~/= TagOpen "p" [("class", "shares")]) $ singleTweet

