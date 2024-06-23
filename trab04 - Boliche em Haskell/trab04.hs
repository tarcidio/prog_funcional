import Data.List (intercalate)

{- 
Tipo de dado Frame:
1. Strike: quando usa uma jogada para durrubar 10 pinos
2. Spare: quando usa duas jogadas para drrubar 10 pinos
3. Open: quando não derruba 10 pinos com duas jogadas
4. SingleStrike: derrubar 10 pinos no último frame
5. SingleThrow: derrubar pinos sem estar associado a um Spare ou Strike no último frame
-}
data Frame = Strike | Spare Int | Open Int Int | SingleStrike | SingleThrow Int deriving (Show)

-- Recebe vetor de inteiros e retorna vetor indicando a categoria de cada frame
toFrames :: [Int] -> [Frame]
toFrames pins = toFrame pins 1

-- Recebe vetor de inteiros e o número do frame em análise
-- Retorna a categoria daquele frame e dos posteriores
toFrame:: [Int] -> Int -> [Frame]
toFrame pins 10 = finalFrame pins  -- Trata todos os lançamentos restantes como parte do décimo frame
toFrame (10:xs) n = Strike : toFrame xs (n + 1)
toFrame (x:y:xs) n
    | x + y == 10 = Spare x : toFrame xs (n + 1)
    | otherwise   = Open x y : toFrame xs (n + 1)
      
-- Calcula o formato do último frame
finalFrame:: [Int] -> [Frame] 
finalFrame [x,y,z]
    | [x,y,z] == [10,10,10] = [SingleStrike, SingleStrike, SingleStrike]
    | [x,y,z] == [10,10, z] = [SingleStrike, SingleStrike, SingleThrow z]
    | x == 10 && y + z == 10 = [SingleStrike, Spare y]
    | [x,y,z] == [10, y,10] = [SingleStrike, SingleThrow y, SingleStrike]
    | [x,y,z] == [10, y, z] = [SingleStrike, SingleThrow y, SingleThrow z]
    | [x,y,z] == [x, y, 10] = [Spare x, SingleStrike]
    | [x,y,z] == [x, y, z] = [Spare x, SingleThrow z]
finalFrame [x,y] = [SingleThrow x, SingleThrow y]

-- Transforma um determinado tipo de frame em sua forma string
showFrame :: Frame -> String
showFrame Strike = "X _"
showFrame (Spare x) = show x ++ " /"
showFrame (Open x y) = show x ++ " " ++ show y
showFrame SingleStrike = "X"
showFrame (SingleThrow x) = show x

-- Dado um vetor de frames, retorna uma string indicando o jogo
printFrames :: [Frame] -> String
printFrames frame = printFrame 1 (map showFrame frame)

-- Dada o número do frame, retorna sua string correspondente e dos frames posteriores
printFrame:: Int -> [String] -> String
printFrame 10 [x] = x
printFrame 10 frame = intercalate " " frame
printFrame n (x:xs) = x ++ " | " ++ printFrame (n + 1) xs 

-- Calcula a pontuação de um jogo de boliche com base no vetor de pinos derrubados
score:: (Num a, Eq a) => [a] -> a -> a
score [] _ = 0
score (x:xs) 10 = x + score xs 10
score (10:xs) n = 10 + bonus xs 2 + score xs (n + 1)
score (x:y:xs) n
    | x + y == 10 = 10 + bonus xs 1 + score xs (n + 1)
    | otherwise = x + y + score xs (n + 1)

-- Calcula o bônus relativo àquela frame
bonus:: (Num a, Eq a) => [a] -> a -> a
bonus [] _ = 0
bonus (x:_) 1 = x
bonus (x:y:_) 2 = x + y

main :: IO ()
main = do
    -- Faz leitura do input
    input <- getLine
    let numbers = map read $ words input :: [Int]
    -- Transforma vetor de números da string de frames do jogo
    let framesString = printFrames $ toFrames numbers
    -- Calcula a pontuação do jogador
    let valueScore = show $ score numbers 1
    -- Formata resposta e imprime
    let answer = framesString ++ " | " ++ valueScore
    putStrLn answer
