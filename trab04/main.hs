import Data.List (intercalate)

data Frame = Strike | Spare Int | Open Int Int | TripleFrame Frame Frame Frame | DoubleFrame Frame Frame | SingleThrow Int deriving (Show)

toFrames :: [Int] -> [Frame]
toFrames pins = toFrame pins 1

toFrame:: [Int] -> Int -> [Frame]
toFrame pins 10 = finalFrame pins  -- Trata todos os lançamentos restantes como parte do décimo frame
toFrame (10:xs) n = Strike : toFrame xs (n + 1)
toFrame (x:y:xs) n
    | x + y == 10 = Spare x : toFrame xs (n + 1)
    | otherwise   = Open x y : toFrame xs (n + 1)
      
-- Converte o último Frame em algo entendivel pelo algoritmo
finalFrame:: [Int] -> [Frame] 
finalFrame [x, y, z] -- Se vem 3, é porque houve spare ou strike
    | x == 10 = Strike : finalFrame [y, z]  -- Strike seguido por mais lançamentos
    | otherwise = Spare x : [SingleThrow z]   -- Spare seguido por um lançamento
finalFrame [x, y]
    | x == 10 = Strike : finalFrame [y]
    | x + y == 10 = [Spare x]  -- Spare seguido por um lançamento
    | otherwise = [Open x y]              -- Dois lançamentos abertos
finalFrame [x]
    | x == 10 = [Strike]
    | otherwise = [SingleThrow x]

showFrame :: Frame -> String
showFrame Strike = "X _"
showFrame (Spare x) = show x ++ " /"
showFrame (Open x y) = show x ++ " " ++ show y
showFrame (SingleThrow x) = show x

printFrames :: [Frame] -> String
printFrames frame = printFrame 1 (map showFrame frame)

printFrame:: Int -> [String] -> String
printFrame 10 [x] = x
printFrame 10 frame = intercalate " " frame
printFrame n (x:xs) = x ++ " | " ++ printFrame (n + 1) xs 

main :: IO ()
main = do
    -- input <- getLine
    -- let numbers = map read $ words input :: [Int]
    putStrLn $ show $ printFrames $ toFrames [1,4,4,5,6,4,5,5,10,0,1,7,3,6,4,10,2,8,6]
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
