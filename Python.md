# setting env
```
# Create a virtual environment
python -m venv myenv
# Activate the virtual environment
source myenv/bin/activate  # On Unix or MacOS
myenv\Scripts\activate  # On Windows
# Deactivate the virtual environment
deactivate

# Install a package
pip install package_name
# List installed packages
pip list
# Create requirements.txt
pip freeze > requirements.txt
# Install packages from requirements.txt
pip install -r requirements.txt
```

# Basics
- [python-operators-and-booleans/](https://writeblocked.org/resources/python_cheat_sheet.pdf)
- [string manipulation](https://github.com/wilfredinni/python-cheatsheet/blob/master/docs/cheatsheet/manipulating-strings.md)

- [vscode shortcutc](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-windows.pdf)

```python

# f string
print(f"Formatted value: {value:.2f}")
info = f"""
Name: {name}
Age: {age}
"""

# Comprehension
[expr for value in collections if condition] # list
[expression for item1 in iterable1 for item2 in iterable2 ... if condition] # nested list
{key-expr: value-expr for value in collection if condition} # dictionary
{expre for value in collection if condition} # set

function(*args) # * unpacks a lit.  Here, funciton takes multiple arguments and args a list of arguments

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

for arg1, arg2 in zip(args1, args2):
  ...

for index, arg in enumerate(args):
  ...

# regular expressions
import re
re.findall(pattern, txt) # returns a list of all matches
re.search(pattern, txt) # returns a match

```

# Datetime
[strftime cheatsheet](https://strftime.org/)
```python

# format datetime series with timezone from Date, HE and tz
df['DateTime'] = df['Date'].astype(str) + ' ' + (df_ref['HE']-1).astype(str) + ':00:00'
df['DateTime'] = pd.to_datetime(df['DateTime'], format='%Y-%m-%d %H:%M:%S').dt.tz_localize(tz, ambiguous="NaT", nonexistent="NaT")
df['DateTime'] = df['DateTime'] + pd.Timedelta(hours=1)

import datetime
import pytz
from pandas.tseries.offsets import Day, MonthEnd

# Date range sequence
pd.date_range(start='1/1/2018', end='1/08/2018')
pd.date_range("2012-01-01 00:10", periods=10, tz="UTC")
pd.date_range(start='2000-1-1', periods=5, freq="5min")

ts.truncate(after="2011-01-09")
ts.resample("D")

now + MonthEnd(2)
now + 3 * Day()

pd.period_range("2000-1-1", "2000-6-30", freq="M")

dt = datetime(2024, 7, 17, 0, 0, 0)
dt.day     # return integer
dt.minute
dt.date() # return object
dt.time()
dt.strftime("%Y-%m-%d %H:%M") # return string
datetime.strptime("20091031", "%Y%m%d") # read in datetime

now = datetime.now()

# timezone
tz = pytz.timezone('Asia/Kolkata')
obj = tz.localize(dt)
new_tz = pytz.timezone('America/New_York')
obj.astimezone(new_tz)
ts.tz_convert(tz)

# list of time zones
pytz.common_timezones
# UTC
# US/Pacific
# US/Eastern

# add 90 days and an hour
obj + datetime.timedelta(days=90, hours=1)

# pandas
pd.to_datetime(str_dates)

```

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

from enum import Enum
class Color(Enum):
    RED = 1
    GREEN = 2
    BLUE = 3
print(Color.RED)

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
# pandas
```python
import pandas as pd

# series - extension of np.array and dictionary
srs = pd.Series([1,2,3,4], index=["a", "b", "c", "d"]) # need indexs
srs.index
srs.name
srs.index.name
srs['a']
srs.isna()
srs.notna()
srs.map(f) 

# data frame
df = pd.DataFrame(arr2d)
df.col1 or df["col1"]
df.info()

del df['col1'] # remove a column
df.drop(index = [...], columns = [...])

# index
srs.reindex([...]) # rearrange the data according to the new index
srs.reindex([...], method = "ffill", limit, fill_value) # missing dat will be forward-filled with the previous observation. for backward-fill, "bfill". Use limit for max fill gap size. 
df.reindex(columns = [...])
df.index.is_unique
df.index.name = "item"
df.columns.name = "item"
srs.value_counts()

# categories (factors)
df[col1] = df[col1].astype('category')
c = df[col1].array
c.categories
c.codes
dict(enemerate(c.categories))

df.sort_index(axis="columns", ascending=False)
df.sort_values(["a", "b"])

srs.unique()
srs.value_counts()
srs.isna()
pd.value_counts(srs)

# filtering
df.loc([...]) # ... is label index, or boolean
df.iloc([...]) # integer location index
df.loc[row]
df.loc[:, cols]

# operation
df1.add(df2, fill_value = 0)
df.sub(srs, axis = "index")
df.apply(f, axis = "columns") # apply across the columns, once per row
df.applymap(f) # element-wise

# statistics
df.sum(axis="columns", skipna=False)
df.mean(axis, askipna, level)
df.idxmax()
df.cumsum()
df.describe()
# count, describe, min, max, argmin, argmax, idxmin, idxmax, quantile, sum, mean, median, mad, prod, var, std, skew, kurt, cumsum, cummin, cummax, cumprod, diff, pct_change
srs1.corr(srs2)
df.corr(method='pearson')  # 'kendall', and 'spearman' are the other 2 options
df.corrwith(drop, method) # pairwise correlation

rnd = np.random.default_rng(seed=12345)
draws = rng.standard_norma(1000)
bins = pd.qcut(draws, 4, labels=['Q1', 'Q2', 'Q3', 'Q4'])
bins = pd.Series(bins, name = 'quartile')
results = (pd.Series(draws)
            . groupby(bins)
            .agg(['mean', 'min', 'max'])
            . reset_index())
```

## pandas data imports
```python
df = pd.read_csv("filename.csv", names=['col1', 'col2', ...], idex_col = ["Date", ...], skiprows[0,1,..], nrows = 5, parse_dates)
df.to_csv("filename.csv", index=False, columns['col1', 'col3'])

df = read_excel("fielname.xlsx", sheet_name='sheet1')

df.to_hdf("filename.h5", "obj", format="table")
pd.read_hdf("filename.h5", "obj", where=["index < 5"])

import requests
resp = requests.get(url)
resp.raise_for_status
data = resp.json()pd.DataFrame(data)

import sqlalchemy as sqla
db = sqla.create_engine(srt_connection)
pd.read_sql(qry)
```

## pandas data wrangling
```python
df.dtypes
df.convert_dtypes()
np.nan
df.dropna(axis = "index") # drops rows with any NA
df.fillna(0)
df.fillna({col1: 0.5, col2: 0})
df.fillna(method="ffill") # For backward-fill, "bfill"
df.replace(-999, na.nan)
df.replace({-999: np.nan, -1000: 0})
df.filter(like='Temp', axis=1)

df.duplicated(0
df.drop_duplicates(subset=["col1"])

df[newcol] = df[col1].map(dict) # dict maps col1 to values
dim.take(values) # where dim is a lookp series with keys, and values are enumerated value series.  

categories = pd.cut(data, 4, precision = 2)
pd.qcut()  # quantile cut
pd.value_counts(categories)

df.sample(n=10, replace=True)
df = df[col1].join(df.get_dummies(df[col2], prefix="x")) # change a factor column into indicator columns

# hierarchical indexing
df.index.nlevels
df.set_index(["c", "d"], drop = True) # Use columns as indexes
df.reset_index() # move index into columns

pd.merge(df1, df2, on=["key1", "key2"], how = "outer", suffixes = ("_left", "_right")) # default: "inner". how = "outer", "left" or "right"
pd.merge(df1, df2, left_on="lkey", right_on="rkey")
pd.merge(df1, df2, left_on="lkey", right_index=True)
df1.join(df2, how="outer") # merge with indexes. default "left"  

np.concatanate([arr, arr], axis=1)
pd.concat([s1, s2, s3], axis="columns", keys=["one", "two", "three"])
pd.concat([df1, df2], ignore_index=True)

df.swaplevel("key1", "key2")
df.sort_index(level=1)

# map example
fahrenheit = list(map(lambda c: (c * 9/5) + 32, celsius))
sums = list(map(lambda x, y: x + y, a, b))
```

## pandas aggregation
```python
df.groupby("key1", dropna=False, as_index=False, group_keys=False).mean()
df["col1"].groupby(df["key1", "key2"]).mean()  # keys can be any arrays of the correct length, or functions like len
df.groupby("key").agg([("ave", "mean"), "std", ("calc1", custom_function)])  # (name, function)
df.groupby("key").agg({"col1": np.max, "col2": ["sum", "mean"]}) # apply different agg functions to different columns

# groupby methods
# mean, size, count, min, max, quantile, sum, ...

df.groupby("key").apply(f, arg1, arg2, ...) # f returns a panda object

df.groupby("key").transform('mean') # f returns scaler. transform returns the same size as input

# pivoting
# unstack(): Converts long format to wide format by moving index levels to columns.
# stack(): Converts wide format to long format by moving columns to index levels.
# pivot(): Reshapes data from long to wide format using specified index, columns, and values.
# melt(): Converts wide format to long format by unpivoting columns into rows.
# pivot_table(): Creates pivot tables with aggregation, similar to pivot() but with more functionality for summarizing data.

data.unstack(level="state", dropna=False) # pivot a long table to a short table
data.stack() # melt a short table to a long table
long_data = (data.stack()
              .reset_index()
              .rename(columns={0:"value"}))
pivoted = long_data.pivot(index="date", columns="item", values="value")
pd.melt(df, id_vars="key", vAlue_vars=["A", "B"])

df.pivot_table(index=["col1", "col2"])
df.pivot_table(index=["col1", "col2"], columns='col3', values=["col4", "col5"], aggfun=mean, fill_value=0, dropna)

```

# Plot

## matplotlib
- [matplotlib gallery](https://matplotlib.org/stable/gallery/index.html)
- [cheat sheet](https://matplotlib.org/cheatsheets/_images/cheatsheets-1.png)
- [cheet sheet 2](https://matplotlib.org/cheatsheets/_images/cheatsheets-2.png)

```python
import matplotlib.pyplot as plt

# global plot configurations
plt.rc("figure", figsize=(10,7)) 

# multiple plot layout
nplot = 3
fig, ax = plt.subplots(nplot, 1, figsize=(20, 2*nplot)) # figure is the container of axes. Axes are individual plots within figure. 
idx = 0
ax[idx].plot(xxx, label='x')
ax[idx].plot(yyy, label='y')
ax[idx].legend(loc='upper right')
ax[idx].set_ylabel('ylab')

# Add spacing in between
fig.subplots_adjust(wspace=0, hspace=0) # adjust the space between the plots

fig.savefig("fig.pdf", dpi)
```
## data frame plotting
[seaborn gallery](https://seaborn.pydata.org/examples/index.html)
```python
import seaborn as sns

fig, axes = plt.subplots(2,1)
srs.plot() # line plot
df.plot.bar()

# style
sns.set_style("whitegrid")

sns.barplot(x = "col1", y="col2", data=df, orient="h")
srs.plot.hist(bins=50)
sns.histplot(values, bins=100)
ax = sns.regplot(x="col1", y="col2", data=df)
ax.title(label)

sns.pairplot(df, diag_kind="kde", plot_kws={"alpha":0.2})
```
## plotly
[plotly](https://plotly.com/python/)

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
- Navigate backwards: Alt + LeftArrow
