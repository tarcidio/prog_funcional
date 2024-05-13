main :: IO ()
main = do
    input <- getLine
    let numbers = map read $ words input :: [Int]
    print $ maxLengthIncreasingSubsequence numbers

maxLengthIncreasingSubsequence :: [Int] -> Int
maxLengthIncreasingSubsequence [] = 0
maxLengthIncreasingSubsequence (x:xs) = maxLength xs x 1 1
  where
    maxLength [] _ currentMax globalMax = max currentMax globalMax
    maxLength (y:ys) lastElement currentLength globalMax
        | y > lastElement = maxLength ys y (currentLength + 1) globalMax
        | otherwise = maxLength ys y 1 (max currentLength globalMax)
