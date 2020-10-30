# numpy



- Best array data manipulation, fast  
- numpy array allows only single data type, unlike list  
- Support matrix operation

<!-- jupyter_markdown, jupyter_meta = list(tags = "remove_cell") -->
## Environment Setup


```python
import pandas as pd
import matplotlib.pyplot as plt
import math
pd.set_option( 'display.notebook_repr_html', False)  # render Series and DataFrame as text, not HTML
pd.set_option( 'display.max_column', 10)    # number of columns
pd.set_option( 'display.max_rows', 10)     # number of rows
pd.set_option( 'display.width', 90)        # number of characters per row
```


<!-- jupyter_markdown -->
## Module Import


```python
import numpy as np
np.__version__

## other modules
```

```
#:> '1.19.1'
```

```python
from datetime import datetime
from datetime import date
from datetime import time
```

## Data Types

### NumPy Data Types

NumPy supports a much greater variety of numerical types than Python does. This makes numpy **much more powerful** https://www.numpy.org/devdocs/user/basics.types.html

**Integer**: np.int8, np.int16, np.int32, np.uint8, np.uint16, np.uint32  
**Float**: np.float32, np.float64

<!-- jupyter_markdown -->
### int32/64

```np.int``` is actually **python standard int**


```python
x = np.int(13)
y = int(13)
print( type(x) )
```

```
#:> <class 'int'>
```

```python
print( type(y) )
```

```
#:> <class 'int'>
```

```np.int32/64``` are NumPy specific


```python
x = np.int32(13)
y = np.int64(13)
print( type(x) )
```

```
#:> <class 'numpy.int32'>
```

```python
print( type(y) )
```

```
#:> <class 'numpy.int64'>
```

### float32/64


```python
x = np.float(13)
y = float(13)
print( type(x) )
```

```
#:> <class 'float'>
```

```python
print( type(y) )
```

```
#:> <class 'float'>
```


```python
x = np.float32(13)
y = np.float64(13)
print( type(x) )
```

```
#:> <class 'numpy.float32'>
```

```python
print( type(y) )
```

```
#:> <class 'numpy.float64'>
```

### bool
```np.bool``` is actually **python standard bool**


```python
x = np.bool(True)
print( type(x) )
```

```
#:> <class 'bool'>
```

```python
print( type(True) )
```

```
#:> <class 'bool'>
```

### str
```np.str``` is actually **python standard str**


```python
x = np.str("ali")
print( type(x) )
```

```
#:> <class 'str'>
```


```python
x = np.str_("ali")
print( type(x) )
```

```
#:> <class 'numpy.str_'>
```

### datetime64
Unlike python standard datetime library, there is **no seperation** of date, datetime and time.  
There is **no time equivalent object**  
NumPy only has one object: **datetime64** object .

#### Constructor
**From String**  
Note that the input string **cannot be ISO8601 compliance**, meaning any timezone related information at the end of the string (such as Z or +8) will result in **error**.


```python
np.datetime64('2005-02')
```

```
#:> numpy.datetime64('2005-02')
```


```python
np.datetime64('2005-02-25')
```

```
#:> numpy.datetime64('2005-02-25')
```


```python
np.datetime64('2005-02-25T03:30')
```

```
#:> numpy.datetime64('2005-02-25T03:30')
```

**From datetime**


```python
np.datetime64( date.today() )
```

```
#:> numpy.datetime64('2020-10-30')
```


```python
np.datetime64( datetime.now() )
```

```
#:> numpy.datetime64('2020-10-30T12:57:53.685440')
```

#### Instance Method
Convert to **datetime** using **```astype()```**


```python
dt64 = np.datetime64("2019-01-31" )
dt64.astype(datetime)
```

```
#:> datetime.date(2019, 1, 31)
```


### nan

#### Creating NaN

NaN is NOT A BUILT-IN datatype. It means **not a number**, a numpy **float** object type. Can be created using two methods below.


```python
import numpy as np
import pandas as pd
import math

kosong1 = float('NaN')
kosong2 = np.nan

print('Type: ', type(kosong1), '\n',
       'Value: ', kosong1)
```

```
#:> Type:  <class 'float'> 
#:>  Value:  nan
```


```python
print('Type: ', type(kosong2), '\n',
       'Value: ', kosong2)
```

```
#:> Type:  <class 'float'> 
#:>  Value:  nan
```

#### Detecting NaN

Detect nan using various function from panda, numpy and math. 


```python
print(pd.isna(kosong1), '\n',
      pd.isna(kosong2), '\n',
      np.isnan(kosong1),'\n',
      math.isnan(kosong2))
```

```
#:> True 
#:>  True 
#:>  True 
#:>  True
```

#### Operation

##### Logical Operator


```python
print( True and kosong1,
       kosong1 and True)
```

```
#:> nan True
```


```python
print( True or kosong1,
       False or kosong1)
```

```
#:> True nan
```

##### Comparing

Compare nan with **anything results in False**, including itself.


```python
print(kosong1 > 0, kosong1==0, kosong1<0,
      kosong1 ==1, kosong1==kosong1, kosong1==False, kosong1==True)
```

```
#:> False False False False False False False
```

##### Casting

nan is numpy floating value. It is not a zero value, therefore casting to boolean returns True.


```python
bool(kosong1)
```

```
#:> True
```


## Numpy Array

### Concept
Structure
- NumPy provides an N-dimensional array type, the **ndarray**
- **ndarray** is **homogenous**: every item takes up the same size block of memory, and all blocks
- For each ndarray, there is a seperate **dtype object**, which describe ndarray data type  
- An item extracted from an array, e.g., by indexing, is represented by a Python object whose type is one of the array scalar types built in NumPy. The array scalars allow easy manipulation of also more complicated arrangements of data.
![numpy_concept](./img/numpy.png)

<!-- jupyter_markdown -->
### Constructor
By default, numpy.array autodetect its data types based on most common denominator

#### dType: int, float

<!-- jupyter_markdown -->
Notice example below **auto detected** as int32 data type


```python
x = np.array( (1,2,3,4,5) )
print(x)
```

```
#:> [1 2 3 4 5]
```

```python
print('Type: ', type(x))
```

```
#:> Type:  <class 'numpy.ndarray'>
```

```python
print('dType:', x.dtype)
```

```
#:> dType: int64
```

<!-- jupyter_markdown -->
Notice example below **auto detected** as float64 data type


```python
x = np.array( (1,2,3,4.5,5) )
print(x)
# print('Type: ', type(x))
# print('dType:', x.dtype)
```

```
#:> [1.  2.  3.  4.5 5. ]
```

<!-- jupyter_markdown -->
You can specify dtype to specify desired data types.   
NumPy will **auto convert** the data into specifeid types. Observe below that we convert float into integer


```python
x = np.array( (1,2,3,4.5,5), dtype='int' )
print(x)
```

```
#:> [1 2 3 4 5]
```

```python
print('Type: ', type(x))
```

```
#:> Type:  <class 'numpy.ndarray'>
```

```python
print('dType:', x.dtype)
```

```
#:> dType: int64
```

<!-- jupyter_markdown -->
#### dType: datetime64

Specify ```dtype``` is necessary to ensure output is datetime type. If not, output is generic **object** type.  

From ```str```


```python
x = np.array(['2007-07-13', '2006-01-13', '2010-08-13'], dtype='datetime64')
print(x)
```

```
#:> ['2007-07-13' '2006-01-13' '2010-08-13']
```

```python
print('Type: ', type(x))
```

```
#:> Type:  <class 'numpy.ndarray'>
```

```python
print('dType:', x.dtype)
```

```
#:> dType: datetime64[D]
```

<!-- jupyter_markdown -->
From ```datetime```  


```python
x = np.array([datetime(2019,1,12), datetime(2019,1,14),datetime(2019,3,3)], dtype='datetime64')
print(x)
```

```
#:> ['2019-01-12T00:00:00.000000' '2019-01-14T00:00:00.000000'
#:>  '2019-03-03T00:00:00.000000']
```

```python
print('Type: ', type(x))
```

```
#:> Type:  <class 'numpy.ndarray'>
```

```python
print('dType:', x.dtype)
```

```
#:> dType: datetime64[us]
```

```python
print('\nElement Type:',type(x[1]))
```

```
#:> 
#:> Element Type: <class 'numpy.datetime64'>
```

<!-- jupyter_markdown -->
#### 2D Array


```python
x = np.array([range(10),np.arange(10)])
x
```

```
#:> array([[0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
#:>        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]])
```

<!-- jupyter_markdown -->
### Dimensions

<!-- jupyter_markdown -->
#### Differentiating Dimensions
1-D array is array of single list  
2-D array is array made of list containing lists (each row is a list)  
2-D single row array is array with list containing just one list

<!-- jupyter_markdown -->
#### 1-D Array
Observe that the **shape of the array** is (5,). It seems like an array with 5 rows, **empty columns** !  
What it really means is 5 items **single dimension**.


```python
arr = np.array(range(5))
print (arr)
```

```
#:> [0 1 2 3 4]
```

```python
print (arr.shape)
```

```
#:> (5,)
```

```python
print (arr.ndim)
```

```
#:> 1
```

<!-- jupyter_markdown -->
#### 2-D Array


```python
arr = np.array([range(5),range(5,10),range(10,15)])
print (arr)
```

```
#:> [[ 0  1  2  3  4]
#:>  [ 5  6  7  8  9]
#:>  [10 11 12 13 14]]
```

```python
print (arr.shape)
```

```
#:> (3, 5)
```

```python
print (arr.ndim)
```

```
#:> 2
```

<!-- jupyter_markdown -->
#### 2-D Array - Single Row


```python
arr = np.array([range(5)])
print (arr)
```

```
#:> [[0 1 2 3 4]]
```

```python
print (arr.shape)
```

```
#:> (1, 5)
```

```python
print (arr.ndim)
```

```
#:> 2
```

<!-- jupyter_markdown -->
#### 2-D Array : Single Column
Using array slicing method with **newaxis** at **COLUMN**, will turn 1D array into 2D of **single column**


```python
arr = np.arange(5)[:, np.newaxis]
print (arr)
```

```
#:> [[0]
#:>  [1]
#:>  [2]
#:>  [3]
#:>  [4]]
```

```python
print (arr.shape)
```

```
#:> (5, 1)
```

```python
print (arr.ndim)
```

```
#:> 2
```

<!-- jupyter_markdown -->
Using array slicing method with **newaxis** at **ROW**, will turn 1D array into 2D of **single row**


```python
arr = np.arange(5)[np.newaxis,:]
print (arr)
```

```
#:> [[0 1 2 3 4]]
```

```python
print (arr.shape)
```

```
#:> (1, 5)
```

```python
print (arr.ndim)
```

```
#:> 2
```

<!-- jupyter_markdown -->
### Class Method

<!-- jupyter_markdown -->
#### ```arange()```
Generate array with a sequence of numbers


```python
np.arange(10)
```

```
#:> array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
```

<!-- jupyter_markdown -->
#### ```ones()```


```python
np.ones(10)  # One dimension, default is float
```

```
#:> array([1., 1., 1., 1., 1., 1., 1., 1., 1., 1.])
```


```python
np.ones((2,5),'int')  #Two dimensions
```

```
#:> array([[1, 1, 1, 1, 1],
#:>        [1, 1, 1, 1, 1]])
```

<!-- jupyter_markdown -->
#### ```zeros()```


```python
np.zeros( 10 )    # One dimension, default is float
```

```
#:> array([0., 0., 0., 0., 0., 0., 0., 0., 0., 0.])
```


```python
np.zeros((2,5),'int')   # 2 rows, 5 columns of ZERO
```

```
#:> array([[0, 0, 0, 0, 0],
#:>        [0, 0, 0, 0, 0]])
```

<!-- jupyter_markdown -->
#### ```where()```
On **1D array** ```numpy.where()``` returns the items matching the criteria


```python
ar1 = np.array(range(10))
print( ar1 )
```

```
#:> [0 1 2 3 4 5 6 7 8 9]
```

```python
print( np.where(ar1>5) )
```

```
#:> (array([6, 7, 8, 9]),)
```

<!-- jupyter_markdown -->
On **2D array**, ```where()``` return array of **row index and col index** for matching elements


```python
ar = np.array([(1,2,3,4,5),(11,12,13,14,15),(21,22,23,24,25)])
print ('Data : \n', ar)
```

```
#:> Data : 
#:>  [[ 1  2  3  4  5]
#:>  [11 12 13 14 15]
#:>  [21 22 23 24 25]]
```

```python
np.where(ar>13)
```

```
#:> (array([1, 1, 2, 2, 2, 2, 2]), array([3, 4, 0, 1, 2, 3, 4]))
```

<!-- jupyter_markdown -->
#### Logical Methods
**```numpy.logical_or```**  
Perform **or** operation on two boolean array,  generate new resulting **boolean arrays**


```python
ar = np.arange(10)
print( ar==3 )  # boolean array 1
```

```
#:> [False False False  True False False False False False False]
```

```python
print( ar==6 )  # boolean array 2
```

```
#:> [False False False False False False  True False False False]
```

```python
print( np.logical_or(ar==3,ar==6 ) ) # resulting boolean
```

```
#:> [False False False  True False False  True False False False]
```

<!-- jupyter_markdown -->
**```numpy.logical_and```**  
Perform **and** operation on two boolean array,  generate new resulting **boolean arrays**


```python
ar = np.arange(10)
print( ar==3 ) # boolean array 1
```

```
#:> [False False False  True False False False False False False]
```

```python
print( ar==6 ) # boolean array 2
```

```
#:> [False False False False False False  True False False False]
```

```python
print( np.logical_and(ar==3,ar==6 ) )  # resulting boolean
```

```
#:> [False False False False False False False False False False]
```

<!-- jupyter_markdown -->
### Instance Method

<!-- jupyter_markdown -->
#### ``` astype()``` conversion
**Convert to from datetime64 to datetime**


```python
ar1 = np.array(['2007-07-13', '2006-01-13', '2010-08-13'], dtype='datetime64')
print( type(ar1) )  ## a numpy array
```

```
#:> <class 'numpy.ndarray'>
```

```python
print( ar1.dtype )  ## dtype is a numpy data type
```

```
#:> datetime64[D]
```

<!-- jupyter_markdown -->
After convert to datetime (non-numpy object, the dtype becomes **generic 'object'**.


```python
ar2 = ar1.astype(datetime)
print( type(ar2) )  ## still a numpy array
```

```
#:> <class 'numpy.ndarray'>
```

```python
print( ar2.dtype )  ## dtype becomes generic 'object'
```

```
#:> object
```

<!-- jupyter_markdown -->
#### ```reshape()```
```
reshape ( row numbers, col numbers )
```

<!-- jupyter_markdown -->
**Sample Data**


```python
a = np.array([range(5), range(10,15), range(20,25), range(30,35)])
a
```

```
#:> array([[ 0,  1,  2,  3,  4],
#:>        [10, 11, 12, 13, 14],
#:>        [20, 21, 22, 23, 24],
#:>        [30, 31, 32, 33, 34]])
```

<!-- jupyter_markdown -->
**Resphepe 1-Dim to 2-Dim**


```python
np.arange(12) # 1-D Array
```

```
#:> array([ 0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11])
```


```python
np.arange(12).reshape(3,4)  # 2-D Array
```

```
#:> array([[ 0,  1,  2,  3],
#:>        [ 4,  5,  6,  7],
#:>        [ 8,  9, 10, 11]])
```

<!-- jupyter_markdown -->
**Respahe 2-Dim to 2-Dim**


```python
np.array([range(5), range(10,15)])  # 2-D Array
```

```
#:> array([[ 0,  1,  2,  3,  4],
#:>        [10, 11, 12, 13, 14]])
```


```python
np.array([range(5), range(10,15)]).reshape(5,2) # 2-D Array
```

```
#:> array([[ 0,  1],
#:>        [ 2,  3],
#:>        [ 4, 10],
#:>        [11, 12],
#:>        [13, 14]])
```

<!-- jupyter_markdown -->
**Reshape 2-Dimension to 2-Dim (of single row)**
- Change 2x10 to 1x10  
- Observe [[ ]], and the number of dimension is stll 2, don't be fooled


```python
np.array( [range(0,5), range(5,10)])  # 2-D Array
```

```
#:> array([[0, 1, 2, 3, 4],
#:>        [5, 6, 7, 8, 9]])
```


```python
np.array( [range(0,5), range(5,10)]).reshape(1,10) # 2-D Array
```

```
#:> array([[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]])
```

<!-- jupyter_markdown -->
**Reshape 1-Dim Array to 2-Dim Array (single column)**


```python
np.arange(8)
```

```
#:> array([0, 1, 2, 3, 4, 5, 6, 7])
```


```python
np.arange(8).reshape(8,1)
```

```
#:> array([[0],
#:>        [1],
#:>        [2],
#:>        [3],
#:>        [4],
#:>        [5],
#:>        [6],
#:>        [7]])
```

<!-- jupyter_markdown -->
A better method, use **newaxis**, easier because no need to input row number as parameter


```python
np.arange(8)[:,np.newaxis]
```

```
#:> array([[0],
#:>        [1],
#:>        [2],
#:>        [3],
#:>        [4],
#:>        [5],
#:>        [6],
#:>        [7]])
```

<!-- jupyter_markdown -->
**Reshape 1-Dim Array to 2-Dim Array (single row)**


```python
np.arange(8)
```

```
#:> array([0, 1, 2, 3, 4, 5, 6, 7])
```


```python
np.arange(8)[np.newaxis,:]
```

```
#:> array([[0, 1, 2, 3, 4, 5, 6, 7]])
```

<!-- jupyter_markdown -->
### Element Selection
#### Sample Data


```python
x1 = np.array( (0,1,2,3,4,5,6,7,8))
x2 = np.array(( (1,2,3,4,5), 
      (11,12,13,14,15),
      (21,22,23,24,25)))
print(x1)
```

```
#:> [0 1 2 3 4 5 6 7 8]
```

```python
print(x2)
```

```
#:> [[ 1  2  3  4  5]
#:>  [11 12 13 14 15]
#:>  [21 22 23 24 25]]
```

<!-- jupyter_markdown -->
#### 1-Dimension
All indexing starts from 0 (not 1)

<!-- jupyter_markdown -->
Choosing **Single Element** does not return array


```python
print( x1[0]   )  ## first element
```

```
#:> 0
```

```python
print( x1[-1]  )  ## last element
```

```
#:> 8
```

```python
print( x1[3]   )  ## third element from start 3
```

```
#:> 3
```

```python
print( x1[-3]  )  ## third element from end
```

```
#:> 6
```

<!-- jupyter_markdown -->
Selecting **multiple elments** return **ndarray**


```python
print( x1[:3]  )  ## first 3 elements
```

```
#:> [0 1 2]
```

```python
print( x1[-3:])   ## last 3 elements
```

```
#:> [6 7 8]
```

```python
print( x1[3:]  )  ## all except first 3 elements
```

```
#:> [3 4 5 6 7 8]
```

```python
print( x1[:-3] )  ## all except last 3 elements
```

```
#:> [0 1 2 3 4 5]
```

```python
print( x1[1:4] )  ## elemnt 1 to 4 (not including 4)
```

```
#:> [1 2 3]
```

<!-- jupyter_markdown -->
#### 2-Dimension
Indexing with **[ row_positoins, row_positions ]**, index starts with 0


```python
x[1:3, 1:4] # row 1 to 2 column 1 to 3
```

```
#:> array([[1, 2, 3]])
```

<!-- jupyter_markdown -->
### Attributes
#### ```dtype```
ndarray contain a property called **dtype**, whcih tell us the type of underlying items


```python
a = np.array( (1,2,3,4,5), dtype='float' )
a.dtype
```

```
#:> dtype('float64')
```


```python
print(a.dtype)
```

```
#:> float64
```

```python
print( type(a[1]))
```

```
#:> <class 'numpy.float64'>
```

<!-- jupyter_markdown -->
#### ```dim```
**```dim```** returns the number of dimensions of the NumPy array. Example below shows 2-D array


```python
x = np.array(( (1,2,3,4,5), 
      (11,12,13,14,15),
      (21,22,23,24,25)))
x.ndim  
```

```
#:> 2
```

<!-- jupyter_markdown -->
#### ```shape```
**```shape```** return a type of **(rows, cols)**


```python
x = np.array(( (1,2,3,4,5), 
      (11,12,13,14,15),
      (21,22,23,24,25)))
x.shape  
```

```
#:> (3, 5)
```


```python
np.identity(5)
```

```
#:> array([[1., 0., 0., 0., 0.],
#:>        [0., 1., 0., 0., 0.],
#:>        [0., 0., 1., 0., 0.],
#:>        [0., 0., 0., 1., 0.],
#:>        [0., 0., 0., 0., 1.]])
```

<!-- jupyter_markdown -->
### Operations

<!-- jupyter_markdown -->
#### Arithmetic
**Sample Date**


```python
ar = np.arange(10)
print( ar )
```

```
#:> [0 1 2 3 4 5 6 7 8 9]
```

<!-- jupyter_markdown -->
**```*```**


```python
ar = np.arange(10)
print (ar)
```

```
#:> [0 1 2 3 4 5 6 7 8 9]
```

```python
print (ar*2)
```

```
#:> [ 0  2  4  6  8 10 12 14 16 18]
```

<!-- jupyter_markdown -->
```**+ and -**```


```python
ar = np.arange(10)
print (ar+2)
```

```
#:> [ 2  3  4  5  6  7  8  9 10 11]
```

```python
print (ar-2)
```

```
#:> [-2 -1  0  1  2  3  4  5  6  7]
```

<!-- jupyter_markdown -->
#### Comparison
**Sample Data**


```python
ar = np.arange(10)
print( ar )
```

```
#:> [0 1 2 3 4 5 6 7 8 9]
```

<!-- jupyter_markdown -->
**```==```**


```python
print( ar==3 )
```

```
#:> [False False False  True False False False False False False]
```

<!-- jupyter_markdown -->
**```>, >=, <, <=```**


```python
print( ar>3 )
```

```
#:> [False False False False  True  True  True  True  True  True]
```

```python
print( ar<=3 )
```

```
#:> [ True  True  True  True False False False False False False]
```

<!-- jupyter_markdown -->
## Random Numbers

<!-- jupyter_markdown -->
### Uniform Distribution

<!-- jupyter_markdown, jupyter_meta = list(heading_collapsed = TRUE) -->
#### Random Integer (with Replacement)
**randint()** Return random integers from **low (inclusive) to high (exclusive)**
```
np.random.randint( low )                  # generate an integer, i, which         i < low
np.random.randint( low, high )            # generate an integer, i, which  low <= i < high
np.random.randint( low, high, size=1)     # generate an ndarray of integer, single dimension
np.random.randint( low, high, size=(r,c)) # generate an ndarray of integer, two dimensions 
```


```python
np.random.randint( 10 )
```

```
#:> 4
```


```python
np.random.randint( 10, 20 )
```

```
#:> 11
```


```python
np.random.randint( 10, high=20, size=5)   # single dimension
```

```
#:> array([15, 17, 17, 15, 15])
```


```python
np.random.randint( 10, 20, (3,5) )        # two dimensions
```

```
#:> array([[19, 12, 17, 13, 17],
#:>        [14, 17, 18, 14, 19],
#:>        [14, 19, 18, 13, 10]])
```

<!-- jupyter_markdown -->
#### Random Integer (with or without replacement)
```
numpy.random .choice( a, size, replace=True)
 # sampling from a, 
 #   if a is integer, then it is assumed sampling from arange(a)
 #   if a is an 1-D array, then sampling from this array
```


```python
np.random.choice(10,5, replace=False) # take 5 samples from 0:19, without replacement
```

```
#:> array([4, 3, 6, 0, 9])
```


```python
np.random.choice( np.arange(10,20), 5, replace=False)
```

```
#:> array([11, 10, 15, 14, 18])
```

<!-- jupyter_markdown -->
#### Random Float
**randf()**  Generate float numbers in **between 0.0 and 1.0**
```
np.random.ranf(size=None)
```


```python
np.random.ranf(4)
```

```
#:> array([0.38865275, 0.14298136, 0.88246303, 0.16238914])
```

<!-- jupyter_markdown -->
**uniform()** Return random float from **low (inclusive) to high (exclusive)**
```
np.random.uniform( low )                  # generate an float, i, which         f < low
np.random.uniform( low, high )            # generate an float, i, which  low <= f < high
np.random.uniform( low, high, size=1)     # generate an array of float, single dimension
np.random.uniform( low, high, size=(r,c)) # generate an array of float, two dimensions 
```


```python
np.random.uniform( 2 )
```

```
#:> 1.7119247520770995
```


```python
np.random.uniform( 2,5, size=(4,4) )
```

```
#:> array([[4.27570471, 2.20194391, 2.83887199, 2.80498115],
#:>        [4.17440516, 4.19754459, 4.95790076, 2.9919817 ],
#:>        [2.52966922, 4.92233332, 2.67028018, 3.31668594],
#:>        [4.08858151, 2.42584438, 3.70241505, 2.42128839]])
```

<!-- jupyter_markdown -->
### Normal Distribution

```
numpy. random.randn (n_items)       # 1-D standard normal (mean=0, stdev=1)
numpy. random.randn (nrows, ncols)  # 2-D standard normal (mean=0, stdev=1)
numpy. random.standard_normal( size=None )                # default to mean = 0, stdev = 1, non-configurable
numpy. random.normal         ( loc=0, scale=1, size=None) # loc = mean, scale = stdev, size = dimension
```

<!-- jupyter_markdown -->
#### Standard Normal Distribution
Generate random normal numbers with gaussion distribution (mean=0, stdev=1)

<!-- jupyter_markdown -->
**One Dimension**


```python
np.random.standard_normal(3)
```

```
#:> array([-1.31330408, -1.21192416,  0.45881391])
```


```python
np.random.randn(3)
```

```
#:> array([-0.21608391, -1.54736363, -1.45841352])
```

<!-- jupyter_markdown -->
**Two Dimensions**


```python
np.random.randn(2,4)
```

```
#:> array([[-0.89069379,  0.97312614,  0.5604055 ,  0.35410484],
#:>        [-0.22074825,  0.47912767, -0.58241599, -0.93300786]])
```


```python
np.random.standard_normal((2,4))
```

```
#:> array([[ 0.39891082,  1.11014554, -1.0581033 ,  2.43981232],
#:>        [-0.57544928, -2.49573774, -0.630934  , -0.76079872]])
```

<!-- jupyter_markdown -->
**Observe:** randn(), standard_normal() and normal() are able to generate standard normal numbers


```python
np.random.seed(15)
print (np.random.randn(5))
```

```
#:> [-0.31232848  0.33928471 -0.15590853 -0.50178967  0.23556889]
```

```python
np.random.seed(15)
print (np.random.normal ( size = 5 )) # stdev and mean not specified, default to standard normal
```

```
#:> [-0.31232848  0.33928471 -0.15590853 -0.50178967  0.23556889]
```

```python
np.random.seed(15)
print (np.random.standard_normal (size=5))
```

```
#:> [-0.31232848  0.33928471 -0.15590853 -0.50178967  0.23556889]
```

<!-- jupyter_markdown -->
#### Normal Distribution (Non-Standard)


```python
np.random.seed(125)
np.random.normal( loc = 12, scale=1.25, size=(3,3))
```

```
#:> array([[11.12645382, 12.01327885, 10.81651695],
#:>        [12.41091248, 12.39383072, 11.49647195],
#:>        [ 8.70837035, 12.25246312, 11.49084235]])
```

<!-- jupyter_markdown -->
#### Linear Spacing

```
numpy.linspace(start, stop, num=50, endpoint=True, retstep=False, dtype=None)
# endpoint: If True, stop is the last sample, otherwise it is not included
```

<!-- jupyter_markdown -->
**Include Endpoint**  
Step = Gap divide by (number of elements minus 1) (2/(10-1))


```python
np.linspace(1,3,10) #default endpont=True
```

```
#:> array([1.        , 1.22222222, 1.44444444, 1.66666667, 1.88888889,
#:>        2.11111111, 2.33333333, 2.55555556, 2.77777778, 3.        ])
```

<!-- jupyter_markdown -->
**Does Not Include Endpoint**  
Step = Gap divide by (number of elements minus 1) (2/(101))


```python
np.linspace(1,3,10,endpoint=False)
```

```
#:> array([1. , 1.2, 1.4, 1.6, 1.8, 2. , 2.2, 2.4, 2.6, 2.8])
```

<!-- jupyter_markdown, jupyter_meta = list(heading_collapsed = TRUE) -->
## Sampling (Integer)
```
random.choice( a, size=None, replace=True, p=None)  # a=integer, return <size> integers < a
random.choice( a, size=None, replace=True, p=None)  # a=array-like, return <size> integers picked from list a
```


```python
np.random.choice (100, size=10)
```

```
#:> array([58,  0, 84, 50, 89, 32, 87, 30, 66, 92])
```


```python
np.random.choice( [1,3,5,7,9,11,13,15,17,19,21,23], size=10, replace=False)
```

```
#:> array([ 5,  1, 23, 17,  3, 13, 15,  9, 21,  7])
```

<!-- jupyter_markdown -->
## NaN : Missing Numerical Data

- You should be aware that NaN is a bit like a data virus?it infects any other object it touches  



```python
t = np.array([1, np.nan, 3, 4]) 
t.dtype
```

```
#:> dtype('float64')
```

<!-- jupyter_markdown -->
Regardless of the operation, the result of arithmetic with NaN will be another NaN


```python
1 + np.nan
```

```
#:> nan
```


```python
t.sum(), t.mean(), t.max()
```

```
#:> (nan, nan, nan)
```


```python
np.nansum(t), np.nanmean(t), np.nanmax(t)
```

```
#:> (8.0, 2.6666666666666665, 4.0)
```
