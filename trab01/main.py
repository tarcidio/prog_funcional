# Função auxiliar para descobrir se x é primo
def isPrimeRecursion(x,y):
    if y == 1:
        return True
    elif x % y == 0:
        return False
    else:
        return isPrimeRecursion(x, y - 1)

# Verifica se x é primo
def isPrime(x):
   return isPrimeRecursion(x, x - 1)
 
# Encontra o próximo primo de x (incluindo x)
def findNextPrime(x):
    if isPrime(x):
        return x
    else:
        return findNextPrime(x + 1)

# Encontra o maior dentre os intervalos entre dois primos consecultivos 
# que sejam maiores ou igual a lastValue e menor ou igual a limit
def findMaxSizeRange(lastValue, limit):
    secondValue = findNextPrime(lastValue + 1)
    
    if secondValue > limit:
        return 0
    else:
        curSizeRange = secondValue - lastValue
        newSizeRange = findMaxSizeRange(secondValue, limit)
        return curSizeRange if curSizeRange > newSizeRange else newSizeRange

# Função que resolve o problema do Trabalho 01
def solve(x: int, y: int):
    firstPrime = findNextPrime(x)
    if firstPrime >= y:
        return 0
    return findMaxSizeRange(firstPrime, y)

x = int(input())
y = int(input())
print(solve(x,y))
# print(solve(5,15))#4
# print(solve(20,30))#6
# print(solve(11,15))#2
    
 
 
 
 
 
 
 
 
 
 
 
 
 
