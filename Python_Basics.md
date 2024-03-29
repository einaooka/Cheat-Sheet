## One-liner

List
```python
numbers = [1, 2, 3, 5, 7, 8, 9, 10]
even_square = [n*n for n in numbers if n%2 == 0]

# Don't do this
even_square = []
for num in numbers:
    if num%2 == 0:
        even_square.append(num*num)
```

dictionary 
```python
original = {'Key1':'Value1','Key2':'Value2','Key3':'Value3'}
flipped = {value: key for key, value in original.items()}

# Don't do this
flipped = {}
for key, value in original.items():
    flipped[value] = key
```
Lambda
```python
double = lambda x: x*2
print(double(4))

# Instead of 
def multiply_by_2(x):
    x*2
```


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

## Operators & Loops
```python
if conditon1 : 
    exp1
elif conditon2 : 
    exp2
else :
    exp3

while conditon :
    expression
    
for var in lst : 
    expression
    
for index, var in enumerate(seq) :
    print("Index" + str(index) + ": " + str(var))
    
for x in range(100):
    expression

```

## _numpy_ package (Numeric Python)
- Numpy Array & appy operations & Stats
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

# Stats
np.mean
np.median
np.corrcoef()
np.std()
np.sum()

np.sort()
np.round()

# random value generator
np.random.seed(123)
np.random.rand() # float
np.random.randint(0,6) # integer 0,1,...,5 
np.random.normal(1.75,0.20,5000)

# re-organize data
np.column_stack

# array booleans
np.logical_and(), np.logical_or, np.logical_not()

# for loop
for val in x : 
    print(val)
    
for val in np.nditer(np_2d) : 
    print(val)

```

## _matplotlib_ package (Visualization)
```python
import matplotlib.pyplot as plt

plt.plot(x,y)]
plt.scatter(x,y, s=size_array, c=col_array, alpha=0.8)
plt.hist(x, bins=10)

plt.xscale('log')
plt.xlabel('X'); plt.ylabel('Y'); plt.title('title')
plt.yticks([0,2,4,6], ['zero', 'two', 'four', six])

plt.text(x1,y1,"text")

plt.grid(True)

plt.show()
```

## Dictionary - Key-Value
```python
my_dict = {
   "key1": 0.05,
   "key2": 2,
}
print(my_dict.keys())
my_dict['Key3'] = 0.03

'Key3' in my_dict
del(my_dict['key3])

for key, value in my_dict.items() :
    print(key + " : " + str(value))

```

## pandas - DataFrame
```python
import pandas as pd

# difine directly
df = pd.DataFrame({
                  "var1": ["a", "b", "C"], 
                  "val2": [3,6,10]})
df.index = ['r1', 'r2', 'r3']

# csv
pd.read_csv("path/temp.csv", index_col=0)

# Subsetting
df['var1'] # returns panda series (1d array)
df[['var1', 'var2']] # sub-dataframe as dataframe
df[0:3] # row access

df.loc[["r2"]]
df.loc[["r1", "r2],["var1", "var3"]]
df.loc[:,["var1", "var3"]]
df.iloc[[0:2],[0,3]]

# Filtering - on panda series, not data frame
df = df[np.logical_and(df['val2'] > 5, df['val2'] < 10)]

# For loop 
for lab, row in df.iterrows() :
    print(lab + " : " + row["var1"])
# lab is the row label. row is the row data. 

# Apply function (e.g. length function)
df["newcol"] = df["var1"].apply(len)
```

```python
# Swap (or Map)
import pandas as pd
s = pd.Series(['Math', 'Science', 'Computer'])
s = s.map({'Math': 'Algebra', 'Science':'Physics', 'Computer': 'Python'})

# Filter
s = pd.Series([1, 2, 3, 4, 5])
result = pd.Series(filter(lambda x: x > 3, s))
```


