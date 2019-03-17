# python_lab2.txt
def bubbleSort(List):
    """
    Given an unsorted list, sorts it through bubble sort 
    """

    N = len(List)
    for i in range(N-1,0,-1):
        for j in range(i):
            if (List[j+1]<List[j]):
                List[j],List[j+1] = List[j+1],List[j]
    return(List)
    
    
List = L
N = len(List)
for i in range(N-1,0,-1):
    for j in range(i):
        if (List[j+1]<List[j]):
            List[j],List[j+1] = List[j+1],List[j]
        print(List)
        
        
        
def insertionSort(List):
    """
    Given an unsorted list, sorts it through insertion sort 
    """
    N = len(List)
    for i in range(1, N):
        ind = List[i]
        j = i - 1
        while (j >= 0) and (ind < List[j]):
            List[j+1] = List[j]
            j -=1
        List[j+1] = ind
    return(List)
        