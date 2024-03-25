def head(v): 
    return v[0]

def tail(v):
    return v[1:]

# Define uma lista que começa de start,start+1,...,end 
# Sendo start < end 
def list_(start, end):
    return list(range(start, end+1))

# Filtra um vetor, baseado em uma função de condição que recebe o vetor como parametro
def filter_(v, cond):
    if len(v) < 1:
        return []
    
    tail_filtered = filter_(tail(v),cond)
    if cond(v): 
        return [head(v)] + tail_filtered
    else:
        return tail_filtered

# Verifica se um numero é primo
def is_prime(n):
    return is_prime_recursive(n,n//2)

# Realiza as recursões para checar se um número é primo
def is_prime_recursive(n,d):
    if d == 1:
        return True
    else:
        if n == 1 or n%d == 0:
            return False
        else:
            return is_prime_recursive(n,d-1)

# Realiza uma operação entre os valores adjacentes de uma lista e retorna a lista dessas operações
def process_adjacent_elements(v, process):
    if len(v) <= 1:
        return []
    else:
        return [process(head(v),head(tail(v)))] + process_adjacent_elements(tail(v),process)

# Seleciona um elemento da lista por meio de uma função de comparação 
def select_element(v, compare):
    if len(v) == 0:
        return 0
    else:
        tail_result = select_element(tail(v),compare)
        if compare(head(v), tail_result):
            return head(v)
        else:
            return tail_result

if __name__ == "__main__":
    x = int(input())
    y = int(input())

    max_diff = select_element( 
        process_adjacent_elements(
            filter_(
                list_(x,y),
                lambda v: is_prime(head(v))
            ), 
            lambda x,y: y -x)
        , 
        lambda x,y: x > y
    )

    print(max_diff)
