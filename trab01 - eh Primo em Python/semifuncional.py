# Função recursiva auxiliar para descobrir se x é primo
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
 
# Encontra o próximo primo partindo de x (incluindo x)
def findNextPrime(x):
    if isPrime(x):
        return x
    else:
        return findNextPrime(x + 1)

# Encontra o maior dentre os intervalos definidos pelos primos consecultivos 
# que sejam maiores ou igual a lastPrime e menor ou igual a limit
# Pré-condições: 
    # lastPrime sempre será primo
    # limit sempre será maior que lastPrime
def findMaxSizeRange(lastPrime: int, limit: int):
    # Encontra o próximo primo maior que lastPrime
    nextPrime = findNextPrime(lastPrime + 1)
    # Se o próximo primo for maior que o limite, desconsideramos este intervalo
    if nextPrime > limit:
        return 0
    else:
        # Após calcular o tamanho do intervalo em análise 
        # e do próximo partindo de nextPrime, retorna o maior
        curSizeRange = nextPrime - lastPrime
        nextSizeRange = findMaxSizeRange(nextPrime, limit)
        return curSizeRange if curSizeRange > nextSizeRange else nextSizeRange

# Função que resolve o problema do Trabalho 01
def solve(x: int, y: int):
    # Encontra o primeiro primo maior ou igual a x
    firstPrime = findNextPrime(x)
    # Se existir no máximo um primo no intervalo [x,y], a resposta é zero
    if firstPrime >= y:
        return 0
    # Se não, procura o maior tamanho no internalo [firstPrime,y]
    else:
        return findMaxSizeRange(firstPrime, y)

# Leitura da entrada e impressão da resposta
x = int(input())
y = int(input())
print(solve(x,y))
