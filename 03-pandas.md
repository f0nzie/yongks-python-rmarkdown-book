# pandas






## Modules Import


```python
import pandas as pd

## Other Libraries
import numpy as np
import datetime as dt
from datetime import datetime
from datetime import date
```

## Pandas Objects

### Pandas Data Types
- pandas.Timestamp
- pandas.Timedelta
- pandas.Period
- pandas.Interval
- pandas.DateTimeIndex

### Pandas Data Structure  

|Type        | Dimension | Size      | Value   | Constructor
|:---------- |:----------|:----------|:--------|:----------------------------------------------------
|Series      | 1         | Immutable | Mutable | pandas.DataFrame( data, index, dtype, copy)  
|DataFrame   | 2         | Mutable   | Mutable | pandas.DataFrame( data, index, columns, dtype, copy)
|Panel       | 3         | Mutable   | Mutable | 

**data** can be ndarray, list, constants  
**index** must be unique and same length as data. Can be integer or string
**dtype** if none, it will be inferred  
**copy** copy data. Default false

## Class Method

### Creating Timestamp Objects

Pandas **`to_datetime()`** can:  
- Convert list of dates to **DateTimeIndex**  
- Convert list of dates to **Series of Timestamps**  
- Convert single date into **Timestamp** Object
. Source can be **string, date, datetime object**

#### From List to `DateTimeIndex`


```python
dti = pd.to_datetime(['2011-01-03',             # from string
                       date(2018,4,13),         # from date
                       datetime(2018,3,1,7,30)] # from datetime
              )
print( dti,
      '\nObject Type:  ', type(dti),
      '\nObject dtype: ', dti.dtype,
      '\nElement Type: ', type(dti[1]))
```

```
#:> DatetimeIndex(['2011-01-03 00:00:00', '2018-04-13 00:00:00', '2018-03-01 07:30:00'], dtype='datetime64[ns]', freq=None) 
#:> Object Type:   <class 'pandas.core.indexes.datetimes.DatetimeIndex'> 
#:> Object dtype:  datetime64[ns] 
#:> Element Type:  <class 'pandas._libs.tslibs.timestamps.Timestamp'>
```

#### From List to Series of Timestamps


```python
sdt = pd.to_datetime(pd.Series(['2011-01-03',      # from string
                                date(2018,4,13),        # from date
                                datetime(2018,3,1,7,30)]# from datetime
              ))
print(sdt,
      '\nObject Type:  ',type(sdt),
      '\nObject dtype: ', sdt.dtype,
      '\nElement Type: ',type(sdt[1]))
```

```
#:> 0   2011-01-03 00:00:00
#:> 1   2018-04-13 00:00:00
#:> 2   2018-03-01 07:30:00
#:> dtype: datetime64[ns] 
#:> Object Type:   <class 'pandas.core.series.Series'> 
#:> Object dtype:  datetime64[ns] 
#:> Element Type:  <class 'pandas._libs.tslibs.timestamps.Timestamp'>
```

#### From Scalar to Timestamp


```python
print( pd.to_datetime('2011-01-03'), '\n',
       pd.to_datetime(date(2011,1,3)), '\n',
       pd.to_datetime(datetime(2011,1,3,5,30)), '\n',
       '\nElement Type: ', type(pd.to_datetime(datetime(2011,1,3,5,30))))
```

```
#:> 2011-01-03 00:00:00 
#:>  2011-01-03 00:00:00 
#:>  2011-01-03 05:30:00 
#:>  
#:> Element Type:  <class 'pandas._libs.tslibs.timestamps.Timestamp'>
```

### Generate Timestamp Sequence

The function `date_range()` return **`DateTimeIndex`** object. Use `Series()` to convert into Series if desired.

#### Hourly

If start time not specified, default to 00:00:00.  
If start time specified, it will be honored on all subsequent Timestamp elements.  
Specify **start** and **end**, sequence will automatically distribute Timestamp according to **frequency**.  


```python
print(
  pd.date_range('2018-01-01', periods=3, freq='H'),
  pd.date_range(datetime(2018,1,1,12,30), periods=3, freq='H'),
  pd.date_range(start='2018-01-03-1230', end='2018-01-03-18:30', freq='H'))
```

```
#:> DatetimeIndex(['2018-01-01 00:00:00', '2018-01-01 01:00:00', '2018-01-01 02:00:00'], dtype='datetime64[ns]', freq='H') DatetimeIndex(['2018-01-01 12:30:00', '2018-01-01 13:30:00', '2018-01-01 14:30:00'], dtype='datetime64[ns]', freq='H') DatetimeIndex(['2018-01-03 12:30:00', '2018-01-03 13:30:00', '2018-01-03 14:30:00',
#:>                '2018-01-03 15:30:00', '2018-01-03 16:30:00', '2018-01-03 17:30:00',
#:>                '2018-01-03 18:30:00'],
#:>               dtype='datetime64[ns]', freq='H')
```

#### Daily

When the **frequency is Day and time is not specified**, output is date distributed.  
When time is specified, output will honor the time.


```python
print(
  pd.date_range(date(2018,1,2), periods=3, freq='D'),
  pd.date_range('2018-01-01-1230', periods=4, freq='D'))
```

```
#:> DatetimeIndex(['2018-01-02', '2018-01-03', '2018-01-04'], dtype='datetime64[ns]', freq='D') DatetimeIndex(['2018-01-01 12:30:00', '2018-01-02 12:30:00', '2018-01-03 12:30:00',
#:>                '2018-01-04 12:30:00'],
#:>               dtype='datetime64[ns]', freq='D')
```

#### First Day Of Month

Use `freq=MS`, M stands for montly, S stand for Start. If the **day** specified, the sequence start from first day of following month.


```python
print(
  pd.date_range('2018-01', periods=4, freq='MS'),
  pd.date_range('2018-01-09', periods=4, freq='MS'),
  pd.date_range('2018-01-09 12:30:00', periods=4, freq='MS') )
```

```
#:> DatetimeIndex(['2018-01-01', '2018-02-01', '2018-03-01', '2018-04-01'], dtype='datetime64[ns]', freq='MS') DatetimeIndex(['2018-02-01', '2018-03-01', '2018-04-01', '2018-05-01'], dtype='datetime64[ns]', freq='MS') DatetimeIndex(['2018-02-01 12:30:00', '2018-03-01 12:30:00', '2018-04-01 12:30:00',
#:>                '2018-05-01 12:30:00'],
#:>               dtype='datetime64[ns]', freq='MS')
```
#### Last Day of Month

Sequence always starts from the end of the specified month.


```python
print(
  pd.date_range('2018-01', periods=4, freq='M'),
  pd.date_range('2018-01-09', periods=4, freq='M'),
  pd.date_range('2018-01-09 12:30:00', periods=4, freq='M'))
```

```
#:> DatetimeIndex(['2018-01-31', '2018-02-28', '2018-03-31', '2018-04-30'], dtype='datetime64[ns]', freq='M') DatetimeIndex(['2018-01-31', '2018-02-28', '2018-03-31', '2018-04-30'], dtype='datetime64[ns]', freq='M') DatetimeIndex(['2018-01-31 12:30:00', '2018-02-28 12:30:00', '2018-03-31 12:30:00',
#:>                '2018-04-30 12:30:00'],
#:>               dtype='datetime64[ns]', freq='M')
```

### Frequency Table (crosstab)

crosstab returns **Dataframe** Object
```
crosstab( index = <SeriesObj>, columns = <new_colName> )                # one dimension table
crosstab( index = <SeriesObj>, columns = <SeriesObj> )                  # two dimension table
crosstab( index = <SeriesObj>, columns = [<SeriesObj1>, <SeriesObj2>] ) # multi dimension table   
crosstab( index = <SeriesObj>, columns = <SeriesObj>, margines=True )   # add column and row margins
```

#### Sample Data


```python
n = 200
comp = ['C' + i for i in np.random.randint( 1,4, size  = n).astype(str)] # 3x Company
dept = ['D' + i for i in np.random.randint( 1,6, size  = n).astype(str)] # 5x Department
grp =  ['G' + i for i in np.random.randint( 1,3, size  = n).astype(str)] # 2x Groups
value1 = np.random.normal( loc=50 , scale=5 , size = n)
value2 = np.random.normal( loc=20 , scale=3 , size = n)
value3 = np.random.normal( loc=5 , scale=30 , size = n)

mydf = pd.DataFrame({
    'comp':comp, 
    'dept':dept, 
    'grp': grp,
    'value1':value1, 
    'value2':value2,
    'value3':value3 })
mydf.head()
```

```
#:>   comp dept grp     value1     value2     value3
#:> 0   C1   D5  G2  47.209653  19.207380  -2.476396
#:> 1   C2   D3  G1  37.307555  17.566220  31.261279
#:> 2   C1   D1  G1  53.936504  24.618976  -4.492714
#:> 3   C3   D3  G2  50.199830  20.445438 -26.177600
#:> 4   C2   D4  G2  45.447956  15.401361   1.214276
```

#### One DimensionTable


```python
## Frequency Countn For Company, Department
print(
  pd.crosstab(index=mydf.comp, columns='counter'),'\n\n',
  pd.crosstab(index=mydf.dept, columns='counter'))
```

```
#:> col_0  counter
#:> comp          
#:> C1          72
#:> C2          67
#:> C3          61 
#:> 
#:>  col_0  counter
#:> dept          
#:> D1          44
#:> D2          53
#:> D3          36
#:> D4          34
#:> D5          33
```

#### Two Dimension Table


```python
pd.crosstab(index=mydf.comp, columns=mydf.dept)
```

```
#:> dept  D1  D2  D3  D4  D5
#:> comp                    
#:> C1    19  19  13   7  14
#:> C2    13  18  10  15  11
#:> C3    12  16  13  12   8
```

#### Higher Dimension Table

Crosstab header is **multi-levels index** when more than one column specified.


```python
tb = pd.crosstab(index=mydf.comp, columns=[mydf.dept, mydf.grp])
print( tb, '\n\n',
       tb.columns )
```

```
#:> dept D1      D2      D3    D4    D5   
#:> grp  G1  G2  G1  G2  G1 G2 G1 G2 G1 G2
#:> comp                                  
#:> C1    7  12   9  10  10  3  2  5  7  7
#:> C2    8   5  10   8   4  6  9  6  6  5
#:> C3    6   6  10   6   6  7  4  8  4  4 
#:> 
#:>  MultiIndex([('D1', 'G1'),
#:>             ('D1', 'G2'),
#:>             ('D2', 'G1'),
#:>             ('D2', 'G2'),
#:>             ('D3', 'G1'),
#:>             ('D3', 'G2'),
#:>             ('D4', 'G1'),
#:>             ('D4', 'G2'),
#:>             ('D5', 'G1'),
#:>             ('D5', 'G2')],
#:>            names=['dept', 'grp'])
```

Select **sub-dataframe** using multi-level referencing.


```python
print( 'Under D2:\n', tb['D2'], '\n\n',
       'Under D2-G2:\n',tb['D2','G1'])
```

```
#:> Under D2:
#:>  grp   G1  G2
#:> comp        
#:> C1     9  10
#:> C2    10   8
#:> C3    10   6 
#:> 
#:>  Under D2-G2:
#:>  comp
#:> C1     9
#:> C2    10
#:> C3    10
#:> Name: (D2, G1), dtype: int64
```

#### Getting Margin
Extend the crosstab with 'margin=True' to have sum of rows/columns, presented in **new column/row named 'All'**.


```python
tb = pd.crosstab(index=mydf.dept, columns=mydf.grp, margins=True)
tb
```

```
#:> grp    G1  G2  All
#:> dept              
#:> D1     21  23   44
#:> D2     29  24   53
#:> D3     20  16   36
#:> D4     15  19   34
#:> D5     17  16   33
#:> All   102  98  200
```


```python
print(
  'Row Sums:     \n', tb.loc[:,'All'],
  '\n\nColumn Sums:\n', tb.loc['All'])
```

```
#:> Row Sums:     
#:>  dept
#:> D1      44
#:> D2      53
#:> D3      36
#:> D4      34
#:> D5      33
#:> All    200
#:> Name: All, dtype: int64 
#:> 
#:> Column Sums:
#:>  grp
#:> G1     102
#:> G2      98
#:> All    200
#:> Name: All, dtype: int64
```

#### Getting Proportion
Use matrix operation divide each row with its respective column sum.


```python
tb/tb.loc['All']
```

```
#:> grp         G1        G2    All
#:> dept                           
#:> D1    0.205882  0.234694  0.220
#:> D2    0.284314  0.244898  0.265
#:> D3    0.196078  0.163265  0.180
#:> D4    0.147059  0.193878  0.170
#:> D5    0.166667  0.163265  0.165
#:> All   1.000000  1.000000  1.000
```

### Concatination

#### Sample Data


```python
s1 = pd.Series(['A1','A2','A3','A4'])
s2 = pd.Series(['B1','B2','B3','B4'], name='B')
s3 = pd.Series(['C1','C2','C3','C4'], name='C')
```

#### Column-Wise

**Combinining Multiple Series Into A New DataFrame**  
- Added series will have 0,1,2,... column names (if Series are not named originally)  
- None series will be ignored  
- `axis=1` means column-wise


```python
pd.concat([s1,s2,s3, None], axis=1)
```

```
#:>     0   B   C
#:> 0  A1  B1  C1
#:> 1  A2  B2  C2
#:> 2  A3  B3  C3
#:> 3  A4  B4  C4
```

**Add Multiple Series Into An Existing DataFrame**  
- No change to original data frame column name  
- Added columns from series will have 0,1,2,3,.. column name


```python
df = pd.DataFrame({ 'A': s1, 'B': s2})
pd.concat([df,s3,s1, None],axis=1)
```

```
#:>     A   B   C   0
#:> 0  A1  B1  C1  A1
#:> 1  A2  B2  C2  A2
#:> 2  A3  B3  C3  A3
#:> 3  A4  B4  C4  A4
```

#### Row-Wise




### External Data

#### `html_table` Parser

This method require **html5lib** library.  
- Read the web page, create a list: which contain one or more dataframes that maps to each html table found  
- Scrap all detectable html tables  
- Auto detect column header  
- Auto create index using number starting from 0  

```
read_html(url)  # return list of dataframe(s) that maps to web table(s) structure
```


```python
df_list = pd.read_html('https://www.malaysiastock.biz/Listed-Companies.aspx?type=S&s1=18')  ## read all tables
df = df_list[6]  ## get the specific table

print ('Total Table(s) Found : ', len(df_list), '\n',
       'First Table Found:      ',df)
```

```
#:> Total Table(s) Found :  11 
#:>  First Table Found:                0                                                  1
#:> 0  Sector:  --- Filter by Sector ---  BOND ISLAMIC  CLOSED...
```

#### CSV Writing

**Syntax**  

```
DataFrame.to_csv(
  path_or_buf=None,   ## if not provided, result is returned as string
  sep=', ', 
  na_rep='', 
  float_format=None, 
  columns=None,       ## list of columns name to write, if not provided, all columns are written
  header=True,        ## write out column names
  index=True,         ## write row label
  index_label=None, 
  mode='w', 
  encoding=None,      ## if not provided, default to 'utf-8'
  quoting=None, quotechar='"', 
  line_terminator=None, 
  chunksize=None, 
  date_format=None, 
  doublequote=True, 
  escapechar=None, 
  decimal='.')

```

Example below shows column value containing different special character. Note that pandas handles these very well by default.


```python
mydf = pd.DataFrame({'Id':[10,20,30,40], 
                     'Name':  ['Aaa','Bbb','Ccc','Ddd'],
                     'Funny': ["world's most \clever", 
                     "Bloody, damn, good", 
                     "many\nmany\nline", 
                     'Quoting "is" tough']})
mydf.set_index('Id', inplace=True)
mydf.to_csv('data/csv_test.csv', index=True)
mydf
```

```
#:>    Name                 Funny
#:> Id                           
#:> 10  Aaa  world's most \clever
#:> 20  Bbb    Bloody, damn, good
#:> 30  Ccc      many\nmany\nline
#:> 40  Ddd    Quoting "is" tough
```

**This is the file saved**


```r
# system('more data\\csv_test.csv')
```

**All content retained when reading back by Pandas**


```python
pd.read_csv('data/csv_test.csv', index_col='Id')
```

```
#:>    Name                 Funny
#:> Id                           
#:> 10  Aaa  world's most \clever
#:> 20  Bbb    Bloody, damn, good
#:> 30  Ccc      many\nmany\nline
#:> 40  Ddd    Quoting "is" tough
```

#### CSV Reading

**Syntax**  

```
pandas.read_csv( 
    'url or filePath',                     # path to file or url 
    encoding    = 'utf_8',                 # optional: default is 'utf_8'
    index_col   = ['colName1', ...],       # optional: specify one or more index column
    parse_dates = ['dateCol1', ...],       # optional: specify multiple string column to convert to date
    na_values   = ['.','na','NA','N/A'],   # optional: values that is considered NA
    names       = ['newColName1', ... ],   # optional: overwrite column names
    thousands   = '.',                     # optional: thousand seperator symbol
    nrows       = n,                       # optional: load only first n rows
    skiprows    = 0,                       # optional: don't load first n rows
    parse_dates = False,                   # List of date column names
    infer_datetime_format = False          # automatically parse dates
)
```
Refer to full codec [Python Codec](https://docs.python.org/3/library/codecs.html#standard-encodings).

**Default Import**  

- index is sequence of integer 0,1,2...   
- only two data types detection; **number (float64/int64) and string (object)**  
- **date is not parsed**, hence stayed as string  


```python
goo = pd.read_csv('data/goog.csv', encoding='utf_8')
print(goo.head(), '\n\n',
      goo.info())
```

```
#:> <class 'pandas.core.frame.DataFrame'>
#:> RangeIndex: 61 entries, 0 to 60
#:> Data columns (total 6 columns):
#:>  #   Column  Non-Null Count  Dtype  
#:> ---  ------  --------------  -----  
#:>  0   Date    61 non-null     object 
#:>  1   Open    61 non-null     float64
#:>  2   High    61 non-null     float64
#:>  3   Low     61 non-null     float64
#:>  4   Close   61 non-null     float64
#:>  5   Volume  61 non-null     int64  
#:> dtypes: float64(4), int64(1), object(1)
#:> memory usage: 3.0+ KB
#:>          Date        Open        High         Low       Close   Volume
#:> 0  12/19/2016  790.219971  797.659973  786.270020  794.200012  1225900
#:> 1  12/20/2016  796.760010  798.650024  793.270020  796.419983   925100
#:> 2  12/21/2016  795.840027  796.676025  787.099976  794.559998  1208700
#:> 3  12/22/2016  792.359985  793.320007  788.580017  791.260010   969100
#:> 4  12/23/2016  790.900024  792.739990  787.280029  789.909973   623400 
#:> 
#:>  None
```

**Specify Data Types**  

- To customize the data type, use **`dtype`** parameter with a **dict** of definition.  


```python
d_types = {'Volume': str}
pd.read_csv('data/goog.csv', dtype=d_types).info()
```

```
#:> <class 'pandas.core.frame.DataFrame'>
#:> RangeIndex: 61 entries, 0 to 60
#:> Data columns (total 6 columns):
#:>  #   Column  Non-Null Count  Dtype  
#:> ---  ------  --------------  -----  
#:>  0   Date    61 non-null     object 
#:>  1   Open    61 non-null     float64
#:>  2   High    61 non-null     float64
#:>  3   Low     61 non-null     float64
#:>  4   Close   61 non-null     float64
#:>  5   Volume  61 non-null     object 
#:> dtypes: float64(4), object(2)
#:> memory usage: 3.0+ KB
```

**Parse Datetime**

You can specify multiple date-alike column for parsing


```python
pd.read_csv('data/goog.csv', parse_dates=['Date']).info()
```

```
#:> <class 'pandas.core.frame.DataFrame'>
#:> RangeIndex: 61 entries, 0 to 60
#:> Data columns (total 6 columns):
#:>  #   Column  Non-Null Count  Dtype         
#:> ---  ------  --------------  -----         
#:>  0   Date    61 non-null     datetime64[ns]
#:>  1   Open    61 non-null     float64       
#:>  2   High    61 non-null     float64       
#:>  3   Low     61 non-null     float64       
#:>  4   Close   61 non-null     float64       
#:>  5   Volume  61 non-null     int64         
#:> dtypes: datetime64[ns](1), float64(4), int64(1)
#:> memory usage: 3.0 KB
```

**Parse Datetime, Then Set as Index**  
- Specify names of date column in `parse_dates=`  
- When date is set as index, the type is **`DateTimeIndex`**  


```python
goo3 = pd.read_csv('data/goog.csv',index_col='Date', parse_dates=['Date'])
goo3.info()
```

```
#:> <class 'pandas.core.frame.DataFrame'>
#:> DatetimeIndex: 61 entries, 2016-12-19 to 2017-03-17
#:> Data columns (total 5 columns):
#:>  #   Column  Non-Null Count  Dtype  
#:> ---  ------  --------------  -----  
#:>  0   Open    61 non-null     float64
#:>  1   High    61 non-null     float64
#:>  2   Low     61 non-null     float64
#:>  3   Close   61 non-null     float64
#:>  4   Volume  61 non-null     int64  
#:> dtypes: float64(4), int64(1)
#:> memory usage: 2.9 KB
```

### Inspection

#### Structure `info`

**info()** is a function that print information to screen. It doesn't return any object

```
dataframe.info()  # display columns and number of rows (that has no missing data)
```


```python
goo.info()
```

```
#:> <class 'pandas.core.frame.DataFrame'>
#:> RangeIndex: 61 entries, 0 to 60
#:> Data columns (total 6 columns):
#:>  #   Column  Non-Null Count  Dtype  
#:> ---  ------  --------------  -----  
#:>  0   Date    61 non-null     object 
#:>  1   Open    61 non-null     float64
#:>  2   High    61 non-null     float64
#:>  3   Low     61 non-null     float64
#:>  4   Close   61 non-null     float64
#:>  5   Volume  61 non-null     int64  
#:> dtypes: float64(4), int64(1), object(1)
#:> memory usage: 3.0+ KB
```

#### `head`


```python
goo.head()
```

```
#:>          Date        Open        High         Low       Close   Volume
#:> 0  12/19/2016  790.219971  797.659973  786.270020  794.200012  1225900
#:> 1  12/20/2016  796.760010  798.650024  793.270020  796.419983   925100
#:> 2  12/21/2016  795.840027  796.676025  787.099976  794.559998  1208700
#:> 3  12/22/2016  792.359985  793.320007  788.580017  791.260010   969100
#:> 4  12/23/2016  790.900024  792.739990  787.280029  789.909973   623400
```

## class: Timestamp

This is an enhanced version to datetime standard library.  
https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.Timestamp.html#pandas.Timestamp

### Constructor

#### From Number


```python
print( pd.Timestamp(year=2017, month=1, day=1),'\n',  #date-like numbers
       pd.Timestamp(2017,1,1), '\n',                  # date-like numbers
       pd.Timestamp(2017,12,11,5,45),'\n',            # datetime-like numbers
       pd.Timestamp(2017,12,11,5,45,55,999),'\n',     # + microseconds
       pd.Timestamp(2017,12,11,5,45,55,999,8),'\n',   # + nanoseconds
       type(pd.Timestamp(2017,12,11,5,45,55,999,8)),'\n')
```

```
#:> 2017-01-01 00:00:00 
#:>  2017-01-01 00:00:00 
#:>  2017-12-11 05:45:00 
#:>  2017-12-11 05:45:55.000999 
#:>  2017-12-11 05:45:55.000999008 
#:>  <class 'pandas._libs.tslibs.timestamps.Timestamp'>
```

#### From String

Observe that pandas support many string input format  

**Year Month Day**, default has no timezone

```python
print( pd.Timestamp('2017-12-11'),'\n',   # date-like string: year-month-day
       pd.Timestamp('2017 12 11'),'\n',   # date-like string: year-month-day
       pd.Timestamp('2017 Dec 11'),'\n',  # date-like string: year-month-day
       pd.Timestamp('Dec 11, 2017'))      # date-like string: year-month-day
```

```
#:> 2017-12-11 00:00:00 
#:>  2017-12-11 00:00:00 
#:>  2017-12-11 00:00:00 
#:>  2017-12-11 00:00:00
```

**YMD Hour Minute Second Ms**


```python
print( pd.Timestamp('2017-12-11 0545'),'\n',     ## hour minute
       pd.Timestamp('2017-12-11-05:45'),'\n',
       pd.Timestamp('2017-12-11T0545'),'\n',
       pd.Timestamp('2017-12-11 054533'),'\n',   ## hour minute seconds
       pd.Timestamp('2017-12-11 05:45:33'))
```

```
#:> 2017-12-11 05:45:00 
#:>  2017-12-11 05:45:00 
#:>  2017-12-11 05:45:00 
#:>  2017-12-11 05:45:33 
#:>  2017-12-11 05:45:33
```

**With Timezone** can be included in various ways.


```python
print( pd.Timestamp('2017-01-01T0545Z'),'\n',  # GMT 
       pd.Timestamp('2017-01-01T0545+9'),'\n', # GMT+9
       pd.Timestamp('2017-01-01T0545+0800'),'\n',   # GMT+0800
       pd.Timestamp('2017-01-01 0545', tz='Asia/Singapore'),'\n')
```

```
#:> 2017-01-01 05:45:00+00:00 
#:>  2017-01-01 05:45:00+09:00 
#:>  2017-01-01 05:45:00+08:00 
#:>  2017-01-01 05:45:00+08:00
```

#### From Standard Library ```datetime``` and ```date``` Object


```python
print( pd.Timestamp(date(2017,3,5)),'\n',           # from date
       pd.Timestamp(datetime(2017,3,5,4,30)),'\n',  # from datetime
       pd.Timestamp(datetime(2017,3,5,4,30), tz='Asia/Kuala_Lumpur')) # from datetime, + tz
```

```
#:> 2017-03-05 00:00:00 
#:>  2017-03-05 04:30:00 
#:>  2017-03-05 04:30:00+08:00
```

### Attributes

We can tell many things about a Timestamp object.


```python
ts = pd.Timestamp('2017-01-01T054533+0800') # GMT+0800
print( ts.month, '\n',
       ts.day, '\n',
       ts.year, '\n',
       ts.hour, '\n',
       ts.minute, '\n',
       ts.second, '\n',
       ts.microsecond, '\n',
       ts.nanosecond, '\n',
       ts.tz, '\n',
       ts.daysinmonth,'\n',
       ts.dayofyear, '\n',
       ts.is_leap_year, '\n',
       ts.is_month_end, '\n',
       ts.is_month_start, '\n',
       ts.dayofweek)
```

```
#:> 1 
#:>  1 
#:>  2017 
#:>  5 
#:>  45 
#:>  33 
#:>  0 
#:>  0 
#:>  pytz.FixedOffset(480) 
#:>  31 
#:>  1 
#:>  False 
#:>  False 
#:>  True 
#:>  6
```

Note that timezone (tz) is a **pytz object**.


```python
ts1 = pd.Timestamp(datetime(2017,3,5,4,30), tz='Asia/Kuala_Lumpur')   # from datetime, + tz
ts2 = pd.Timestamp('2017-01-01T054533+0800') # GMT+0800
ts3 = pd.Timestamp('2017-01-01T0545')

print( ts1.tz, 'Type:', type(ts1.tz), '\n',
       ts2.tz, 'Type:', type(ts2.tz), '\n',
       ts3.tz, 'Type:', type(ts3.tz)  )
```

```
#:> Asia/Kuala_Lumpur Type: <class 'pytz.tzfile.Asia/Kuala_Lumpur'> 
#:>  pytz.FixedOffset(480) Type: <class 'pytz._FixedOffset'> 
#:>  None Type: <class 'NoneType'>
```

### Instance Methods

#### Atribute-like Methods


```python
ts = pd.Timestamp(2017,1,1)
print( ' Weekday:    ', ts.weekday(), '\n',
       'ISO Weekday:',  ts.isoweekday(), '\n',
       'Day Name:   ',  ts.day_name(), '\n',
       'ISO Calendar:',  ts.isocalendar()
       )
```

```
#:>  Weekday:     6 
#:>  ISO Weekday: 7 
#:>  Day Name:    Sunday 
#:>  ISO Calendar: (2016, 52, 7)
```

#### Timezones

**Adding Timezones and Clock Shifting**  

- `tz_localize` will add the timezone, however will not shift the clock.  
- Once a timestamp had gotten a timezone, you can easily shift the clock to another timezone using `tz_convert()`  


```python
ts = pd.Timestamp(2017,1,10,10,34)        ## No timezone
ts1 = ts.tz_localize('Asia/Kuala_Lumpur')  ## Add timezone
ts2 = ts1.tz_convert('UTC')                 ## Convert timezone
print(' Origininal Timestamp           :', ts,  '\n',
      'Loacalized Timestamp (added TZ):', ts1, '\n',
      'Converted Timestamp (shifted)  :',ts2)
```

```
#:>  Origininal Timestamp           : 2017-01-10 10:34:00 
#:>  Loacalized Timestamp (added TZ): 2017-01-10 10:34:00+08:00 
#:>  Converted Timestamp (shifted)  : 2017-01-10 02:34:00+00:00
```

**Removing Timezone**

Just apply **None with `tz_localize`** to remove TZ infomration.


```python
ts = pd.Timestamp(2017,1,10,10,34)        ## No timezone
ts = ts.tz_localize('Asia/Kuala_Lumpur')  ## Add timezone
ts = ts.tz_localize(None)                 ## Convert timezone
ts
```

```
#:> Timestamp('2017-01-10 10:34:00')
```

#### Formatting 

**`strftime`**  

Use **```strftime()```** to customize string format. For complete directive, see below: https://docs.python.org/3/library/datetime.html#strftime-strptime-behavior


```python
ts = pd.Timestamp(2017,1,10,10,34)        ## No timezone
ts = ts.tz_localize('Asia/Kuala_Lumpur')  ## Add timezone
ts.strftime("%m/%d")
```

```
#:> '01/10'
```

**`isoformat`**  

Use **```isoformat()```** to format ISO string (**without timezone**)


```python
ts = pd.Timestamp(2017,1,10,10,34)        
ts1 = ts.tz_localize('Asia/Kuala_Lumpur') 
print( ' ISO Format without TZ:', ts.isoformat(), '\n',
       'ISO Format with TZ   :', ts1.isoformat())
```

```
#:>  ISO Format without TZ: 2017-01-10T10:34:00 
#:>  ISO Format with TZ   : 2017-01-10T10:34:00+08:00
```

#### Type Conversion

**Convert To `datetime.datetime/date`**

Use `to_pydatetime()` to convert into standard library **`datetime.datetime`**.  From the 'datetime' object, apply `date()` to get **`datetime.date`**


```python
ts = pd.Timestamp(2017,1,10,7,30,52)
print(
  'Datetime:',  ts.to_pydatetime(), '\n',
  'Date Only:', ts.to_pydatetime().date())
```

```
#:> Datetime: 2017-01-10 07:30:52 
#:>  Date Only: 2017-01-10
```

**Convert To `numpy.datetime64`**

Use `to_datetime64()` to convert into ```numpy.datetime64```


```python
ts = pd.Timestamp(2017,1,10,7,30,52)
ts.to_datetime64()
```

```
#:> numpy.datetime64('2017-01-10T07:30:52.000000000')
```


#### `ceil`


```python
print( ts.ceil(freq='D') ) # ceiling to day
```

```
#:> 2017-01-11 00:00:00
```

#### Updating

`replace()`


```python
ts.replace(year=2000, month=1,day=1)
```

```
#:> Timestamp('2000-01-01 07:30:52')
```

## class: DateTimeIndex

### Creating 

Refer to Pandas class method above.

### Instance Method

#### Data Type Conversion

**Convert To datetime.datetime**  
Use **```to_pydatetime```** to convert into python standard **datetime.datetime** object


```python
print('Converted to List:', dti.to_pydatetime(), '\n\n',
      'Converted Type:',    type(dti.to_pydatetime()))
```

```
#:> Converted to List: [datetime.datetime(2011, 1, 3, 0, 0) datetime.datetime(2018, 4, 13, 0, 0)
#:>  datetime.datetime(2018, 3, 1, 7, 30)] 
#:> 
#:>  Converted Type: <class 'numpy.ndarray'>
```

#### Structure Conversion

**Convert To Series: `to_series`**  
This creates a Series where **index and data** with the same value


```python
#dti = pd.date_range('2018-02', periods=4, freq='M')
dti.to_series()
```

```
#:> 2011-01-03 00:00:00   2011-01-03 00:00:00
#:> 2018-04-13 00:00:00   2018-04-13 00:00:00
#:> 2018-03-01 07:30:00   2018-03-01 07:30:00
#:> dtype: datetime64[ns]
```

**Convert To DataFrame: `to_frame()`**  
This convert to **single column DataFrame** with index as the same value


```python
dti.to_frame()
```

```
#:>                                       0
#:> 2011-01-03 00:00:00 2011-01-03 00:00:00
#:> 2018-04-13 00:00:00 2018-04-13 00:00:00
#:> 2018-03-01 07:30:00 2018-03-01 07:30:00
```

### Attributes

**All Timestamp Attributes** can be used upon DateTimeIndex.


```python
print( dti.weekday, '\n',
       dti.month, '\n',
       dti.daysinmonth)
```

```
#:> Int64Index([0, 4, 3], dtype='int64') 
#:>  Int64Index([1, 4, 3], dtype='int64') 
#:>  Int64Index([31, 30, 31], dtype='int64')
```

## class: Series

Series allows different data types (object class) as its element

```
pandas.Series(data=None, index=None, dtype=None, name=None, copy=False, fastpath=False)
- data array-like, iterable, dict or scalar
- If dtype not specified, it will infer from data.
```

### Constructor

#### Empty Series

Passing no data to constructor will result in empty series. By default, empty series dtype is float.


```python
s = pd.Series(dtype='object')
print (s, '\n',
       type(s))
```

```
#:> Series([], dtype: object) 
#:>  <class 'pandas.core.series.Series'>
```

#### From Scalar

If data is a scalar value, an **index must be provided**. The **value will be repeated** to match the length of index


```python
pd.Series( 99, index = ['a','b','c','d'])
```

```
#:> a    99
#:> b    99
#:> c    99
#:> d    99
#:> dtype: int64
```

#### From array-like

**From list**


```python
pd.Series(['a','b','c','d','e'])           # from Python list
```

```
#:> 0    a
#:> 1    b
#:> 2    c
#:> 3    d
#:> 4    e
#:> dtype: object
```


**From numpy.array**  
If index is not specified, default to 0 and continue incrementally


```python
pd.Series(np.array(['a','b','c','d','e']))
```

```
#:> 0    a
#:> 1    b
#:> 2    c
#:> 3    d
#:> 4    e
#:> dtype: object
```

**From DateTimeIndex**


```python
pd.Series(pd.date_range('2011-1-1','2011-1-3'))
```

```
#:> 0   2011-01-01
#:> 1   2011-01-02
#:> 2   2011-01-03
#:> dtype: datetime64[ns]
```


#### From Dictionary
The **dictionary key** will be the index. Order is **not sorted**.


```python
pd.Series({'a' : 0., 'c' : 5., 'b' : 2.})
```

```
#:> a    0.0
#:> c    5.0
#:> b    2.0
#:> dtype: float64
```

If **index sequence** is specifeid, then Series will forllow the index order  
Objerve that **missing data** (index without value) will be marked as NaN


```python
pd.Series({'a' : 0., 'c' : 1., 'b' : 2.},index = ['a','b','c','d'])
```

```
#:> a    0.0
#:> b    2.0
#:> c    1.0
#:> d    NaN
#:> dtype: float64
```

#### Specify Index


```python
pd.Series(['a','b','c','d','e'], index=[10,20,30,40,50])
```

```
#:> 10    a
#:> 20    b
#:> 30    c
#:> 40    d
#:> 50    e
#:> dtype: object
```

#### Mix Element Types

dType will be **'object'** when there were mixture of classes


```python
ser = pd.Series(['a',1,2,3])
print('Object Type :  ', type(ser),'\n',
      'Object dType:  ', ser.dtype,'\n',
      'Element 1 Type: ',type(ser[0]),'\n',
      'Elmeent 2 Type: ',type(ser[1]))
```

```
#:> Object Type :   <class 'pandas.core.series.Series'> 
#:>  Object dType:   object 
#:>  Element 1 Type:  <class 'str'> 
#:>  Elmeent 2 Type:  <class 'int'>
```

#### Specify Data Types
By default, dtype is **inferred** from data.


```python
ser1 = pd.Series([1,2,3])
ser2 = pd.Series([1,2,3], dtype="int8")
ser3 = pd.Series([1,2,3], dtype="object")

print(' Inferred:        ',ser1.dtype, '\n',
      'Specified int8:  ',ser2.dtype, '\n',
      'Specified object:',ser3.dtype)
```

```
#:>  Inferred:         int64 
#:>  Specified int8:   int8 
#:>  Specified object: object
```

### Accessing Series

```
series     ( single/list/range_of_row_label/number ) # can cause confusion
series.loc ( single/list/range_of_row_label )
series.iloc( single/list/range_of_row_number )
```

#### Sample Data


```python
s = pd.Series([1,2,3,4,5],index=['a','b','c','d','e']) 
s
```

```
#:> a    1
#:> b    2
#:> c    3
#:> d    4
#:> e    5
#:> dtype: int64
```

#### by Row Number(s)

**Single Item**. 
Notice that inputing a number and list of number give different result.


```python
print( 'Referencing by number:',s.iloc[1],'\n\n',
       '\nReferencing by list of number:\n',s.iloc[[1]])
```

```
#:> Referencing by number: 2 
#:> 
#:>  
#:> Referencing by list of number:
#:>  b    2
#:> dtype: int64
```


**Multiple Items**


```python
s.iloc[[1,3]] 
```

```
#:> b    2
#:> d    4
#:> dtype: int64
```


**Range (First 3)**


```python
s.iloc[:3]
```

```
#:> a    1
#:> b    2
#:> c    3
#:> dtype: int64
```


**Range (Last 3)**


```python
s.iloc[-3:]
```

```
#:> c    3
#:> d    4
#:> e    5
#:> dtype: int64
```

**Range (in between)**


```python
s.iloc[2:3]
```

```
#:> c    3
#:> dtype: int64
```

#### by Index(es)

**Single Label**. Notice the difference referencing input: single index and list of index.  
**Warning**: if index is invalid, this will result in error.


```python
print( s.loc['c'], '\n',
       s[['c']])
```

```
#:> 3 
#:>  c    3
#:> dtype: int64
```

**Multiple Labels**

If index is not found, it will return **NaN**


```python
# error: missing labels no longer supported
s.loc[['k','c']]
```

** Range of Labels **


```python
s.loc['b':'d']
```

```
#:> b    2
#:> c    3
#:> d    4
#:> dtype: int64
```

#### Filtering

Use **logical array** to filter


```python
s = pd.Series(range(1,8))
s[s<5]
```

```
#:> 0    1
#:> 1    2
#:> 2    3
#:> 3    4
#:> dtype: int64
```

Use **where**  
The where method is an application of the if-then idiom. For each element in the calling Series, if `cond` is True the element is used; otherwise `other` is used.

```
.where(cond, other=nan, inplace=False)
```


```python
print(s.where(s<4),'\n\n',
      s.where(s<4,other=None) )
```

```
#:> 0    1.0
#:> 1    2.0
#:> 2    3.0
#:> 3    NaN
#:> 4    NaN
#:> 5    NaN
#:> 6    NaN
#:> dtype: float64 
#:> 
#:>  0       1
#:> 1       2
#:> 2       3
#:> 3    None
#:> 4    None
#:> 5    None
#:> 6    None
#:> dtype: object
```

### Updating Series

#### by Row Number(s)


```python
s = pd.Series(range(1,7), index=['a','b','c','d','e','f'])
s[2] = 999
s[[3,4]] = 888,777
s
```

```
#:> a      1
#:> b      2
#:> c    999
#:> d    888
#:> e    777
#:> f      6
#:> dtype: int64
```

#### by Index(es)


```python
s = pd.Series(range(1,7), index=['a','b','c','d','e','f'])
s['e'] = 888
s[['c','d']] = 777,888
s
```

```
#:> a      1
#:> b      2
#:> c    777
#:> d    888
#:> e    888
#:> f      6
#:> dtype: int64
```

### Series Attributes

#### The Data


```python
s = pd.Series([1,2,3,4,5],index=['a','b','c','d','e'],name='SuperHero') 
s
```

```
#:> a    1
#:> b    2
#:> c    3
#:> d    4
#:> e    5
#:> Name: SuperHero, dtype: int64
```

#### The Attributes


```python
print( ' Series Index:    ',s.index, '\n',
       'Series dType:    ', s.dtype, '\n',
       'Series Size:     ', s.size, '\n',
       'Series Shape:    ', s.shape, '\n',
       'Series Dimension:', s.ndim)
```

```
#:>  Series Index:     Index(['a', 'b', 'c', 'd', 'e'], dtype='object') 
#:>  Series dType:     int64 
#:>  Series Size:      5 
#:>  Series Shape:     (5,) 
#:>  Series Dimension: 1
```

### Instance Methods

#### Index Manipulation

**`.rename_axis()`**


```python
s.rename_axis('haribulan')
```

```
#:> haribulan
#:> a    1
#:> b    2
#:> c    3
#:> d    4
#:> e    5
#:> Name: SuperHero, dtype: int64
```

**`.reset_index()`**

Resetting index will:  
- Convert index to a normal column, with column named as **'index'**  
- Index renumbered to 1,2,3  
- Return **DataFrame** (became two columns)


```python
s.reset_index()
```

```
#:>   index  SuperHero
#:> 0     a          1
#:> 1     b          2
#:> 2     c          3
#:> 3     d          4
#:> 4     e          5
```

#### Structure Conversion

- A series structure contain **`value`** (in numpy array), its **`dtype`** (data type of the numpy array).    
- Use **`values`** to retrieve into ```numpy.ndarray``. Use **`dtype`** to understand the data type.  


```python
s = pd.Series([1,2,3,4,5])
print(' Series value:      ', s.values, '\n', 
      'Series value type: ',  type(s.values), '\n',
      'Series dtype:      ',  s.dtype)
```

```
#:>  Series value:       [1 2 3 4 5] 
#:>  Series value type:  <class 'numpy.ndarray'> 
#:>  Series dtype:       int64
```

Convert To List using **`.tolist()`**


```python
pd.Series.tolist(s)
```

```
#:> [1, 2, 3, 4, 5]
```

#### DataType Conversion

Use **```astype()```** to convert to another numpy supproted datatypes, results in a new Series.  
**Warning**: casting to incompatible type will result in **error**


```python
s.astype('int8')
```

```
#:> 0    1
#:> 1    2
#:> 2    3
#:> 3    4
#:> 4    5
#:> dtype: int8
```

### Series Operators

The result of applying operator (arithmetic or logic) to Series object **returns a new Series object**

#### Arithmetic Operator


```python
s1 = pd.Series( [100,200,300,400,500] )
s2 = pd.Series( [10, 20, 30, 40, 50] )
```

**Apply To One Series Object**


```python
s1 - 100
```

```
#:> 0      0
#:> 1    100
#:> 2    200
#:> 3    300
#:> 4    400
#:> dtype: int64
```

**Apply To Two Series Objects**


```python
s1 - s2
```

```
#:> 0     90
#:> 1    180
#:> 2    270
#:> 3    360
#:> 4    450
#:> dtype: int64
```

#### Logic Operator

- Apply logic operator to a Series return a **new Series** of boolean result  
- This can be used for **Series or DataFrame filtering**


```python
bs = pd.Series(range(0,10))
bs>3
```

```
#:> 0    False
#:> 1    False
#:> 2    False
#:> 3    False
#:> 4     True
#:> 5     True
#:> 6     True
#:> 7     True
#:> 8     True
#:> 9     True
#:> dtype: bool
```


```python
~((bs>3) & (bs<8) | (bs>7))
```

```
#:> 0     True
#:> 1     True
#:> 2     True
#:> 3     True
#:> 4    False
#:> 5    False
#:> 6    False
#:> 7    False
#:> 8    False
#:> 9    False
#:> dtype: bool
```

### Series `.str` Accesor

If the underlying data is **str** type, then pandas exposed various properties and methos through **`str` accessor**. 

```
SeriesObj.str.operatorFunction()
``` 

**Available Functions**

Nearly all Python's built-in string methods are mirrored by a Pandas vectorized string method. Here is a list of Pandas str methods that mirror Python string methods:  

len()	lower()	translate()	islower()
ljust()	upper()	startswith()	isupper()
rjust()	find()	endswith()	isnumeric()
center()	rfind()	isalnum()	isdecimal()
zfill()	index()	isalpha()	split()
strip()	rindex()	isdigit()	rsplit()
rstrip()	capitalize()	isspace()	partition()
lstrip()	swapcase()	istitle()	rpartition()

#### Regex Extractor

Extract capture **groups** in the regex pattern, by default in DataFrame (`expand=True`).

```
Series.str.extract(self, pat, flags=0, expand=True)
- expand=True: if result is single column, make it a Series instead of Dataframe.
```


```python
s = pd.Series(['a1', 'b2', 'c3'])
print( 
  ' Extracted Dataframe:\n', s.str.extract(r'([ab])(\d)'),'\n\n',
  'Extracted Dataframe witn Names:\n', s.str.extract(r'(?P<Letter>[ab])(\d)'))
```

```
#:>  Extracted Dataframe:
#:>       0    1
#:> 0    a    1
#:> 1    b    2
#:> 2  NaN  NaN 
#:> 
#:>  Extracted Dataframe witn Names:
#:>    Letter    1
#:> 0      a    1
#:> 1      b    2
#:> 2    NaN  NaN
```

Below ouptut single columne, use **`expand=False`** to make the result a **Series**, instead of DataFrame.


```python
r = s.str.extract(r'[ab](\d)', expand=False)
print( r, '\n\n', type(r) )
```

```
#:> 0      1
#:> 1      2
#:> 2    NaN
#:> dtype: object 
#:> 
#:>  <class 'pandas.core.series.Series'>
```
#### Character Extractor


```python
monte = pd.Series(['Graham Chapman', 'John Cleese', 'Terry Gilliam',
                   'Eric Idle', 'Terry Jones', 'Michael Palin'])
monte
```

```
#:> 0    Graham Chapman
#:> 1       John Cleese
#:> 2     Terry Gilliam
#:> 3         Eric Idle
#:> 4       Terry Jones
#:> 5     Michael Palin
#:> dtype: object
```

**```startwith```**


```python
monte.str.startswith('T')
```

```
#:> 0    False
#:> 1    False
#:> 2     True
#:> 3    False
#:> 4     True
#:> 5    False
#:> dtype: bool
```

**```Slicing```**


```python
monte.str[0:3]
```

```
#:> 0    Gra
#:> 1    Joh
#:> 2    Ter
#:> 3    Eri
#:> 4    Ter
#:> 5    Mic
#:> dtype: object
```

#### Splitting

Split strings around given separator/delimiter in either string or regex.

```
Series.str.split(self, pat=None, n=-1, expand=False)
- pat: can be string or regex
```


```python
s = pd.Series(['a_b_c', 'c_d_e', np.nan, 'f_g_h_i_j'])
s
```

```
#:> 0        a_b_c
#:> 1        c_d_e
#:> 2          NaN
#:> 3    f_g_h_i_j
#:> dtype: object
```

**```str.split()```** by default, split will split each item into **array**


```python
s.str.split('_')
```

```
#:> 0          [a, b, c]
#:> 1          [c, d, e]
#:> 2                NaN
#:> 3    [f, g, h, i, j]
#:> dtype: object
```

**```expand=True```** will return a **dataframe** instead of series. By default, expand split into all possible columns.


```python
print( s.str.split('_', expand=True) )
```

```
#:>      0    1    2     3     4
#:> 0    a    b    c  None  None
#:> 1    c    d    e  None  None
#:> 2  NaN  NaN  NaN   NaN   NaN
#:> 3    f    g    h     i     j
```

It is possible to limit the number of columns splitted


```python
print( s.str.split('_', expand=True, n=1) )
```

```
#:>      0        1
#:> 0    a      b_c
#:> 1    c      d_e
#:> 2  NaN      NaN
#:> 3    f  g_h_i_j
```

**```str.rsplit()```**


**```rsplit```** stands for **reverse split**, it works the same way, except it is reversed


```python
print( s.str.rsplit('_', expand=True, n=1) )
```

```
#:>          0    1
#:> 0      a_b    c
#:> 1      c_d    e
#:> 2      NaN  NaN
#:> 3  f_g_h_i    j
```


#### Case Conversion

```
SeriesObj.str.upper()
SeriesObj.str.lower()
SeriesObj.str.capitalize()
```


```python
s = pd.Series(['A', 'B', 'C', 'aAba', 'bBaca', np.nan, 'cCABA', 'dog', 'cat'])
print( s.str.upper(), '\n',
       s.str.capitalize())
```

```
#:> 0        A
#:> 1        B
#:> 2        C
#:> 3     AABA
#:> 4    BBACA
#:> 5      NaN
#:> 6    CCABA
#:> 7      DOG
#:> 8      CAT
#:> dtype: object 
#:>  0        A
#:> 1        B
#:> 2        C
#:> 3     Aaba
#:> 4    Bbaca
#:> 5      NaN
#:> 6    Ccaba
#:> 7      Dog
#:> 8      Cat
#:> dtype: object
```

#### Number of Characters


```python
s.str.len()
```

```
#:> 0    1.0
#:> 1    1.0
#:> 2    1.0
#:> 3    4.0
#:> 4    5.0
#:> 5    NaN
#:> 6    5.0
#:> 7    3.0
#:> 8    3.0
#:> dtype: float64
```

#### String Indexing

This return specified character from each item.


```python
s = pd.Series(['A', 'B', 'C', 'Aaba', 'Baca', np.nan,'CABA', 'dog', 'cat'])
s.str[0].values    # first char
```

```
#:> array(['A', 'B', 'C', 'A', 'B', nan, 'C', 'd', 'c'], dtype=object)
```

```python
s.str[0:2].values  # first and second char
```

```
#:> array(['A', 'B', 'C', 'Aa', 'Ba', nan, 'CA', 'do', 'ca'], dtype=object)
```

#### Series Substring Extraction

**Sample Data**


```python
s = pd.Series(['a1', 'b2', 'c3'])
s
```

```
#:> 0    a1
#:> 1    b2
#:> 2    c3
#:> dtype: object
```


**Extract absed on regex matching**  
... to improve ...


```python
type(s.str.extract('([ab])(\d)', expand=False))
```

```
#:> <class 'pandas.core.frame.DataFrame'>
```


### Series  `.dt` Accessor 

If the underlying data is **datetime64** type, then pandas exposed various properties and methos through **```dt``` accessor**. 


#### Sample Data


```python
s = pd.Series([
    datetime(2000,1,1,0,0,0),
    datetime(1999,12,15,12,34,55),
    datetime(2020,3,8,5,7,12),
    datetime(2018,1,1,0,0,0),
    datetime(2003,3,4,5,6,7)
])
s
```

```
#:> 0   2000-01-01 00:00:00
#:> 1   1999-12-15 12:34:55
#:> 2   2020-03-08 05:07:12
#:> 3   2018-01-01 00:00:00
#:> 4   2003-03-04 05:06:07
#:> dtype: datetime64[ns]
```


#### Convert To 
**datetime.datetime**  
Use **```to_pydatetime()```** to convert into **```numpy.array```** of standard library **```datetime.datetime```**  


```python
pdt  = s.dt.to_pydatetime()
print( type(pdt) )
```

```
#:> <class 'numpy.ndarray'>
```

```python
pdt
```

```
#:> array([datetime.datetime(2000, 1, 1, 0, 0),
#:>        datetime.datetime(1999, 12, 15, 12, 34, 55),
#:>        datetime.datetime(2020, 3, 8, 5, 7, 12),
#:>        datetime.datetime(2018, 1, 1, 0, 0),
#:>        datetime.datetime(2003, 3, 4, 5, 6, 7)], dtype=object)
```


**datetime.date**  
Use **```dt.date```** to convert into **```pandas.Series```** of standard library **```datetime.date```**   
Is it possible to have a pandas.Series of datetime.datetime ? No, because Pandas want it as its own Timestamp.


```python
sdt = s.dt.date
print( type(sdt[1] ))
```

```
#:> <class 'datetime.date'>
```

```python
print( type(sdt))
```

```
#:> <class 'pandas.core.series.Series'>
```

```python
sdt
```

```
#:> 0    2000-01-01
#:> 1    1999-12-15
#:> 2    2020-03-08
#:> 3    2018-01-01
#:> 4    2003-03-04
#:> dtype: object
```


#### Timestamp Attributes
A Series::DateTime object support below properties:  
- date  
- month  
- day  
- year  
- dayofweek  
- dayofyear  
- weekday  
- weekday_name  
- quarter  
- daysinmonth  
- hour
- minute

Full list below:  
https://pandas.pydata.org/pandas-docs/stable/reference/series.html#datetimelike-properties


```python
s.dt.date
```

```
#:> 0    2000-01-01
#:> 1    1999-12-15
#:> 2    2020-03-08
#:> 3    2018-01-01
#:> 4    2003-03-04
#:> dtype: object
```


```python
s.dt.month
```

```
#:> 0     1
#:> 1    12
#:> 2     3
#:> 3     1
#:> 4     3
#:> dtype: int64
```


```python
s.dt.dayofweek
```

```
#:> 0    5
#:> 1    2
#:> 2    6
#:> 3    0
#:> 4    1
#:> dtype: int64
```


```python
s.dt.weekday
```

```
#:> 0    5
#:> 1    2
#:> 2    6
#:> 3    0
#:> 4    1
#:> dtype: int64
```


```python
# error no attribute weekday_name
s.dt.weekday_name
```


```python
s.dt.quarter
```

```
#:> 0    1
#:> 1    4
#:> 2    1
#:> 3    1
#:> 4    1
#:> dtype: int64
```


```python
s.dt.daysinmonth
```

```
#:> 0    31
#:> 1    31
#:> 2    31
#:> 3    31
#:> 4    31
#:> dtype: int64
```


```python
s.dt.time   # extract time as time Object
```

```
#:> 0    00:00:00
#:> 1    12:34:55
#:> 2    05:07:12
#:> 3    00:00:00
#:> 4    05:06:07
#:> dtype: object
```


```python
s.dt.hour  # extract hour as integer
```

```
#:> 0     0
#:> 1    12
#:> 2     5
#:> 3     0
#:> 4     5
#:> dtype: int64
```


```python
s.dt.minute # extract minute as integer
```

```
#:> 0     0
#:> 1    34
#:> 2     7
#:> 3     0
#:> 4     6
#:> dtype: int64
```


## class: DataFrame

### Constructor

#### Empty DataFrame

By default, An empty dataframe contain no coumns and index.


```python
empty_df1 = pd.DataFrame()
empty_df2 = pd.DataFrame()
print(id(empty_df1), id(empty_df2), empty_df1)
```

```
#:> 140457996160976 140457996357136 Empty DataFrame
#:> Columns: []
#:> Index: []
```

However, you can also initialize an empty DataFrame with Index and/or Columns.


```python
empty_df = pd.DataFrame(columns=['A','B','C'], index=[1,2,3])
print( empty_df )
```

```
#:>      A    B    C
#:> 1  NaN  NaN  NaN
#:> 2  NaN  NaN  NaN
#:> 3  NaN  NaN  NaN
```

Take note that below empty_df1 and empty_df2 refers to **same memory location**. Meaning they cantain similar data.


```python
empty_df1 = empty_df2 = pd.DataFrame()
print(id(empty_df1), id(empty_df2))
```

```
#:> 140457996160848 140457996160848
```


#### From Row Oriented Data (List of Lists)

Create from **List of Lists**

```
DataFrame( [row_list1, row_list2, row_list3] )
DataFrame( [row_list1, row_list2, row_list3], column = columnName_list )
DataFrame( [row_list1, row_list2, row_list3], index  = row_label_list )
```

**Basic DataFrame with default Row Label and Column Header**


```python
pd.DataFrame ([[101,'Alice',40000,2017],
               [102,'Bob',  24000, 2017], 
               [103,'Charles',31000,2017]] )
```

```
#:>      0        1      2     3
#:> 0  101    Alice  40000  2017
#:> 1  102      Bob  24000  2017
#:> 2  103  Charles  31000  2017
```

**Specify Column Header during Creation**


```python
pd.DataFrame ([[101,'Alice',40000,2017],
               [102,'Bob',  24000, 2017], 
               [103,'Charles',31000,2017]], columns = ['empID','name','salary','year'])
```

```
#:>    empID     name  salary  year
#:> 0    101    Alice   40000  2017
#:> 1    102      Bob   24000  2017
#:> 2    103  Charles   31000  2017
```


**Specify Row Label during Creation**


```python
pd.DataFrame ([[101,'Alice',40000,2017],
               [102,'Bob',  24000, 2017], 
               [103,'Charles',31000,2017]], index   = ['r1','r2','r3'] )
```

```
#:>       0        1      2     3
#:> r1  101    Alice  40000  2017
#:> r2  102      Bob  24000  2017
#:> r3  103  Charles  31000  2017
```


#### From Row Oriented Data (List of Dictionary)
```
DataFrame( [dict1, dict2, dict3] )
DataFrame( [row_list1, row_list2, row_list3], column=np.arrange )
DataFrame( [row_list1, row_list2, row_list3], index=row_label_list )

by default,keys will become collumn names, and autosorted
```


**Default Column Name Follow Dictionary Key**  
Note missing info as NaN


```python
pd.DataFrame ([{"name":"Yong", "id":1,"zkey":101},{"name":"Gan","id":2}])
```

```
#:>    name  id   zkey
#:> 0  Yong   1  101.0
#:> 1   Gan   2    NaN
```


**Specify Index**


```python
pd.DataFrame ([{"name":"Yong", "id":'wd1'},{"name":"Gan","id":'wd2'}], 
             index = (1,2))
```

```
#:>    name   id
#:> 1  Yong  wd1
#:> 2   Gan  wd2
```


**Specify Column Header during Creation**, can acts as column filter and manual arrangement  
Note missing info as NaN


```python
pd.DataFrame ([{"name":"Yong", "id":1, "zkey":101},{"name":"Gan","id":2}], 
              columns=("name","id","zkey"))
```

```
#:>    name  id   zkey
#:> 0  Yong   1  101.0
#:> 1   Gan   2    NaN
```


#### From Column Oriented Data
Create from **Dictrionary of List**
```
DataFrame(  { 'column1': list1,
              'column2': list2,
              'column3': list3 } , 
              index    = row_label_list, 
              columns  = column_list)
              
```
By default, DataFrame will **arrange the columns alphabetically**, unless **columns** is specified


**Default Row Label**


```python
data = {'empID':  [100,      101,    102,      103,     104],
        'year':   [2017,     2017,   2017,      2018,    2018],
        'salary': [40000,    24000,  31000,     20000,   30000],
        'name':   ['Alice', 'Bob',  'Charles', 'David', 'Eric']}
pd.DataFrame(data)
```

```
#:>    empID  year  salary     name
#:> 0    100  2017   40000    Alice
#:> 1    101  2017   24000      Bob
#:> 2    102  2017   31000  Charles
#:> 3    103  2018   20000    David
#:> 4    104  2018   30000     Eric
```


**Specify Row Label during Creation**


```python
data = {'empID':  [100,      101,    102,      103,     104],
        'name':   ['Alice', 'Bob',  'Charles', 'David', 'Eric'],
        'year':   [2017,     2017,   2017,      2018,    2018],
        'salary': [40000,    24000,  31000,     20000,   30000] }
pd.DataFrame (data, index=['r1','r2','r3','r4','r5'])
```

```
#:>     empID     name  year  salary
#:> r1    100    Alice  2017   40000
#:> r2    101      Bob  2017   24000
#:> r3    102  Charles  2017   31000
#:> r4    103    David  2018   20000
#:> r5    104     Eric  2018   30000
```


**Manualy Choose Columns and Arrangement**


```python
data = {'empID':  [100,      101,    102,      103,     104],
        'name':   ['Alice', 'Bob',  'Charles', 'David', 'Eric'],
        'year':   [2017,     2017,   2017,      2018,    2018],
        'salary': [40000,    24000,  31000,     20000,   30000] }
pd.DataFrame (data, columns=('empID','name','salary'), index=['r1','r2','r3','r4','r5'])
```

```
#:>     empID     name  salary
#:> r1    100    Alice   40000
#:> r2    101      Bob   24000
#:> r3    102  Charles   31000
#:> r4    103    David   20000
#:> r5    104     Eric   30000
```


### Operator

#### The Data

Two dataframe is created, each with 3 columns and 3 rows. However, only two **matching column and row** names We shall notice that the operator will perform cell-wise, **honoring the row/column name**.


```python
df1 = pd.DataFrame(data=
  {'idx': ['row1','row2','row3'],
   'x': [10, 20, 30],
   'y': [1,2,3],
   'z': [0.1, 0.2, 0.3]}).set_index('idx')
   
df2 = pd.DataFrame(data=
  {'idx': ['row1','row2','row4'],
   'x': [13, 23, 33],
   'z': [0.1, 0.2, 0.3],
   'k': [11,21,31]
   }).set_index('idx')
   
print( df1, '\n\n', df2)
```

```
#:>        x  y    z
#:> idx             
#:> row1  10  1  0.1
#:> row2  20  2  0.2
#:> row3  30  3  0.3 
#:> 
#:>         x    z   k
#:> idx              
#:> row1  13  0.1  11
#:> row2  23  0.2  21
#:> row4  33  0.3  31
```

#### Addition

**Adding Two DataFrame**

Using `+` operator, non-matching row/column names will result in **NA**. However, when using function **`add`**, none matching cells can be assumed as with a value.


```python
r1 = df1 + df2
r2 = df1.add(df2,fill_value=1000)

print( r1, '\n\n', r2)
```

```
#:>        k     x   y    z
#:> idx                    
#:> row1 NaN  23.0 NaN  0.2
#:> row2 NaN  43.0 NaN  0.4
#:> row3 NaN   NaN NaN  NaN
#:> row4 NaN   NaN NaN  NaN 
#:> 
#:>             k       x       y       z
#:> idx                                 
#:> row1  1011.0    23.0  1001.0     0.2
#:> row2  1021.0    43.0  1002.0     0.4
#:> row3     NaN  1030.0  1003.0  1000.3
#:> row4  1031.0  1033.0     NaN  1000.3
```

**Adding Series and DataFrame**

Specify the **appropriate `axis`** depending on the orientation of the series data. Column and Row names are respected in this operation. However, `fill_value` is **not applicable** when apply on Series.  

Note that columns in Series that are not found in dataframe, will still be created in the result. This is similar behaviour as operating Dataframe with Dataframe.


```python
s3 = pd.Series([1,1,1], index=['row1','row2','row4'])
s4 = pd.Series([3,3,3], index=['x','y','s'])

print('Original Data:\n',df1,'\n\n',
      'Add By Rows: \n', df1.add(s3, axis=0), '\n\n',
      'Add By Columns: \n', df1.add(s4, axis=1))
```

```
#:> Original Data:
#:>         x  y    z
#:> idx             
#:> row1  10  1  0.1
#:> row2  20  2  0.2
#:> row3  30  3  0.3 
#:> 
#:>  Add By Rows: 
#:>           x    y    z
#:> row1  11.0  2.0  1.1
#:> row2  21.0  3.0  1.2
#:> row3   NaN  NaN  NaN
#:> row4   NaN  NaN  NaN 
#:> 
#:>  Add By Columns: 
#:>         s     x    y   z
#:> idx                    
#:> row1 NaN  13.0  4.0 NaN
#:> row2 NaN  23.0  5.0 NaN
#:> row3 NaN  33.0  6.0 NaN
```

#### Substraction


```python
r1 = df2 - df1
r2 = df2.sub(df1,fill_value=1000)

print( r1, '\n\n', r2)
```

```
#:>        k    x   y    z
#:> idx                   
#:> row1 NaN  3.0 NaN  0.0
#:> row2 NaN  3.0 NaN  0.0
#:> row3 NaN  NaN NaN  NaN
#:> row4 NaN  NaN NaN  NaN 
#:> 
#:>            k      x      y      z
#:> idx                             
#:> row1 -989.0    3.0  999.0    0.0
#:> row2 -979.0    3.0  998.0    0.0
#:> row3    NaN  970.0  997.0  999.7
#:> row4 -969.0 -967.0    NaN -999.7
```

```python
r3 = (r2>0) & (r2<=3)
print( 'Original Data: \n', r2, '\n\n',
       'Logical Operator:\n', r3)
```

```
#:> Original Data: 
#:>            k      x      y      z
#:> idx                             
#:> row1 -989.0    3.0  999.0    0.0
#:> row2 -979.0    3.0  998.0    0.0
#:> row3    NaN  970.0  997.0  999.7
#:> row4 -969.0 -967.0    NaN -999.7 
#:> 
#:>  Logical Operator:
#:>            k      x      y      z
#:> idx                             
#:> row1  False   True  False  False
#:> row2  False   True  False  False
#:> row3  False  False  False  False
#:> row4  False  False  False  False
```


### Attributes


```python
df = pd.DataFrame(
    { 'empID':  [100,      101,    102,      103,     104],
      'year1':   [2017,     2017,   2017,      2018,    2018],
      'name':   ['Alice',  'Bob',  'Charles','David', 'Eric'],
      'year2':   [2001,     1907,   2003,      1998,    2011],
      'salary': [40000,    24000,  31000,     20000,   30000]},
    columns = ['year1','salary','year2','empID','name'])
```


#### Dimensions


```python
df.shape
```

```
#:> (5, 5)
```


#### Index


```python
df.index
```

```
#:> RangeIndex(start=0, stop=5, step=1)
```

**Underlying Index values are numpy object**


```python
df.index.values
```

```
#:> array([0, 1, 2, 3, 4])
```

#### Columns


```python
df.columns
```

```
#:> Index(['year1', 'salary', 'year2', 'empID', 'name'], dtype='object')
```

**Underlying Index values are numpy object**


```python
df.columns.values
```

```
#:> array(['year1', 'salary', 'year2', 'empID', 'name'], dtype=object)
```

#### Values

**Underlying Column values are numpy object**


```python
df.values
```

```
#:> array([[2017, 40000, 2001, 100, 'Alice'],
#:>        [2017, 24000, 1907, 101, 'Bob'],
#:>        [2017, 31000, 2003, 102, 'Charles'],
#:>        [2018, 20000, 1998, 103, 'David'],
#:>        [2018, 30000, 2011, 104, 'Eric']], dtype=object)
```

### Index Manipulation
**index** and **row label** are used interchangeably in this book


#### Sample Data
Columns are intentionaly ordered in a messy way 


```python
df = pd.DataFrame(
    { 'empID':  [100,      101,    102,      103,     104],
      'year1':   [2017,     2017,   2017,      2018,    2018],
      'name':   ['Alice',  'Bob',  'Charles','David', 'Eric'],
      'year2':   [2001,     1907,   2003,      1998,    2011],
      'salary': [40000,    24000,  31000,     20000,   30000]},
    columns = ['year1','salary','year2','empID','name'])

print (df, '\n')
```

```
#:>    year1  salary  year2  empID     name
#:> 0   2017   40000   2001    100    Alice
#:> 1   2017   24000   1907    101      Bob
#:> 2   2017   31000   2003    102  Charles
#:> 3   2018   20000   1998    103    David
#:> 4   2018   30000   2011    104     Eric
```

```python
print (df.index)
```

```
#:> RangeIndex(start=0, stop=5, step=1)
```

#### Convert Column To Index
```
set_index('column_name', inplace=False)
```
**inplace=True** means don't create a new dataframe. Modify existing dataframe    
**inplace=False** means return a new dataframe


```python
print(df)
```

```
#:>    year1  salary  year2  empID     name
#:> 0   2017   40000   2001    100    Alice
#:> 1   2017   24000   1907    101      Bob
#:> 2   2017   31000   2003    102  Charles
#:> 3   2018   20000   1998    103    David
#:> 4   2018   30000   2011    104     Eric
```

```python
print(df.index,'\n')
```

```
#:> RangeIndex(start=0, stop=5, step=1)
```

```python
df.set_index('empID',inplace=True) 
print(df)
```

```
#:>        year1  salary  year2     name
#:> empID                               
#:> 100     2017   40000   2001    Alice
#:> 101     2017   24000   1907      Bob
#:> 102     2017   31000   2003  Charles
#:> 103     2018   20000   1998    David
#:> 104     2018   30000   2011     Eric
```

```python
print(df.index) # return new DataFrameObj
```

```
#:> Int64Index([100, 101, 102, 103, 104], dtype='int64', name='empID')
```

#### Convert Index Back To Column
- Reseting index will resequence the index as 0,1,2 etc  
- Old index column will be converted back as normal column  
- Operation support inplace** option


```python
df.reset_index(inplace=True)
print(df)
```

```
#:>    empID  year1  salary  year2     name
#:> 0    100   2017   40000   2001    Alice
#:> 1    101   2017   24000   1907      Bob
#:> 2    102   2017   31000   2003  Charles
#:> 3    103   2018   20000   1998    David
#:> 4    104   2018   30000   2011     Eric
```

#### Updating Index ( .index= )
**Warning:**  
- Updating index **doesn't reorder** the data sequence  
- Number of elements before and after reorder must match, otherwise **error**  
- Same label are **allowed to repeat**
- Not reversable


```python
df.index = [101, 101, 101, 102, 103]
df
```

```
#:>      empID  year1  salary  year2     name
#:> 101    100   2017   40000   2001    Alice
#:> 101    101   2017   24000   1907      Bob
#:> 101    102   2017   31000   2003  Charles
#:> 102    103   2018   20000   1998    David
#:> 103    104   2018   30000   2011     Eric
```

#### Reordering Index (. reindex )
- Reindex will **reorder** the rows according to new index  
- The operation is not reversable

**Start from this original dataframe**


```python
df.index = [101,102,103,104,105]
df
```

```
#:>      empID  year1  salary  year2     name
#:> 101    100   2017   40000   2001    Alice
#:> 102    101   2017   24000   1907      Bob
#:> 103    102   2017   31000   2003  Charles
#:> 104    103   2018   20000   1998    David
#:> 105    104   2018   30000   2011     Eric
```
**Change the order of Index**, always return a new dataframe

```python
df.reindex([103,102,101,104,105])
```

```
#:>      empID  year1  salary  year2     name
#:> 103    102   2017   31000   2003  Charles
#:> 102    101   2017   24000   1907      Bob
#:> 101    100   2017   40000   2001    Alice
#:> 104    103   2018   20000   1998    David
#:> 105    104   2018   30000   2011     Eric
```
#### Rename Index

- Example below renamed the axis of both columns and rows  
- Use `axis=0` for row index, use `axis=1` for column index


```python
df.rename_axis('super_id').rename_axis('my_cols', axis=1)
```

```
#:> my_cols   empID  year1  salary  year2     name
#:> super_id                                      
#:> 101         100   2017   40000   2001    Alice
#:> 102         101   2017   24000   1907      Bob
#:> 103         102   2017   31000   2003  Charles
#:> 104         103   2018   20000   1998    David
#:> 105         104   2018   30000   2011     Eric
```
### Subsetting Columns

**Select Single Column** Return **Series**
```
dataframe.columnName               # single column, name based, return Series object
dataframe[ single_col_name ]       # single column, name based, return Series object
dataframe[ [single_col_name] ]     # single column, name based, return DataFrame object
```

**Select Single/Multiple Columns** Return **DataFrame**
```
dataframe[ single/list_of_col_names ]                       # name based, return Dataframe object
dataframe.loc[ : , single_col_name  ]  # single column, series
dataframe.loc[ : , col_name_list    ]  # multiple columns, dataframe
dataframe.loc[ : , col_name_ranage  ]  # multiple columns, dataframe

dataframe.iloc[ : , col_number      ]  # single column, series
dataframe.iloc[ : , col_number_list ]  # multiple columns, dataframe
dataframe.iloc[ : , number_range    ]  # multiple columns, dataframe
```

#### Select Single Column

Selecting single column always return as **`panda::Series`**


```python
print( 
  df.name,           '\n\n',
  df['name'],        '\n\n',
  df.loc[:, 'name'], '\n\n',
  df.iloc[:, 3])
```

```
#:> 101      Alice
#:> 102        Bob
#:> 103    Charles
#:> 104      David
#:> 105       Eric
#:> Name: name, dtype: object 
#:> 
#:>  101      Alice
#:> 102        Bob
#:> 103    Charles
#:> 104      David
#:> 105       Eric
#:> Name: name, dtype: object 
#:> 
#:>  101      Alice
#:> 102        Bob
#:> 103    Charles
#:> 104      David
#:> 105       Eric
#:> Name: name, dtype: object 
#:> 
#:>  101    2001
#:> 102    1907
#:> 103    2003
#:> 104    1998
#:> 105    2011
#:> Name: year2, dtype: int64
```

#### Select Multiple Columns

Multiple columns return as **panda::Dataframe** object`  

Example below returns DataFrame with Single Column

```python
df[['name']]  # return one column dataframe
```

```
#:>         name
#:> 101    Alice
#:> 102      Bob
#:> 103  Charles
#:> 104    David
#:> 105     Eric
```


```python
print(
  df[['name','year1']]       ,'\n\n',
  df.loc[:,['name','year1']])
```

```
#:>         name  year1
#:> 101    Alice   2017
#:> 102      Bob   2017
#:> 103  Charles   2017
#:> 104    David   2018
#:> 105     Eric   2018 
#:> 
#:>          name  year1
#:> 101    Alice   2017
#:> 102      Bob   2017
#:> 103  Charles   2017
#:> 104    David   2018
#:> 105     Eric   2018
```

**Select Range of Columns**


```python
print(
  df.loc [ : , 'year1':'year2'], '\n\n',
  df.iloc[ : , [0,3]]           ,'\n\n',
  df.iloc[ : , 0:3]
)
```

```
#:>      year1  salary  year2
#:> 101   2017   40000   2001
#:> 102   2017   24000   1907
#:> 103   2017   31000   2003
#:> 104   2018   20000   1998
#:> 105   2018   30000   2011 
#:> 
#:>       empID  year2
#:> 101    100   2001
#:> 102    101   1907
#:> 103    102   2003
#:> 104    103   1998
#:> 105    104   2011 
#:> 
#:>       empID  year1  salary
#:> 101    100   2017   40000
#:> 102    101   2017   24000
#:> 103    102   2017   31000
#:> 104    103   2018   20000
#:> 105    104   2018   30000
```

#### By Column Name (.filter)

`.filter(items=None, like=None, regex=None, axis=1)`

**like = Substring Matches**  


```python
df.filter( like='year',  axis='columns')  ## or axis = 1
```

```
#:>      year1  year2
#:> 101   2017   2001
#:> 102   2017   1907
#:> 103   2017   2003
#:> 104   2018   1998
#:> 105   2018   2011
```

**items = list of column names**


```python
df.filter( items=('year1','year2'),  axis=1)  ## or axis = 1
```

```
#:>      year1  year2
#:> 101   2017   2001
#:> 102   2017   1907
#:> 103   2017   2003
#:> 104   2018   1998
#:> 105   2018   2011
```

**regex = Regular Expression**   
Select column names that contain integer


```python
df.filter(regex='\d')  ## default axis=1 if DataFrame
```

```
#:>      year1  year2
#:> 101   2017   2001
#:> 102   2017   1907
#:> 103   2017   2003
#:> 104   2018   1998
#:> 105   2018   2011
```

#### Data Type (.select_dtypes)

```
df.select_dtypes(include=None, exclude=None)
```
Always return **panda::DataFrame**, even though only single column matches.  
Allowed types are:
- number (integer and float)  
- integer / float 
- datetime  
- timedelta  
- category  


```python
# error: no attribute get_dtype_counts
df.get_dtype_counts()
```


```python
df.select_dtypes(exclude='number')
```

```
#:>         name
#:> 101    Alice
#:> 102      Bob
#:> 103  Charles
#:> 104    David
#:> 105     Eric
```


```python
df.select_dtypes(exclude=('number','object'))
```

```
#:> Empty DataFrame
#:> Columns: []
#:> Index: [101, 102, 103, 104, 105]
```


### Column Manipulation

#### Sample Data


```python
df
```

```
#:>      empID  year1  salary  year2     name
#:> 101    100   2017   40000   2001    Alice
#:> 102    101   2017   24000   1907      Bob
#:> 103    102   2017   31000   2003  Charles
#:> 104    103   2018   20000   1998    David
#:> 105    104   2018   30000   2011     Eric
```


#### Renaming Columns


**Method 1 : Rename All Columns (.columns =)**  
- Construct the new column names, **check if there is no missing** column names   
- **Missing columns** will return **error**  
- Direct Assignment to column property result in change to dataframe


```python
new_columns = ['year.1','salary','year.2','empID','name']
df.columns = new_columns
df.head(2)
```

```
#:>      year.1  salary  year.2  empID   name
#:> 101     100    2017   40000   2001  Alice
#:> 102     101    2017   24000   1907    Bob
```


**Method 2 : Renaming Specific Column (.rename (columns=) )** 
- Change column name through **rename** function  
- Support **inpalce** option for original dataframe change  
- Missing column is OK


```python
df.rename( columns={'year.1':'year1', 'year.2':'year2'}, inplace=True)
df.head(2)
```

```
#:>      year1  salary  year2  empID   name
#:> 101    100    2017  40000   2001  Alice
#:> 102    101    2017  24000   1907    Bob
```


#### Reordering Columns
Always return a new dataframe.  There is **no inplace option** for reordering columns  

**Method 1 - reindex(columns = )**  
- **reindex** may sounds like operation on row labels, but it works  
- **Missmatch** column names will result in **NA** for the unfound column


```python
new_colorder = [ 'empID', 'name', 'salary', 'year1', 'year2']
df.reindex(columns = new_colorder).head(2)
```

```
#:>      empID   name  salary  year1  year2
#:> 101   2001  Alice    2017    100  40000
#:> 102   1907    Bob    2017    101  24000
```


**Method 2 - [ ] notation**  
- **Missmatch** column will result in **ERROR**  


```python
new_colorder = [ 'empID', 'name', 'salary', 'year1', 'year2']
df[new_colorder]
```

```
#:>      empID     name  salary  year1  year2
#:> 101   2001    Alice    2017    100  40000
#:> 102   1907      Bob    2017    101  24000
#:> 103   2003  Charles    2017    102  31000
#:> 104   1998    David    2018    103  20000
#:> 105   2011     Eric    2018    104  30000
```


#### Duplicating or Replacing Column
- **New Column** will be created instantly using **[] notation**  
- **DO NOT USE dot Notation** because it is view only attribute


```python
df['year3'] = df.year1
df
```

```
#:>      year1  salary  year2  empID     name  year3
#:> 101    100    2017  40000   2001    Alice    100
#:> 102    101    2017  24000   1907      Bob    101
#:> 103    102    2017  31000   2003  Charles    102
#:> 104    103    2018  20000   1998    David    103
#:> 105    104    2018  30000   2011     Eric    104
```


#### Dropping Columns (.drop)
```
dataframe.drop( columns='column_name',    inplace=True/False)   # delete single column
dataframe.drop( columns=list_of_colnames, inplace=True/False)   # delete multiple column

dataframe.drop( index='row_label',         inplace=True/False)   # delete single row
dataframe.drop( index= list_of_row_labels, inplace=True/False)   # delete multiple rows

```
**inplace=True** means column will be deleted from original dataframe. **Default is False**, which return a copy of dataframe  


**By Column Name(s)**


```python
df.drop( columns='year1') # drop single column
```

```
#:>      salary  year2  empID     name  year3
#:> 101    2017  40000   2001    Alice    100
#:> 102    2017  24000   1907      Bob    101
#:> 103    2017  31000   2003  Charles    102
#:> 104    2018  20000   1998    David    103
#:> 105    2018  30000   2011     Eric    104
```


```python
df.drop(columns=['year2','year3'])  # drop multiple columns
```

```
#:>      year1  salary  empID     name
#:> 101    100    2017   2001    Alice
#:> 102    101    2017   1907      Bob
#:> 103    102    2017   2003  Charles
#:> 104    103    2018   1998    David
#:> 105    104    2018   2011     Eric
```


**By Column Number(s)**   
Use dataframe.columns to produce interim list of column names


```python
df.drop( columns=df.columns[[3,4,5]] )   # delete columns by list of column number
```

```
#:>      year1  salary  year2
#:> 101    100    2017  40000
#:> 102    101    2017  24000
#:> 103    102    2017  31000
#:> 104    103    2018  20000
#:> 105    104    2018  30000
```


```python
df.drop( columns=df.columns[3:6] )       # delete columns by range of column number
```

```
#:>      year1  salary  year2
#:> 101    100    2017  40000
#:> 102    101    2017  24000
#:> 103    102    2017  31000
#:> 104    103    2018  20000
#:> 105    104    2018  30000
```


### Subsetting Rows
```
dataframe.loc[ row_label       ]  # return series, single row
dataframe.loc[ row_label_list  ]  # multiple rows
dataframe.loc[ boolean_list    ]  # multiple rows

dataframe.iloc[ row_number       ]  # return series, single row
dataframe.iloc[ row_number_list  ]  # multiple rows
dataframe.iloc[ number_range     ]  # multiple rows

dataframe.sample(frac=)                                        # frac = 0.6 means sampling 60% of rows randomly
```

#### Sample Data


```python
df = pd.DataFrame(
    { 'empID':  [100,      101,    102,      103,     104],
      'year1':   [2017,     2017,   2017,      2018,    2018],
      'name':   ['Alice',  'Bob',  'Charles','David', 'Eric'],
      'year2':   [2001,     1907,   2003,      1998,    2011],
      'salary': [40000,    24000,  31000,     20000,   30000]},
    columns = ['year1','salary','year2','empID','name']).set_index(['empID'])
df
```

```
#:>        year1  salary  year2     name
#:> empID                               
#:> 100     2017   40000   2001    Alice
#:> 101     2017   24000   1907      Bob
#:> 102     2017   31000   2003  Charles
#:> 103     2018   20000   1998    David
#:> 104     2018   30000   2011     Eric
```


#### By Index or Boolean


**Single Index** return Series



```python
df.loc[101]         # by single row label, return series
```

```
#:> year1      2017
#:> salary    24000
#:> year2      1907
#:> name        Bob
#:> Name: 101, dtype: object
```


**List or Range of Indexes** returns DataFrame


```python
df.loc[ [100,103] ]  # by multiple row labels
```

```
#:>        year1  salary  year2   name
#:> empID                             
#:> 100     2017   40000   2001  Alice
#:> 103     2018   20000   1998  David
```


```python
df.loc[  100:103  ]  # by range of row labels
```

```
#:>        year1  salary  year2     name
#:> empID                               
#:> 100     2017   40000   2001    Alice
#:> 101     2017   24000   1907      Bob
#:> 102     2017   31000   2003  Charles
#:> 103     2018   20000   1998    David
```


**List of Boolean** returns DataFrame


```python
criteria = (df.salary > 30000) & (df.year1==2017)
print (criteria)
```

```
#:> empID
#:> 100     True
#:> 101    False
#:> 102     True
#:> 103    False
#:> 104    False
#:> dtype: bool
```

```python
print (df.loc[criteria])
```

```
#:>        year1  salary  year2     name
#:> empID                               
#:> 100     2017   40000   2001    Alice
#:> 102     2017   31000   2003  Charles
```


#### By Row Number
**Single Row** return Series


```python
df.iloc[1]  # by single row number
```

```
#:> year1      2017
#:> salary    24000
#:> year2      1907
#:> name        Bob
#:> Name: 101, dtype: object
```


Multiple rows **returned as dataframe** object


```python
df.iloc[ [0,3] ]    # by row numbers
```

```
#:>        year1  salary  year2   name
#:> empID                             
#:> 100     2017   40000   2001  Alice
#:> 103     2018   20000   1998  David
```


```python
df.iloc[  0:3  ]    # by row number range
```

```
#:>        year1  salary  year2     name
#:> empID                               
#:> 100     2017   40000   2001    Alice
#:> 101     2017   24000   1907      Bob
#:> 102     2017   31000   2003  Charles
```

#### By Expression (.query)

`.query(expr, inplace=False)`


```python
df.query('salary<=31000 and year1 == 2017')
```

```
#:>        year1  salary  year2     name
#:> empID                               
#:> 101     2017   24000   1907      Bob
#:> 102     2017   31000   2003  Charles
```

#### By Random (.sample)


```python
np.random.seed(15)
df.sample(frac=0.6) #randomly pick 60% of rows, without replacement
```

```
#:>        year1  salary  year2     name
#:> empID                               
#:> 102     2017   31000   2003  Charles
#:> 103     2018   20000   1998    David
#:> 104     2018   30000   2011     Eric
```

### Row Manipulation

#### Sample Data

#### Appending Rows

Appending rows is more computaional intensive then concatenate.
Item can be added as single item or multi-items (list form)

**Append From Another DataFrame**

- When `ignore_index=True`, pandas will **drop the original Index** and recreate with 0,1,2,3...  
- It is recommended to ignore index IF the data source index is **not unique**.  
- New columns will be added in the result, with NaN on original dataframe.   


```python
my_df = pd.DataFrame(
          data= {'Id':   [10,20,30],
                 'Name': ['Aaa','Bbb','Ccc']})
#                 .set_index('Id')
                 
my_df_new = pd.DataFrame(
            data= {'Id':   [40,50],
                   'Name': ['Ddd','Eee'],
                   'Age':  [12,13]})  
                   #.set_index('Id')
                   
my_df_append  = my_df.append(my_df_new, ignore_index=False)
my_df_noindex = my_df.append(my_df_new, ignore_index=True)

print("Original DataFrame:\n", my_df,
      "\n\nTo Be Appended DataFrame:\n", my_df_new,
      "\n\nAppended DataFrame (index maintained):\n", my_df_append,
      "\n\nAppended DataFrame (index ignored):\n", my_df_noindex)
```

```
#:> Original DataFrame:
#:>     Id Name
#:> 0  10  Aaa
#:> 1  20  Bbb
#:> 2  30  Ccc 
#:> 
#:> To Be Appended DataFrame:
#:>     Id Name  Age
#:> 0  40  Ddd   12
#:> 1  50  Eee   13 
#:> 
#:> Appended DataFrame (index maintained):
#:>     Id Name   Age
#:> 0  10  Aaa   NaN
#:> 1  20  Bbb   NaN
#:> 2  30  Ccc   NaN
#:> 0  40  Ddd  12.0
#:> 1  50  Eee  13.0 
#:> 
#:> Appended DataFrame (index ignored):
#:>     Id Name   Age
#:> 0  10  Aaa   NaN
#:> 1  20  Bbb   NaN
#:> 2  30  Ccc   NaN
#:> 3  40  Ddd  12.0
#:> 4  50  Eee  13.0
```

**Append From Dictionary**


```python
my_df = pd.DataFrame(
          data= {'Id':   [10,20,30],
                 'Name': ['Aaa','Bbb','Ccc']})  \
                 .set_index('Id')

new_item1 = {'Id':40, 'Name': 'Ddd'}
new_item2 = {'Id':50, 'Name': 'Eee'}
new_item3 = {'Id':60, 'Name': 'Fff'}

my_df_one   = my_df.append( new_item1, ignore_index=True )
my_df_multi = my_df.append( [new_item2, new_item3], ignore_index=True )

print("Original DataFrame:\n", my_df,
      "\n\nAdd One Item (index ignored):\n", my_df_one,
      "\n\nAdd Multi Item (index ignored):\n", my_df_multi)
```

```
#:> Original DataFrame:
#:>     Name
#:> Id     
#:> 10  Aaa
#:> 20  Bbb
#:> 30  Ccc 
#:> 
#:> Add One Item (index ignored):
#:>    Name    Id
#:> 0  Aaa   NaN
#:> 1  Bbb   NaN
#:> 2  Ccc   NaN
#:> 3  Ddd  40.0 
#:> 
#:> Add Multi Item (index ignored):
#:>    Name    Id
#:> 0  Aaa   NaN
#:> 1  Bbb   NaN
#:> 2  Ccc   NaN
#:> 3  Eee  50.0
#:> 4  Fff  60.0
```


**Appending `None` items(s)**

Adding **single None** item has **no effect** (nothing added).   
Adding **None in list form (multiple items)**  creates rows with None.  
`ignore_index` is not important here.


```python
single_none = my_df.append( None  )
multi_none  = my_df.append( [None])

print("Original DataFrame:\n", my_df,
      "\n\nAdd One None (index ignored):\n", single_none,
      "\n\nAdd List of None (index ignored):\n", multi_none)
```

```
#:> Original DataFrame:
#:>     Name
#:> Id     
#:> 10  Aaa
#:> 20  Bbb
#:> 30  Ccc 
#:> 
#:> Add One None (index ignored):
#:>     Name
#:> Id     
#:> 10  Aaa
#:> 20  Bbb
#:> 30  Ccc 
#:> 
#:> Add List of None (index ignored):
#:>     Name     0
#:> 10  Aaa   NaN
#:> 20  Bbb   NaN
#:> 30  Ccc   NaN
#:> 0   NaN  None
```

**Appending Items Containing None** results in **ERROR**


```python
# error
my_df.append( [new_item1, None] )
```


#### Concatenate Rows





#### Dropping Rows (.drop)
```.drop(labels=None, axis=0, index=None, columns=None, level=None, inplace=False, errors='raise')```

**By Row Label(s)**


```python
df.drop(index=100)       # single row
```

```
#:>        year1  salary  year2     name
#:> empID                               
#:> 101     2017   24000   1907      Bob
#:> 102     2017   31000   2003  Charles
#:> 103     2018   20000   1998    David
#:> 104     2018   30000   2011     Eric
```


```python
df.drop(index=[100,103])   # multiple rows
```

```
#:>        year1  salary  year2     name
#:> empID                               
#:> 101     2017   24000   1907      Bob
#:> 102     2017   31000   2003  Charles
#:> 104     2018   30000   2011     Eric
```


### Slicing


#### Sample Data


```python
df
```

```
#:>        year1  salary  year2     name
#:> empID                               
#:> 100     2017   40000   2001    Alice
#:> 101     2017   24000   1907      Bob
#:> 102     2017   31000   2003  Charles
#:> 103     2018   20000   1998    David
#:> 104     2018   30000   2011     Eric
```


#### Getting One Cell  
**By Row Label and Column Name (loc)**


```
dataframe.loc [ row_label , col_name   ]    # by row label and column names
dataframe.loc [ bool_list , col_name   ]    # by row label and column names
dataframe.iloc[ row_number, col_number ]    # by row and column number
```


```python
print (df.loc[100,'year1'])
```

```
#:> 2017
```


**By Row Number and Column Number (iloc)**


```python
print (df.iloc[1,2])
```

```
#:> 1907
```


#### Getting Multiple Cells
Specify rows and columns (by individual or range)

```
dataframe.loc [ list/range_of_row_labels , list/range_col_names   ]    # by row label and column names
dataframe.iloc[ list/range_row_numbers,    list/range_col_numbers ]    # by row number
```


**By Index and Column Name (loc)**


```python
print (df.loc[ [101,103], ['name','year1'] ], '\n')  # by list of row label and column names
```

```
#:>         name  year1
#:> empID              
#:> 101      Bob   2017
#:> 103    David   2018
```

```python
print (df.loc[  101:104 ,  'year1':'year2'  ], '\n')  # by range of row label and column names
```

```
#:>        year1  salary  year2
#:> empID                      
#:> 101     2017   24000   1907
#:> 102     2017   31000   2003
#:> 103     2018   20000   1998
#:> 104     2018   30000   2011
```


**By Boolean Row and Column Names (loc)**


```python
df.loc[df.year1==2017, 'year1':'year2']
```

```
#:>        year1  salary  year2
#:> empID                      
#:> 100     2017   40000   2001
#:> 101     2017   24000   1907
#:> 102     2017   31000   2003
```


**By Row and Column Number (iloc)**


```python
print (df.iloc[ [1,4], [0,3]],'\n' )   # by individual rows/columns
```

```
#:>        year1  name
#:> empID             
#:> 101     2017   Bob
#:> 104     2018  Eric
```

```python
print (df.iloc[  1:4 ,  0:3], '\n')    # by range
```

```
#:>        year1  salary  year2
#:> empID                      
#:> 101     2017   24000   1907
#:> 102     2017   31000   2003
#:> 103     2018   20000   1998
```


### Chained Indexing


**Chained Index** Method creates a copy of dataframe, any modification of data on original dataframe does not affect the copy  
```
dataframe.loc  [...]  [...]
dataframe.iloc [...]  [...]
```
Suggesting, **never use** chain indexing


```python
df = pd.DataFrame(
    { 'empID':  [100,      101,    102,      103,     104],
      'year1':   [2017,     2017,   2017,      2018,    2018],
      'name':   ['Alice',  'Bob',  'Charles','David', 'Eric'],
      'year2':   [2001,     1907,   2003,      1998,    2011],
      'salary': [40000,    24000,  31000,     20000,   30000]},
    columns = ['year1','salary','year2','empID','name']).set_index(['empID'])
df
```

```
#:>        year1  salary  year2     name
#:> empID                               
#:> 100     2017   40000   2001    Alice
#:> 101     2017   24000   1907      Bob
#:> 102     2017   31000   2003  Charles
#:> 103     2018   20000   1998    David
#:> 104     2018   30000   2011     Eric
```


```python
df.loc[100]['year'] =2000
```

```
#:> /home/msfz751/anaconda3/envs/python_book/bin/python:1: SettingWithCopyWarning: 
#:> A value is trying to be set on a copy of a slice from a DataFrame
#:> 
#:> See the caveats in the documentation: https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html#returning-a-view-versus-a-copy
#:> /home/msfz751/.local/lib/python3.7/site-packages/pandas/core/indexing.py:670: SettingWithCopyWarning: 
#:> A value is trying to be set on a copy of a slice from a DataFrame
#:> 
#:> See the caveats in the documentation: https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html#returning-a-view-versus-a-copy
#:>   iloc._setitem_with_indexer(indexer, value)
```

```python
df  ## notice row label 100 had not been updated, because data was updated on a copy due to chain indexing
```

```
#:>        year1  salary  year2     name
#:> empID                               
#:> 100     2017   40000   2001    Alice
#:> 101     2017   24000   1907      Bob
#:> 102     2017   31000   2003  Charles
#:> 103     2018   20000   1998    David
#:> 104     2018   30000   2011     Eric
```

### Cell Value Replacement

Slicing deals with square cells selection. Use `mask` or `where` to select specific cell(s). These function respect column and row names.

#### `mask()`

`mask()` replace value with `other=` when condition is met. Column and row name is **respected**


```python
ori = pd.DataFrame(data={
     'x': [1,4,7],
     'y': [2,5,8],
     'z': [3,6,9]}, index=[
     'row1','row2','row3'])

df_big = (ori >4)[['y','x','z']]
resul1 = ori.mask(df_big, other=999)

print('Original DF: \n', ori, '\n\n',
      'Big DF : \n', df_big, '\n\n',
      'Result : \n', resul1)
```

```
#:> Original DF: 
#:>        x  y  z
#:> row1  1  2  3
#:> row2  4  5  6
#:> row3  7  8  9 
#:> 
#:>  Big DF : 
#:>            y      x      z
#:> row1  False  False  False
#:> row2   True  False   True
#:> row3   True   True   True 
#:> 
#:>  Result : 
#:>          x    y    z
#:> row1    1    2    3
#:> row2    4  999  999
#:> row3  999  999  999
```

#### `where()`

This is reverse of `mask()`, it will repalce value when the **condition is False**.


```python
df.where(cond=df_big)
```

```
#:>        year1  salary  year2 name
#:> empID                           
#:> 100      NaN     NaN    NaN  NaN
#:> 101      NaN     NaN    NaN  NaN
#:> 102      NaN     NaN    NaN  NaN
#:> 103      NaN     NaN    NaN  NaN
#:> 104      NaN     NaN    NaN  NaN
```

### Iteration

#### Loop Through Rows (.iterrows)


```python
df = pd.DataFrame(data=
    { 'empID':  [100,      101,    102,      103,     104],
      'Name':   ['Alice',  'Bob',  'Charles','David', 'Eric'],
      'Year':   [1999,     1988,   2001,     2010,     2020]}).set_index(['empID'])

for idx, row in df.iterrows():
  print(idx, row.Name)
```

```
#:> 100 Alice
#:> 101 Bob
#:> 102 Charles
#:> 103 David
#:> 104 Eric
```

#### Loop Through Columns (.itemes)


```python
for label, content in df.items():
  print('Label:',            label,   '\n\n', 
        'Content (Series):\n', content, '\n\n')
```

```
#:> Label: Name 
#:> 
#:>  Content (Series):
#:>  empID
#:> 100      Alice
#:> 101        Bob
#:> 102    Charles
#:> 103      David
#:> 104       Eric
#:> Name: Name, dtype: object 
#:> 
#:> 
#:> Label: Year 
#:> 
#:>  Content (Series):
#:>  empID
#:> 100    1999
#:> 101    1988
#:> 102    2001
#:> 103    2010
#:> 104    2020
#:> Name: Year, dtype: int64
```

### Data Structure

#### Instance Methods - Structure

Find out the column names, data type in a summary. Output is for display only, not a data object


```python
df.info()  # return text output
```

```
#:> <class 'pandas.core.frame.DataFrame'>
#:> Int64Index: 5 entries, 100 to 104
#:> Data columns (total 2 columns):
#:>  #   Column  Non-Null Count  Dtype 
#:> ---  ------  --------------  ----- 
#:>  0   Name    5 non-null      object
#:>  1   Year    5 non-null      int64 
#:> dtypes: int64(1), object(1)
#:> memory usage: 120.0+ bytes
```


```python
df.get_dtype_counts() # return Series
```


#### Conversion To Other Format


```python
df.to_json()
```

```
#:> '{"Name":{"100":"Alice","101":"Bob","102":"Charles","103":"David","104":"Eric"},"Year":{"100":1999,"101":1988,"102":2001,"103":2010,"104":2020}}'
```


```python
df.to_records()
```

```
#:> rec.array([(100, 'Alice', 1999), (101, 'Bob', 1988),
#:>            (102, 'Charles', 2001), (103, 'David', 2010),
#:>            (104, 'Eric', 2020)],
#:>           dtype=[('empID', '<i8'), ('Name', 'O'), ('Year', '<i8')])
```


```python
df.to_csv()
```

```
#:> 'empID,Name,Year\n100,Alice,1999\n101,Bob,1988\n102,Charles,2001\n103,David,2010\n104,Eric,2020\n'
```


## class: MultiIndex

MultiIndexing are columns with few levels of headers.

### The Data


```python
df = pd.DataFrame({
     'myindex': [0, 1, 2],
     'One_X':   [1.1,  1.1,  1.1],
     'One_Y':   [1.2,  1.2,  1.2],
     'Two_X':   [1.11, 1.11, 1.11],
     'Two_Y':   [1.22, 1.22, 1.22]})
df.set_index('myindex',inplace=True)
df
```

```
#:>          One_X  One_Y  Two_X  Two_Y
#:> myindex                            
#:> 0          1.1    1.2   1.11   1.22
#:> 1          1.1    1.2   1.11   1.22
#:> 2          1.1    1.2   1.11   1.22
```

### Creating MultiIndex Object

#### Create From Tuples

MultiIndex can easily created from typles:  
- Step 1: Create a MultiIndex object by splitting column name into tuples  
- Step 2: Assign the MultiIndex Object to dataframe `columns` property.  


```python
my_tuples = [tuple(c.split('_')) for c in df.columns]
df.columns = pd.MultiIndex.from_tuples(my_tuples)

print(' Column Headers :\n\n',           my_tuples,
        '\n\nNew Columns: \n\n',         df.columns,
        '\n\nTwo Layers Header DF:\n\n', df)
```

```
#:>  Column Headers :
#:> 
#:>  [('One', 'X'), ('One', 'Y'), ('Two', 'X'), ('Two', 'Y')] 
#:> 
#:> New Columns: 
#:> 
#:>  MultiIndex([('One', 'X'),
#:>             ('One', 'Y'),
#:>             ('Two', 'X'),
#:>             ('Two', 'Y')],
#:>            ) 
#:> 
#:> Two Layers Header DF:
#:> 
#:>           One        Two      
#:>            X    Y     X     Y
#:> myindex                      
#:> 0        1.1  1.2  1.11  1.22
#:> 1        1.1  1.2  1.11  1.22
#:> 2        1.1  1.2  1.11  1.22
```



### MultiIndex Object

#### Levels

- MultiIndex object contain multiple leveels, each level (header) is an Index object.   
- Use **`MultiIndex.get_level_values()`** to the entire header for the desired level. Note that each level is an Index object


```python
print(df.columns.get_level_values(0), '\n',
      df.columns.get_level_values(1))
```

```
#:> Index(['One', 'One', 'Two', 'Two'], dtype='object') 
#:>  Index(['X', 'Y', 'X', 'Y'], dtype='object')
```

**`MultiIndex.levels`** return the **unique values** of each level.


```python
print(df.columns.levels[0], '\n',
      df.columns.levels[1])
```

```
#:> Index(['One', 'Two'], dtype='object') 
#:>  Index(['X', 'Y'], dtype='object')
```

#### Convert MultiIndex Back To Tuples


```python
df.columns.to_list()
```

```
#:> [('One', 'X'), ('One', 'Y'), ('Two', 'X'), ('Two', 'Y')]
```

### Selecting Column(s)

#### Sample Data


```python
import itertools
test_df = pd.DataFrame
max_age = 100

### Create The Columns Tuple
level0_sex = ['Male','Female','Pondan']
level1_age = ['Medium','High','Low']
my_columns = list(itertools.product(level0_sex, level1_age))

test_df = pd.DataFrame([
             [1,2,3,4,5,6,7,8,9],
             [11,12,13,14,15,16,17,18,19],
             [21,22,23,24,25,26,27,28,29]], index=['row1','row2','row3'])

### Create Multiindex From Tuple
test_df.columns = pd.MultiIndex.from_tuples(my_columns)
print( test_df ) 
```

```
#:>        Male          Female          Pondan         
#:>      Medium High Low Medium High Low Medium High Low
#:> row1      1    2   3      4    5   6      7    8   9
#:> row2     11   12  13     14   15  16     17   18  19
#:> row3     21   22  23     24   25  26     27   28  29
```

#### Select Level0 Header(s)

Use **`[L0]` notation**, where `L0` is list of header names


```python
print( test_df[['Male','Pondan']] ,'\n\n',  ## Include multiple Level0 Header
       test_df['Male'] ,          '\n\n',   ## Include single Level0 Header
       test_df.Male )                       ## Same as above
```

```
#:>        Male          Pondan         
#:>      Medium High Low Medium High Low
#:> row1      1    2   3      7    8   9
#:> row2     11   12  13     17   18  19
#:> row3     21   22  23     27   28  29 
#:> 
#:>        Medium  High  Low
#:> row1       1     2    3
#:> row2      11    12   13
#:> row3      21    22   23 
#:> 
#:>        Medium  High  Low
#:> row1       1     2    3
#:> row2      11    12   13
#:> row3      21    22   23
```

**Using `.loc[]`**

Use  **`.loc[ :, L0 ]`**, where `L0` is list of headers names


```python
print( test_df.loc[:, ['Male','Pondan']] , '\n\n',  ## Multiple Level0 Header
       test_df.loc[:, 'Male'] )                     ## Single Level0 Header
```

```
#:>        Male          Pondan         
#:>      Medium High Low Medium High Low
#:> row1      1    2   3      7    8   9
#:> row2     11   12  13     17   18  19
#:> row3     21   22  23     27   28  29 
#:> 
#:>        Medium  High  Low
#:> row1       1     2    3
#:> row2      11    12   13
#:> row3      21    22   23
```

#### Selecting Level 1 Header(s)

Use  **`.loc[ :, (All, L1)]`**, where `L1` are list of headers names


```python
All = slice(None)
print( test_df.loc[ : , (All, 'High')],  '\n\n',  ## Signle L1 header
       test_df.loc[ : , (All, ['High','Low'])] )  ## Multiple L1 headers
```

```
#:>      Male Female Pondan
#:>      High   High   High
#:> row1    2      5      8
#:> row2   12     15     18
#:> row3   22     25     28 
#:> 
#:>       Male     Female     Pondan    
#:>      High Low   High Low   High Low
#:> row1    2   3      5   6      8   9
#:> row2   12  13     15  16     18  19
#:> row3   22  23     25  26     28  29
```

#### Select Level 0 and Level1 Headers

Use  **`.loc[ :, (L0, L1)]`**, where `L0` and `L1` are list of headers names


```python
test_df.loc[ : , (['Male','Pondan'], ['Medium','High'])]
```

```
#:>        Male      Pondan     
#:>      Medium High Medium High
#:> row1      1    2      7    8
#:> row2     11   12     17   18
#:> row3     21   22     27   28
```

#### Select single L0,L1 Header

Use **`.loc[:, (L0,  L1) ]`**, result is a **Series**  
Use **`.loc[:, (L0 ,[L1])]`**, result is a **DataFrame**


```python
print( test_df.loc[ : , ('Female', 'High')], '\n\n',
       test_df.loc[ : , ('Female', ['High'])])
```

```
#:> row1     5
#:> row2    15
#:> row3    25
#:> Name: (Female, High), dtype: int64 
#:> 
#:>       Female
#:>        High
#:> row1      5
#:> row2     15
#:> row3     25
```

### Headers Ordering

Note that columns **order** specifeid by `[ ]` selection were not respected. This can be remediated either by Sorting and rearranging.

#### Sort Headers

Use `.sort_index()` on DataFrame to sort the headers. Note that when level1 is sorted, it jumble up level0 headers.


```python
test_df_sorted_l0 = test_df.sort_index(axis=1, level=0)
test_df_sorted_l1 = test_df.sort_index(axis=1, level=1, ascending=False)
print(test_df, '\n\n',test_df_sorted_l0, '\n\n', test_df_sorted_l1)
```

```
#:>        Male          Female          Pondan         
#:>      Medium High Low Medium High Low Medium High Low
#:> row1      1    2   3      4    5   6      7    8   9
#:> row2     11   12  13     14   15  16     17   18  19
#:> row3     21   22  23     24   25  26     27   28  29 
#:> 
#:>       Female            Male            Pondan           
#:>        High Low Medium High Low Medium   High Low Medium
#:> row1      5   6      4    2   3      1      8   9      7
#:> row2     15  16     14   12  13     11     18  19     17
#:> row3     25  26     24   22  23     21     28  29     27 
#:> 
#:>       Pondan   Male Female Pondan Male Female Pondan Male Female
#:>      Medium Medium Medium    Low  Low    Low   High High   High
#:> row1      7      1      4      9    3      6      8    2      5
#:> row2     17     11     14     19   13     16     18   12     15
#:> row3     27     21     24     29   23     26     28   22     25
```
#### Rearranging Headers

Use **`.reindex()**` on arrange columns in specific order. Example below shows how to control the specific order for level1 headers.


```python
cats = ['Low','Medium','High']
test_df.reindex(cats, level=1, axis=1)
```

```
#:>      Male             Female             Pondan            
#:>       Low Medium High    Low Medium High    Low Medium High
#:> row1    3      1    2      6      4    5      9      7    8
#:> row2   13     11   12     16     14   15     19     17   18
#:> row3   23     21   22     26     24   25     29     27   28
```

### Stacking and Unstacking


```python
df.stack()
```

```
#:>            One   Two
#:> myindex             
#:> 0       X  1.1  1.11
#:>         Y  1.2  1.22
#:> 1       X  1.1  1.11
#:>         Y  1.2  1.22
#:> 2       X  1.1  1.11
#:>         Y  1.2  1.22
```

#### Stacking Columns to Rows

Stacking with **`DataFrame.stack(level_no)`** is moving wide columns into row.


```python
print('Stacking Header Level 0: \n\n', df.stack(0),
      '\n\nStacking Header Level 1: \n\n', df.stack(1))
```

```
#:> Stacking Header Level 0: 
#:> 
#:>                  X     Y
#:> myindex                
#:> 0       One  1.10  1.20
#:>         Two  1.11  1.22
#:> 1       One  1.10  1.20
#:>         Two  1.11  1.22
#:> 2       One  1.10  1.20
#:>         Two  1.11  1.22 
#:> 
#:> Stacking Header Level 1: 
#:> 
#:>             One   Two
#:> myindex             
#:> 0       X  1.1  1.11
#:>         Y  1.2  1.22
#:> 1       X  1.1  1.11
#:>         Y  1.2  1.22
#:> 2       X  1.1  1.11
#:>         Y  1.2  1.22
```

### Exploratory Analysis


#### Sample Data


```python
df
```

```
#:>          One        Two      
#:>            X    Y     X     Y
#:> myindex                      
#:> 0        1.1  1.2  1.11  1.22
#:> 1        1.1  1.2  1.11  1.22
#:> 2        1.1  1.2  1.11  1.22
```


#### All Stats in One  - .describe()


```
df.describe(include='number') # default
df.describe(include='object') # display for non-numeric columns
df.describe(include='all')    # display both numeric and non-numeric
```

When applied to DataFrame object, describe shows all **basic statistic** for **all numeric** columns:
- Count (non-NA)  
- Unique (for string)  
- Top (for string)   
- Frequency (for string)  
- Percentile  
- Mean  
- Min / Max  
- Standard Deviation  


**For Numeric Columns only**  
You can **customize the percentiles requred**. Notice 0.5 percentile is always there although not specified


```python
df.describe()
```

```
#:>        One        Two      
#:>          X    Y     X     Y
#:> count  3.0  3.0  3.00  3.00
#:> mean   1.1  1.2  1.11  1.22
#:> std    0.0  0.0  0.00  0.00
#:> min    1.1  1.2  1.11  1.22
#:> 25%    1.1  1.2  1.11  1.22
#:> 50%    1.1  1.2  1.11  1.22
#:> 75%    1.1  1.2  1.11  1.22
#:> max    1.1  1.2  1.11  1.22
```


```python
df.describe(percentiles=[0.9,0.3,0.2,0.1])
```

```
#:>        One        Two      
#:>          X    Y     X     Y
#:> count  3.0  3.0  3.00  3.00
#:> mean   1.1  1.2  1.11  1.22
#:> std    0.0  0.0  0.00  0.00
#:> min    1.1  1.2  1.11  1.22
#:> 10%    1.1  1.2  1.11  1.22
#:> 20%    1.1  1.2  1.11  1.22
#:> 30%    1.1  1.2  1.11  1.22
#:> 50%    1.1  1.2  1.11  1.22
#:> 90%    1.1  1.2  1.11  1.22
#:> max    1.1  1.2  1.11  1.22
```


**For both Numeric and Object**


```python
df.describe(include='all')
```

```
#:>        One        Two      
#:>          X    Y     X     Y
#:> count  3.0  3.0  3.00  3.00
#:> mean   1.1  1.2  1.11  1.22
#:> std    0.0  0.0  0.00  0.00
#:> min    1.1  1.2  1.11  1.22
#:> 25%    1.1  1.2  1.11  1.22
#:> 50%    1.1  1.2  1.11  1.22
#:> 75%    1.1  1.2  1.11  1.22
#:> max    1.1  1.2  1.11  1.22
```


#### min/max/mean/median


```python
df.min()  # default axis=0, column-wise
```

```
#:> One  X    1.10
#:>      Y    1.20
#:> Two  X    1.11
#:>      Y    1.22
#:> dtype: float64
```


```python
df.min(axis=1) # axis=1, row-wise
```

```
#:> myindex
#:> 0    1.1
#:> 1    1.1
#:> 2    1.1
#:> dtype: float64
```


Observe, sum on **string will concatenate column-wise**, whereas row-wise only sum up numeric fields


```python
df.sum(0)
```

```
#:> One  X    3.30
#:>      Y    3.60
#:> Two  X    3.33
#:>      Y    3.66
#:> dtype: float64
```


```python
df.sum(1)
```

```
#:> myindex
#:> 0    4.63
#:> 1    4.63
#:> 2    4.63
#:> dtype: float64
```


### Plotting






## class: Categories

### Creating

#### From List
**Basic (Auto Category Mapping)**  
Basic syntax return categorical index with sequence with code 0,1,2,3... mapping to first found category   
In this case, **low(0), high(1), medium(2)**


```python
temp = ['low','high','medium','high','high','low','medium','medium','high']
temp_cat = pd.Categorical(temp)
temp_cat
```

```
#:> ['low', 'high', 'medium', 'high', 'high', 'low', 'medium', 'medium', 'high']
#:> Categories (3, object): ['high', 'low', 'medium']
```


```python
type( temp_cat )
```

```
#:> <class 'pandas.core.arrays.categorical.Categorical'>
```


**Manual Category Mapping**  
During creation, we can specify mapping of codes to category: **low(0), medium(1), high(2)**


```python
temp_cat = pd.Categorical(temp, categories=['low','medium','high'])
temp_cat
```

```
#:> ['low', 'high', 'medium', 'high', 'high', 'low', 'medium', 'medium', 'high']
#:> Categories (3, object): ['low', 'medium', 'high']
```


#### From Series
- We can 'add' categorical structure into a Series. With these methods, additional property (.cat) is added as a **categorical accessor**  
- Through this accessor, you gain access to various properties of the category such as .codes, .categories. But not .get_values() as the information is in the Series itself  
- Can we manual map category ?????


```python
temp = ['low','high','medium','high','high','low','medium','medium','high']
temp_cat = pd.Series(temp, dtype='category')
print (type(temp_cat))       # Series object
```

```
#:> <class 'pandas.core.series.Series'>
```

```python
print (type(temp_cat.cat))   # Categorical Accessor
```

```
#:> <class 'pandas.core.arrays.categorical.CategoricalAccessor'>
```


- Method below has the same result as above by using **.astype('category')**  
- It is useful adding category structure into existing series.


```python
temp_ser = pd.Series(temp)
temp_cat = pd.Series(temp).astype('category')
print (type(temp_cat))       # Series object
```

```
#:> <class 'pandas.core.series.Series'>
```

```python
print (type(temp_cat.cat))   # Categorical Accessor
```

```
#:> <class 'pandas.core.arrays.categorical.CategoricalAccessor'>
```


```python
temp_cat.cat.categories
```

```
#:> Index(['high', 'low', 'medium'], dtype='object')
```


#### Ordering Category


```python
temp = ['low','high','medium','high','high','low','medium','medium','high']
temp_cat = pd.Categorical(temp, categories=['low','medium','high'], ordered=True)
temp_cat
```

```
#:> ['low', 'high', 'medium', 'high', 'high', 'low', 'medium', 'medium', 'high']
#:> Categories (3, object): ['low' < 'medium' < 'high']
```


```python
# error
temp_cat.get_values()
```


```python
temp_cat.codes
```

```
#:> array([0, 2, 1, 2, 2, 0, 1, 1, 2], dtype=int8)
```


```python
temp_cat[0] < temp_cat[3]
```

```
#:> False
```

<!-- jupyter_markdown, jupyter_meta = list(heading_collapsed = TRUE) -->
### Properties

<!-- jupyter_markdown, jupyter_meta = list(hidden = TRUE) -->
#### .categories
first element's code = 0  
second element's code = 1  
third element's code = 2


```python
temp_cat.categories
```

```
#:> Index(['low', 'medium', 'high'], dtype='object')
```

<!-- jupyter_markdown, jupyter_meta = list(hidden = TRUE) -->
#### .codes
Codes are actual **integer** value stored as array. 1 represent 'high', 


```python
temp_cat.codes
```

```
#:> array([0, 2, 1, 2, 2, 0, 1, 1, 2], dtype=int8)
```

<!-- jupyter_markdown, jupyter_meta = list(heading_collapsed = TRUE) -->
### Rename Category

<!-- jupyter_markdown, jupyter_meta = list(hidden = TRUE) -->
#### Renamce To New Category Object
**.rename_categories()** method return a new category object with new changed categories


```python
temp = ['low','high','medium','high','high','low','medium','medium','high']
new_temp_cat = temp_cat.rename_categories(['sejuk','sederhana','panas'])
new_temp_cat 
```

```
#:> ['sejuk', 'panas', 'sederhana', 'panas', 'panas', 'sejuk', 'sederhana', 'sederhana', 'panas']
#:> Categories (3, object): ['sejuk' < 'sederhana' < 'panas']
```


```python
temp_cat   # original category object categories not changed
```

```
#:> ['low', 'high', 'medium', 'high', 'high', 'low', 'medium', 'medium', 'high']
#:> Categories (3, object): ['low' < 'medium' < 'high']
```

<!-- jupyter_markdown, jupyter_meta = list(hidden = TRUE) -->
#### Rename Inplace
Observe the original categories had been changed using **.rename()**


```python
temp_cat.categories = ['sejuk','sederhana','panas']
temp_cat   # original category object categories is changed
```

```
#:> ['sejuk', 'panas', 'sederhana', 'panas', 'panas', 'sejuk', 'sederhana', 'sederhana', 'panas']
#:> Categories (3, object): ['sejuk' < 'sederhana' < 'panas']
```

<!-- jupyter_markdown, jupyter_meta = list(heading_collapsed = TRUE) -->
### Adding New Category
This return a new category object with added categories


```python
temp_cat_more = temp_cat.add_categories(['susah','senang'])
temp_cat_more
```

```
#:> ['sejuk', 'panas', 'sederhana', 'panas', 'panas', 'sejuk', 'sederhana', 'sederhana', 'panas']
#:> Categories (5, object): ['sejuk' < 'sederhana' < 'panas' < 'susah' < 'senang']
```

<!-- jupyter_markdown, jupyter_meta = list(heading_collapsed = TRUE) -->
### Removing Category
This is **not in place**, hence return a new categorical object  

<!-- jupyter_markdown, jupyter_meta = list(hidden = TRUE) -->
#### Remove Specific Categor(ies)
Elements with its category removed will become **NaN**


```python
temp = ['low','high','medium','high','high','low','medium','medium','high']
temp_cat = pd.Categorical(temp)
temp_cat_removed = temp_cat.remove_categories('low')
temp_cat_removed
```

```
#:> [NaN, 'high', 'medium', 'high', 'high', NaN, 'medium', 'medium', 'high']
#:> Categories (2, object): ['high', 'medium']
```

<!-- jupyter_markdown, jupyter_meta = list(hidden = TRUE) -->
#### Remove Unused Category
Since categories removed are not used, there is no impact to the element


```python
print (temp_cat_more)
```

```
#:> ['sejuk', 'panas', 'sederhana', 'panas', 'panas', 'sejuk', 'sederhana', 'sederhana', 'panas']
#:> Categories (5, object): ['sejuk' < 'sederhana' < 'panas' < 'susah' < 'senang']
```

```python
temp_cat_more.remove_unused_categories()
```

```
#:> ['sejuk', 'panas', 'sederhana', 'panas', 'panas', 'sejuk', 'sederhana', 'sederhana', 'panas']
#:> Categories (3, object): ['sejuk' < 'sederhana' < 'panas']
```

<!-- jupyter_markdown, jupyter_meta = list(heading_collapsed = TRUE) -->
### Add and Remove Categories In One Step - Set()


```python
temp = ['low','high','medium','high','high','low','medium','medium','high']
temp_cat = pd.Categorical(temp, ordered=True)
temp_cat
```

```
#:> ['low', 'high', 'medium', 'high', 'high', 'low', 'medium', 'medium', 'high']
#:> Categories (3, object): ['high' < 'low' < 'medium']
```


```python
temp_cat.set_categories(['low','medium','sederhana','susah','senang'])
```

```
#:> ['low', NaN, 'medium', NaN, NaN, 'low', 'medium', 'medium', NaN]
#:> Categories (5, object): ['low' < 'medium' < 'sederhana' < 'susah' < 'senang']
```

<!-- jupyter_markdown, jupyter_meta = list(heading_collapsed = TRUE) -->
### Categorical Descriptive Analysis 

<!-- jupyter_markdown, jupyter_meta = list(hidden = TRUE) -->
#### At One Glance


```python
temp_cat.describe()
```

```
#:>             counts     freqs
#:> categories                  
#:> high             4  0.444444
#:> low              2  0.222222
#:> medium           3  0.333333
```

<!-- jupyter_markdown, jupyter_meta = list(hidden = TRUE) -->
#### Frequency Count


```python
temp_cat.value_counts()
```

```
#:> high      4
#:> low       2
#:> medium    3
#:> dtype: int64
```

<!-- jupyter_markdown, jupyter_meta = list(hidden = TRUE) -->
#### Least Frequent Category, Most Frequent Category, and Most Frequent Category


```python
( temp_cat.min(), temp_cat.max(), temp_cat.mode() )
```

```
#:> ('high', 'medium', ['high']
#:> Categories (3, object): ['high' < 'low' < 'medium'])
```


### Other Methods


#### .get_values()
Since actual value stored by categorical object are integer **codes**, get_values() function return values translated from *.codes** property


```python
temp_cat.get_values()  #array
```


## Dummies

- **get_dummies** creates columns for each categories 
- The underlying data can be string or pd.Categorical  
- It produces a **new pd.DataFrame**


### Sample Data


```python
df = pd.DataFrame (
    {'A': ['A1', 'A2', 'A3','A1','A3','A1'], 
     'B': ['B1','B2','B3','B1','B1','B3'],
     'C': ['C1','C2','C3','C1',np.nan,np.nan]})
df
```

```
#:>     A   B    C
#:> 0  A1  B1   C1
#:> 1  A2  B2   C2
#:> 2  A3  B3   C3
#:> 3  A1  B1   C1
#:> 4  A3  B1  NaN
#:> 5  A1  B3  NaN
```


### Dummies on Array-Like Data


```python
pd.get_dummies(df.A)
```

```
#:>    A1  A2  A3
#:> 0   1   0   0
#:> 1   0   1   0
#:> 2   0   0   1
#:> 3   1   0   0
#:> 4   0   0   1
#:> 5   1   0   0
```


### Dummies on DataFrame (multiple columns)


#### All Columns


```python
pd.get_dummies(df)
```

```
#:>    A_A1  A_A2  A_A3  B_B1  B_B2  B_B3  C_C1  C_C2  C_C3
#:> 0     1     0     0     1     0     0     1     0     0
#:> 1     0     1     0     0     1     0     0     1     0
#:> 2     0     0     1     0     0     1     0     0     1
#:> 3     1     0     0     1     0     0     1     0     0
#:> 4     0     0     1     1     0     0     0     0     0
#:> 5     1     0     0     0     0     1     0     0     0
```


#### Selected Columns


```python
cols = ['A','B']
pd.get_dummies(df[cols])
```

```
#:>    A_A1  A_A2  A_A3  B_B1  B_B2  B_B3
#:> 0     1     0     0     1     0     0
#:> 1     0     1     0     0     1     0
#:> 2     0     0     1     0     0     1
#:> 3     1     0     0     1     0     0
#:> 4     0     0     1     1     0     0
#:> 5     1     0     0     0     0     1
```


### Dummies with na
By default, nan values are ignored


```python
pd.get_dummies(df.C)
```

```
#:>    C1  C2  C3
#:> 0   1   0   0
#:> 1   0   1   0
#:> 2   0   0   1
#:> 3   1   0   0
#:> 4   0   0   0
#:> 5   0   0   0
```


**Make NaN as a dummy variable**


```python
pd.get_dummies(df.C,dummy_na=True)
```

```
#:>    C1  C2  C3  NaN
#:> 0   1   0   0    0
#:> 1   0   1   0    0
#:> 2   0   0   1    0
#:> 3   1   0   0    0
#:> 4   0   0   0    1
#:> 5   0   0   0    1
```


### Specify Prefixes


```python
pd.get_dummies(df.A, prefix='col')
```

```
#:>    col_A1  col_A2  col_A3
#:> 0       1       0       0
#:> 1       0       1       0
#:> 2       0       0       1
#:> 3       1       0       0
#:> 4       0       0       1
#:> 5       1       0       0
```


```python
pd.get_dummies(df[cols], prefix=['colA','colB'])
```

```
#:>    colA_A1  colA_A2  colA_A3  colB_B1  colB_B2  colB_B3
#:> 0        1        0        0        1        0        0
#:> 1        0        1        0        0        1        0
#:> 2        0        0        1        0        0        1
#:> 3        1        0        0        1        0        0
#:> 4        0        0        1        1        0        0
#:> 5        1        0        0        0        0        1
```


### Dropping First Column
- Dummies cause **colinearity issue** for regression as it has redundant column.  
- Dropping a column **does not loose any information** technically


```python
pd.get_dummies(df[cols],drop_first=True)
```

```
#:>    A_A2  A_A3  B_B2  B_B3
#:> 0     0     0     0     0
#:> 1     1     0     1     0
#:> 2     0     1     0     1
#:> 3     0     0     0     0
#:> 4     0     1     0     0
#:> 5     0     0     0     1
```

## DataFrameGroupBy

- `groupby()` is a DataFrame method, it returns  **`DataFrameGroupBy`** object  
- **`DataFrameGroupBy`** object open doors for dataframe aggregation and summarization  
- **`DataFrameGroupBy`** object is a **very flexible abstraction**. In many ways, you can simply treat `DataFrameGroup` as if it's a **collection of DataFrames**, and it does the difficult things under the hood  


### Sample Data


```python
company = pd.read_csv('data/company.csv')
company
```

```
#:>    Company Department      Name  Age  Salary  Birthdate
#:> 0       C1         D1      Yong   45   15000   1/1/1970
#:> 1       C1         D1      Chew   35   12000   2/1/1980
#:> 2       C1         D2       Lim   34    8000  2/19/1977
#:> 3       C1         D3     Jessy   23    2500  3/15/1990
#:> 4       C1         D3  Hoi Ming   55   25000  4/15/1987
#:> ..     ...        ...       ...  ...     ...        ...
#:> 13      C3         D3     Chang   32    7900  7/26/1973
#:> 14      C3         D1       Ong   44   17500  8/21/1980
#:> 15      C3         D2      Lily   41   15300  7/17/1990
#:> 16      C3         D3     Sally   54   21000  7/19/1968
#:> 17      C3         D3    Esther   37   13500  3/16/1969
#:> 
#:> [18 rows x 6 columns]
```

### Creating Groups

Group can be created for  **single or multiple** columns


```python
com_grp = company.groupby('Company') ## Single Column
com_dep_grp = company.groupby(['Company','Department'])  ## Multiple Column
type(com_dep_grp)
```

```
#:> <class 'pandas.core.groupby.generic.DataFrameGroupBy'>
```

### Properties

#### Number of Groups


```python
com_dep_grp.ngroups
```

```
#:> 9
```

#### Row Numbers Associated For Each Group

`.groups` property is a dictionary containing group key (identifying the group) and its values (underlying row indexes for the group)


```python
gdict = com_dep_grp.groups       # return Dictionary
print( gdict.keys()   , '\n\n',  # group identifier
       gdict.values()   )        # group row indexes
```

```
#:> dict_keys([('C1', 'D1'), ('C1', 'D2'), ('C1', 'D3'), ('C2', 'D1'), ('C2', 'D2'), ('C2', 'D3'), ('C3', 'D1'), ('C3', 'D2'), ('C3', 'D3')]) 
#:> 
#:>  dict_values([Int64Index([0, 1], dtype='int64'), Int64Index([2], dtype='int64'), Int64Index([3, 4, 5], dtype='int64'), Int64Index([6], dtype='int64'), Int64Index([7, 8, 9], dtype='int64'), Int64Index([10, 11, 12], dtype='int64'), Int64Index([14], dtype='int64'), Int64Index([15], dtype='int64'), Int64Index([13, 16, 17], dtype='int64')])
```

### Methods

#### Number of Rows In Each Group


```python
com_dep_grp.size()  # return panda Series object
```

```
#:> Company  Department
#:> C1       D1            2
#:>          D2            1
#:>          D3            3
#:> C2       D1            1
#:>          D2            3
#:>          D3            3
#:> C3       D1            1
#:>          D2            1
#:>          D3            3
#:> dtype: int64
```

### Retrieve Rows

#### Retrieve n-th Row Of Each Grou

- Row number is 0-based  
- For First row, use `.first()` or `nth(0)`  


```python
print( com_dep_grp.nth(0)  , '\n',
       com_dep_grp.first())
```

```
#:>                        Name  Age  Salary   Birthdate
#:> Company Department                                  
#:> C1      D1             Yong   45   15000    1/1/1970
#:>         D2              Lim   34    8000   2/19/1977
#:>         D3            Jessy   23    2500   3/15/1990
#:> C2      D1             Anne   18     400   7/15/1997
#:>         D2          Deborah   30    8600   8/15/1984
#:>         D3          Michael   38   17000  11/30/1997
#:> C3      D1              Ong   44   17500   8/21/1980
#:>         D2             Lily   41   15300   7/17/1990
#:>         D3            Chang   32    7900   7/26/1973 
#:>                         Name  Age  Salary   Birthdate
#:> Company Department                                  
#:> C1      D1             Yong   45   15000    1/1/1970
#:>         D2              Lim   34    8000   2/19/1977
#:>         D3            Jessy   23    2500   3/15/1990
#:> C2      D1             Anne   18     400   7/15/1997
#:>         D2          Deborah   30    8600   8/15/1984
#:>         D3          Michael   38   17000  11/30/1997
#:> C3      D1              Ong   44   17500   8/21/1980
#:>         D2             Lily   41   15300   7/17/1990
#:>         D3            Chang   32    7900   7/26/1973
```

- For Last row,  use `.last()` or `nth(`-1)`


```python
print( com_dep_grp.nth(-1)  , '\n',
       com_dep_grp.last())
```

```
#:>                        Name  Age  Salary   Birthdate
#:> Company Department                                  
#:> C1      D1             Chew   35   12000    2/1/1980
#:>         D2              Lim   34    8000   2/19/1977
#:>         D3          Sui Wei   56    3000   6/15/1990
#:> C2      D1             Anne   18     400   7/15/1997
#:>         D2            Jimmy   46   14000  10/31/1988
#:>         D3          Bernard   29    9800   12/1/1963
#:> C3      D1              Ong   44   17500   8/21/1980
#:>         D2             Lily   41   15300   7/17/1990
#:>         D3           Esther   37   13500   3/16/1969 
#:>                         Name  Age  Salary   Birthdate
#:> Company Department                                  
#:> C1      D1             Chew   35   12000    2/1/1980
#:>         D2              Lim   34    8000   2/19/1977
#:>         D3          Sui Wei   56    3000   6/15/1990
#:> C2      D1             Anne   18     400   7/15/1997
#:>         D2            Jimmy   46   14000  10/31/1988
#:>         D3          Bernard   29    9800   12/1/1963
#:> C3      D1              Ong   44   17500   8/21/1980
#:>         D2             Lily   41   15300   7/17/1990
#:>         D3           Esther   37   13500   3/16/1969
```

#### Retrieve N Rows Of Each Groups

Example below retrieve 2 rows from each group


```python
com_dep_grp.head(2)
```

```
#:>    Company Department      Name  Age  Salary   Birthdate
#:> 0       C1         D1      Yong   45   15000    1/1/1970
#:> 1       C1         D1      Chew   35   12000    2/1/1980
#:> 2       C1         D2       Lim   34    8000   2/19/1977
#:> 3       C1         D3     Jessy   23    2500   3/15/1990
#:> 4       C1         D3  Hoi Ming   55   25000   4/15/1987
#:> ..     ...        ...       ...  ...     ...         ...
#:> 11      C2         D3   Jeannie   30   12500  12/31/1980
#:> 13      C3         D3     Chang   32    7900   7/26/1973
#:> 14      C3         D1       Ong   44   17500   8/21/1980
#:> 15      C3         D2      Lily   41   15300   7/17/1990
#:> 16      C3         D3     Sally   54   21000   7/19/1968
#:> 
#:> [14 rows x 6 columns]
```

#### Retrieve All Rows Of  Specific Group

`get_group()` retrieves all rows within the specified group.


```python
com_dep_grp.get_group(('C1','D3'))
```

```
#:>   Company Department      Name  Age  Salary  Birthdate
#:> 3      C1         D3     Jessy   23    2500  3/15/1990
#:> 4      C1         D3  Hoi Ming   55   25000  4/15/1987
#:> 5      C1         D3   Sui Wei   56    3000  6/15/1990
```

### Single Statistic Per Group

#### `count()` 

`count()` for valid data (not null) for each fields within the group


```python
com_dep_grp.count()  # return panda DataFrame object
```

```
#:>                     Name  Age  Salary  Birthdate
#:> Company Department                              
#:> C1      D1             2    2       2          2
#:>         D2             1    1       1          1
#:>         D3             3    3       3          3
#:> C2      D1             1    1       1          1
#:>         D2             3    3       3          3
#:>         D3             3    3       3          3
#:> C3      D1             1    1       1          1
#:>         D2             1    1       1          1
#:>         D3             3    3       3          3
```

#### `sum()`

This sums up all numeric columns for each group


```python
com_dep_grp.sum()
```

```
#:>                     Age  Salary
#:> Company Department             
#:> C1      D1           80   27000
#:>         D2           34    8000
#:>         D3          134   30500
#:> C2      D1           18     400
#:>         D2          127   34600
#:>         D3           97   39300
#:> C3      D1           44   17500
#:>         D2           41   15300
#:>         D3          123   42400
```

To sum specific columns of each group, use `['columnName']` to select the column.  
When single column is selected, output is a **Series**


```python
com_dep_grp['Age'].sum()
```

```
#:> Company  Department
#:> C1       D1             80
#:>          D2             34
#:>          D3            134
#:> C2       D1             18
#:>          D2            127
#:>          D3             97
#:> C3       D1             44
#:>          D2             41
#:>          D3            123
#:> Name: Age, dtype: int64
```

#### `mean()`

This average up all numeric columns for each group


```python
com_dep_grp.mean()
```

```
#:>                           Age        Salary
#:> Company Department                         
#:> C1      D1          40.000000  13500.000000
#:>         D2          34.000000   8000.000000
#:>         D3          44.666667  10166.666667
#:> C2      D1          18.000000    400.000000
#:>         D2          42.333333  11533.333333
#:>         D3          32.333333  13100.000000
#:> C3      D1          44.000000  17500.000000
#:>         D2          41.000000  15300.000000
#:>         D3          41.000000  14133.333333
```

To average specific columns of each group, use `['columnName']` to select the column.  
When single column is selected, output is a **Series**


```python
com_dep_grp['Age'].mean()
```

```
#:> Company  Department
#:> C1       D1            40.000000
#:>          D2            34.000000
#:>          D3            44.666667
#:> C2       D1            18.000000
#:>          D2            42.333333
#:>          D3            32.333333
#:> C3       D1            44.000000
#:>          D2            41.000000
#:>          D3            41.000000
#:> Name: Age, dtype: float64
```

### Multi Statistic Per Group

#### Single Function To Column(s)

- Instructions for aggregation are provided in the form of a dictionary. Dictionary keys specifies the **column name**, and value as the **function** to run  
- Can use **`lambda x:`** to customize the calclulation on entire column (x)  
- Python built-in function names does can be supplied without wrapping in string `'function'`


```python
com_dep_grp.agg({
  'Age': sum ,                 ## Total age of the group
  'Salary': lambda x: max(x),  ## Highest salary of the group
  'Birthdate': 'first'         ## First birthday of the group
})
```

```
#:>                     Age  Salary   Birthdate
#:> Company Department                         
#:> C1      D1           80   15000    1/1/1970
#:>         D2           34    8000   2/19/1977
#:>         D3          134   25000   3/15/1990
#:> C2      D1           18     400   7/15/1997
#:>         D2          127   14000   8/15/1984
#:>         D3           97   17000  11/30/1997
#:> C3      D1           44   17500   8/21/1980
#:>         D2           41   15300   7/17/1990
#:>         D3          123   21000   7/26/1973
```

#### Multiple Function to Column(s)

- Use list of function names to specify functions to be applied on a particular column  
- Notice that output columns are MultiIndex , indicating the name of funcitons appled on level 1  


```python
ag = com_dep_grp.agg({
      'Age': ['mean', sum ],       ## Average age of the group
      'Salary': lambda x: max(x),  ## Highest salary of the group
      'Birthdate': 'first'         ## First birthday of the group
    })
    
print (ag, '\n\n', ag.columns)
```

```
#:>                           Age        Salary   Birthdate
#:>                          mean  sum <lambda>       first
#:> Company Department                                     
#:> C1      D1          40.000000   80    15000    1/1/1970
#:>         D2          34.000000   34     8000   2/19/1977
#:>         D3          44.666667  134    25000   3/15/1990
#:> C2      D1          18.000000   18      400   7/15/1997
#:>         D2          42.333333  127    14000   8/15/1984
#:>         D3          32.333333   97    17000  11/30/1997
#:> C3      D1          44.000000   44    17500   8/21/1980
#:>         D2          41.000000   41    15300   7/17/1990
#:>         D3          41.000000  123    21000   7/26/1973 
#:> 
#:>  MultiIndex([(      'Age',     'mean'),
#:>             (      'Age',      'sum'),
#:>             (   'Salary', '<lambda>'),
#:>             ('Birthdate',    'first')],
#:>            )
```

#### Column Relabling

Introduced in Pandas 0.25.0, groupby aggregation with relabelling is supported using “named aggregation” with **simple tuples**


```python
com_dep_grp.agg(
  max_age     = ('Age', max),
  salary_m100 = ('Salary',  lambda x: max(x)+100),  
  first_bd    = ('Birthdate', 'first')
)
```

```
#:>                     max_age  salary_m100    first_bd
#:> Company Department                                  
#:> C1      D1               45        15100    1/1/1970
#:>         D2               34         8100   2/19/1977
#:>         D3               56        25100   3/15/1990
#:> C2      D1               18          500   7/15/1997
#:>         D2               51        14100   8/15/1984
#:>         D3               38        17100  11/30/1997
#:> C3      D1               44        17600   8/21/1980
#:>         D2               41        15400   7/17/1990
#:>         D3               54        21100   7/26/1973
```

### Iteration

**DataFrameGroupBy** object can be thought as a collection of named groups


```python
def print_groups (g):
    for name,group in g:
        print (name)
        print (group[:2])
        
print_groups (com_grp)
```

```
#:> C1
#:>   Company Department  Name  Age  Salary Birthdate
#:> 0      C1         D1  Yong   45   15000  1/1/1970
#:> 1      C1         D1  Chew   35   12000  2/1/1980
#:> C2
#:>   Company Department     Name  Age  Salary  Birthdate
#:> 6      C2         D1     Anne   18     400  7/15/1997
#:> 7      C2         D2  Deborah   30    8600  8/15/1984
#:> C3
#:>    Company Department   Name  Age  Salary  Birthdate
#:> 13      C3         D3  Chang   32    7900  7/26/1973
#:> 14      C3         D1    Ong   44   17500  8/21/1980
```


```python
com_grp
```

```
#:> <pandas.core.groupby.generic.DataFrameGroupBy object at 0x7fbeed212790>
```

### Transform

- Transform is an operation used combined with **DataFrameGroupBy** object  
- **transform()** return a **new DataFrame object**  


```python
grp = company.groupby('Company')
grp.size()
```

```
#:> Company
#:> C1    6
#:> C2    7
#:> C3    5
#:> dtype: int64
```


**transform()** perform a function to a group, and **expands and replicate** it to multiple rows according to original DataFrame


```python
grp[['Age','Salary']].transform('sum')
```

```
#:>     Age  Salary
#:> 0   248   65500
#:> 1   248   65500
#:> 2   248   65500
#:> 3   248   65500
#:> 4   248   65500
#:> ..  ...     ...
#:> 13  208   75200
#:> 14  208   75200
#:> 15  208   75200
#:> 16  208   75200
#:> 17  208   75200
#:> 
#:> [18 rows x 2 columns]
```


```python
grp.transform( lambda x:x+10 )
```

```
#:>     Age  Salary
#:> 0    55   15010
#:> 1    45   12010
#:> 2    44    8010
#:> 3    33    2510
#:> 4    65   25010
#:> ..  ...     ...
#:> 13   42    7910
#:> 14   54   17510
#:> 15   51   15310
#:> 16   64   21010
#:> 17   47   13510
#:> 
#:> [18 rows x 2 columns]
```

## Fundamental Analysis

## Missing Data

### What Is Considered Missing Data ? 

### Sample Data


```python
df = pd.DataFrame( np.random.randn(5, 3), 
                   index   =['a', 'c', 'e', 'f', 'h'],
                   columns =['one', 'two', 'three'])
df['four'] = 'bar'
df['five'] = df['one'] > 0
#df
df.reindex(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'])
```

```
#:>         one       two     three four   five
#:> a -0.155909 -0.501790  0.235569  bar  False
#:> b       NaN       NaN       NaN  NaN    NaN
#:> c -1.763605 -1.095862 -1.087766  bar  False
#:> d       NaN       NaN       NaN  NaN    NaN
#:> e -0.305170 -0.473748 -0.200595  bar  False
#:> f  0.355197  0.689518  0.410590  bar   True
#:> g       NaN       NaN       NaN  NaN    NaN
#:> h -0.564978  0.599391 -0.162936  bar  False
```

**How Missing Data For Each Column ?**


```python
df.count()
```

```
#:> one      5
#:> two      5
#:> three    5
#:> four     5
#:> five     5
#:> dtype: int64
```


```python
len(df.index) - df.count()
```

```
#:> one      0
#:> two      0
#:> three    0
#:> four     0
#:> five     0
#:> dtype: int64
```


```python
df.isnull()
```

```
#:>      one    two  three   four   five
#:> a  False  False  False  False  False
#:> c  False  False  False  False  False
#:> e  False  False  False  False  False
#:> f  False  False  False  False  False
#:> h  False  False  False  False  False
```


```python
df.describe()
```

```
#:>             one       two     three
#:> count  5.000000  5.000000  5.000000
#:> mean  -0.486893 -0.156498 -0.161028
#:> std    0.788635  0.772882  0.579752
#:> min   -1.763605 -1.095862 -1.087766
#:> 25%   -0.564978 -0.501790 -0.200595
#:> 50%   -0.305170 -0.473748 -0.162936
#:> 75%   -0.155909  0.599391  0.235569
#:> max    0.355197  0.689518  0.410590
```


