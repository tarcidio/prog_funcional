def head(v): 
    return v[0]

def tail(v):
    return v[1:]

def list_(start, end):
    return list(range(start, end+1))

def filter_(v, cond):
    if len(v) < 1:
        return []
    
    tail_filtered = filter_(tail(v),cond)
    if cond(v): 
        return [head(v)] + tail_filtered
    else:
        return tail_filtered

def is_prime(n):
    return is_prime_recursive(n,n//2)

def is_prime_recursive(n,d):
    if d == 1:
        return True
    else:
        if n == 1 or n%d == 0:
            return False
        else:
            return is_prime_recursive(n,d-1)

def process_adjacent_elements(v, process):
    if len(v) <= 1:
        return []
    else:
        return [process(head(v),head(tail(v)))] + process_adjacent_elements(tail(v),process)

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
