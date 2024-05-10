import Data.List

main :: IO ()
main = do
    input_1 <- getLine
    let l :: [Int]
        l = map read $ words input_1
    putStrLn $ 
        show $
        maximum $
        (++) [0] $
        map length $
        group_elements (operation_on_first_two_elements (<)) l
        
group_elements :: ([a]->Bool) -> [a] -> [[a]]
group_elements _ [] = []
group_elements _ [a] = [[a]]
group_elements op (x:xs)
    | op (x:y) = (([x] ++ y) : ys)
    | otherwise = ([x] : y : ys)
    where
        (y:ys) = group_elements op xs

operation_on_first_two_elements :: (a->a->Bool) -> [a] -> Bool
operation_on_first_two_elements pair_operation (x:y:tail) = pair_operation x y 

