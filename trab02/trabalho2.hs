main :: IO ()

main = do
    input_1 <- getLine
    input_2 <- getLine
    let x :: Integer
        x = read input_1
    let y :: Integer
        y = read input_2
    let prime_list :: [Integer]
        prime_list = filter is_prime [x..y]
    let prime_list_processed :: [Integer]
        prime_list_processed = apply_between_items (flip (-)) prime_list 
    let selected_element :: Integer
        selected_element = select (>) prime_list_processed 0
    putStrLn $ show selected_element

is_prime :: Integer->Bool
is_prime num = is_prime_recursive num $ num `div` 2

is_prime_recursive :: Integer -> Integer -> Bool
is_prime_recursive 1 _ = False 
is_prime_recursive _ 1 = True 
is_prime_recursive num divisor 
    | num `rem` divisor == 0 = False
    | otherwise = is_prime_recursive num $ divisor-1 

apply_between_items :: (Num a) => (a-> a-> a) -> [a] -> [a]
apply_between_items _ [] = []
apply_between_items _ (_:[]) = []
apply_between_items operation (item1:item2:other_items) = (operation item1 item2: apply_between_items operation (item2:other_items))

select :: (a->a->Bool) -> [a] -> a -> a 
select comparison [] base = base  
select comparison (item:[]) _ = item
select comparison (item:other_items) base  
    | comparison item recursion = item 
    | otherwise = recursion
    where
        recursion = select comparison other_items base
