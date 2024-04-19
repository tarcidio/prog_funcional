main :: IO ()

main = do
    input_1 <- getLine
    input_2 <- getLine
    let x :: Integer
        x = read input_1
    let y :: Integer
        y = read input_2
    let x_to_y_list :: [Integer]
        x_to_y_list = list x y
    let prime_list :: [Integer]
        prime_list = filter_ is_prime x_to_y_list
    let prime_list_processed :: [Integer]
        prime_list_processed = apply_between_items (-) prime_list 
    let selected_element :: Integer
        selected_element = select (>) prime_list_processed
    putStrLn (show selected_element)

list :: (Enum a) => a -> a -> [a]
list x y = [x..y]

filter_ :: (a->Bool) -> [a] -> [a]
filter_ f [] = []
filter_ f (h:t)
    | f h = (h:filter_ f t) 
    | otherwise = filter_ f t

is_prime :: Integer->Bool
is_prime x = is_prime_recursive x (div x 2)  

is_prime_recursive :: Integer -> Integer -> Bool
is_prime_recursive x 0 = False 
is_prime_recursive x 1 = True 
is_prime_recursive x y 
    | rem x y == 0 = False
    | otherwise = is_prime_recursive x (y-1)

apply_between_items :: (Num a) => (a-> a-> a) -> [a] -> [a]
apply_between_items f (h:[])  = []
apply_between_items f (h:t)  = (f (head t) h: apply_between_items f t)

select ::  (a->a->Bool) -> [a] -> a
select f (h:[]) = h
select f (h:t)  
    | f h (select f t) = h 
    | otherwise = select f t