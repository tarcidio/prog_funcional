main = do
    input <- getLine
    let numbers = map read $ words input :: [Int]
    let sizes = map len $ allSubsequences numbers
    putStrLn $ case bigger sizes of
        Nothing -> "There is no subsequent"
        Just x -> show x
        
subsequencie :: (Ord a) => [a] -> [a]
subsequencie [] = [] 
subsequencie [x] = [x] 
subsequencie (x:y:xs)
    | x >= y = [x]
    | otherwise = x:(subsequencie (y:xs))

allSubsequences:: (Ord a) => [a] -> [[a]]
allSubsequences [] = [[]]
allSubsequences (x:xs) = (subsequencie (x:xs)) : allSubsequences xs

reduce:: (a->b->b) -> b -> [a] -> b
reduce _ base [] = base
reduce op base (x:xs) = op x $ reduce op base xs

len:: (Num b) => [a] -> b
len array = reduce ((+).(const 1)) 0 array

bigger:: (Ord a) => [a] -> Maybe a
bigger [] = Nothing
bigger [x] = Just x
bigger (x:xs) = case bigger xs of
    Nothing -> Just x
    Just y -> if x > y then Just x else Just y
