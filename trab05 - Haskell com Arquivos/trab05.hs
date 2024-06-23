import System.IO
import Control.Exception
import Control.DeepSeq
import Data.List
import Data.Ord

data CountryInfo = CountryInfo {name :: String, confirmed :: Integer, death :: Integer, recovery :: Integer, active :: Integer } deriving (Show, Read)

main = do
    h <- openFile "dados.csv" ReadMode
    c <- hGetContents h
    evaluate $ force c
    hClose h
    let parsedData :: [CountryInfo]
        parsedData = map (toCountryInfo.parseCSVLine) $ lines c
    input <- getLine
    let n :: [Integer]
        n = map read $ words input
        n1 = (n!!0)
        n2 = (n!!1)
        n3 = (n!!2)
        n4 = (n!!3)
    putStrLn $ 
        show $ 
        sum.(map active) $ 
        filter ((>n1).confirmed) parsedData
    putStrLn $ 
        show $
        sum.(map death) $
        take (fromInteger n3) $
        sortBy (comparing confirmed) $
        take (fromInteger n2) $ 
        reverse $ 
        sortBy (comparing active) $
        parsedData
    putStrLn $ 
        intercalate "\n" $ 
        sortBy (compare) $
        take (fromInteger n4) $
        map name $
        reverse $ 
        sortBy (comparing confirmed) $
        parsedData

    

parseCSVLine :: String -> (String, Integer, Integer, Integer, Integer )
parseCSVLine line = (x1, read x2, read x3, read x4, read x5)
    where   
        (x1:x2:x3:x4:x5:_) = parseCSVLineHelper line

parseCSVLineHelper :: String -> [String]
parseCSVLineHelper "" = []
parseCSVLineHelper x = (fst t) : (parseCSVLineHelper $ tail $ snd t)
    where 
        t = span (/=',') x

toCountryInfo :: (String, Integer, Integer, Integer, Integer ) -> CountryInfo
toCountryInfo (name, confirmed, death, recovery, active) = CountryInfo {name=name, confirmed=confirmed, death=death, recovery=recovery, active=active}