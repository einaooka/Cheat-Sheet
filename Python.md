

# Basics
- [python-operators-and-booleans/](https://writeblocked.org/resources/python_cheat_sheet.pdf)
- [string manipulation](https://github.com/wilfredinni/python-cheatsheet/blob/master/docs/cheatsheet/manipulating-strings.md)

```python

# Comprehension
[expr for value in collections if condition] # list
[expression for item1 in iterable1 for item2 in iterable2 ... if condition] # nested list
{key-expr: value-expr for value in collection if condition} # dictionary
{expre for value in collection if condition} # set 

any([False, False, True])

# if-else
if x <0:
  do_this
elif x == 0:
  do_that
else:
  do_such

y = math.log(x) if x > 0 else np.nan

# for loop
for i in range(len(x)):
  do_this
  continue # skip to the next loop
  break # exit the for loop
```

# Datetime
```python
import datetime
import pytz

dt = datetime(2024, 7, 17, 0, 0, 0)
dt.day     # return integer
dt.minute
dt.date() # return object
dt.time()
dt.strftime("%Y-%m-%d %H:%M") # return string

# timezone
tz = pytz.timezone('Asia/Kolkata')
obj = tz.localize(dt)
new_tz = pytz.timezone('America/New_York')
obj.astimezone(new_tz)

# list of time zones
pytz.common_timezones
# UTC
# US/Pacific
# US/Eastern

# read in datetime
datetime.strptime("20091031", "%Y%m%d")

# add 90 days
obj + datetime.timedelta(days=90, hours=1)

```
- [Python strftime cheatsheet](https://strftime.org/)

# Data Types

```python
# tuple - immutable
nested_tup = (4, 8, None), ('foo', 8)
nested_tup + (0, 5)
a,b, *_ = nested_tup

for key, value in zip(key_lst, value_lst)
  do_this(key, value)

for index, value in enumerate(values)
  do_something(value)

# list - mutable
lst.append(obj) # add one obj
lst.axtend(objs) # add multiple obj
lst.pop(idx) # removes and returns obj at the index
lst.remove(obj) # remove the first of the matching item
lst.sort()

lst[-4:] # index relative from the end
lst[::2] # every other element
lst[::-1] # reverse 

# dictionary
dct = {"a": "some value", "b": [1, 2, 3, 4]}
dict.get(key, default_value) # default None
list(dct.keys())
list(dct.values())

# sets
st1 = set([2,2,2,1,3,3]) # stores unique elements
st1.union(st2); st1 | st2
st1.intersection(st2); st1 & st2
st1.difference(st2) # elements in st1 that are not in st2
st1.issubset(st2)

```

# NumPy
```python
Import numpy as np

# Generate arrays
ar2 = np.array([[1,2,3], [4,5,6]])
np.zeros((3,6)) # matrix of dim = (3,6) with entries zero
np.arange(32).reshape((8,4))
ar2.dtype
ar2.shape

# slicing
ar[0][2]
ar[0,2]
ar2[:2, :1]
ar2[[2],:] # Return 2d array without dropping dim 

slice = ar[5:8] # reference to the original ary
newslice = ar[5:8].copy # create a new object

# matrix operation
arr.T
np.dot(arr.T, arr)

arr.sum()
arr.mean()
arr.mean(axis =0)
arr.cumsum()

bool.any()
bool.all()

# np set operations
np.unique(arr) # faster than using sets
np.in1d(arr1, arr2)
intersect1d(x,y)
union1d(x,y)
setdiff1d(x,y)


# random numbers
np.ramdom.standard_normal(size = (4,4))
np.random.uniform()
np.random.choice(data, size=10, replace=True)

# conditional logic
np.where(cond, xarr, yarr) # xarr and yarr can be scalr or an array
np.where(arr > 0, 2, arr) # set only positive values to 2
```

# Plot
```python
import matplotlib.pyplot as plot

plot.colorbar()
plt.title()

plt.close("all")
```

# Aggregation

# vectorized operation
```python
apply_to_list(ints, lambda x: x*2)
map()

```

# Error Handling
```python
try:
  do_this
exceptValueError:
  do_that
finally:
  close_it
```
[List of exceptions](https://www.w3schools.com/python/python_ref_exceptions.asp)

# Underscore 

```python
5+3
_  # last executed expression

a, _, c = (1, 2, 3) # ignore values in assignment

_var # private variable or method
var_ # avoid confilict with a keyword
__var # avoid conflict with subclasses
__var__ # reserved for special use
```

# Shortcut keys
- Insert a new line directly below, regardless of where you are in the current line: ^ + ⏎
- Duplicate your current row up or down: ⎇ + ⇧ + ↑/↓
- Move the current row up or down: ⎇ + ↑/↓
- Select everything within the current bracket (hit twice): ⎇ + ⇧ + →
- Comment out the current line: ^ + /
- Indent lines inward or outward: ^ + [ or ]