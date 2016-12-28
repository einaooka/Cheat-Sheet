
## String
```python
help(str)
room = "poolhouse"
room.upper()
```

## List
```python
fruits = ['orange', 'apple', 'pear', 'banana', 'kiwi', 'apple', 'banana']
del fruits[0]

# List methods
fruits.count('apple')
fruits.index('banana')

# Modify the list
fruits.reverse()
fruits.append('grape')
fruits.sort()
fruits.pop() # removes and returns the item
```
## Matrix

```python
matrix = [ [1, 2, 3, 4]
         , [5, 6, 7, 8]
         , [9, 10, 11, 12] ]

```

## Basic Functions
```python
?function
print()

Type()
str(), int(), bool(), float() # switch data types

len()
max()
round()
sorted()
```

## packages
- math
- numpy

## _numpy_ package (Numeric Python)
- Numpy Array & appy operations
- multi-dimentional array
- arrays need to contain the same data type

```python
import numpy as np
x = [4 , 9 , 6, 3, 1]
y = np.array(x)
y[y > 5]

# 2d array
np_2d = [[180, 78.4],
            [215, 102.7],
            [210, 98.5],
            [188, 75.2]]
np_2d.shape # dim
np_2d[0,2], np_2d[0][2], np_2d[:, 1:3]  # subsetting

```



