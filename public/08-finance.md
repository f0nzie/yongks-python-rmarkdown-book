# Finance






## Getting Data

### `pandas_datareder`

#### OHLC EOD Pricing

- HLOC columns are adjusted with splits  
- 'Adj Close' columns is adjusted with **split and dividends**  
- `start` and `end` date **must be string**


```python
import pandas_datareader as pdr
```


```python
pdr.data.DataReader('PUBM.KL',
                    start='2015-1-1', 
                    end='2019-12-31', 
                    data_source='yahoo')
```

```
#:>                  High        Low       Open      Close     Volume  Adj Close
#:> Date                                                                        
#:> 2015-01-02  18.280001  18.020000  18.260000  18.219999  1689000.0  15.345568
#:> 2015-01-05  18.240000  17.760000  18.240000  17.820000  2667800.0  15.008673
#:> 2015-01-06  17.799999  17.500000  17.780001  17.600000  5042600.0  14.823381
#:> 2015-01-07  17.700001  17.580000  17.600000  17.580000  4913200.0  14.806539
#:> 2015-01-08  17.680000  17.559999  17.580000  17.600000  4121100.0  14.823381
#:> ...               ...        ...        ...        ...        ...        ...
#:> 2019-12-24  20.020000  19.719999  20.000000  19.820000  1405800.0  19.361732
#:> 2019-12-26  19.860001  19.639999  19.820000  19.680000   600300.0  19.224972
#:> 2019-12-27  19.940001  19.660000  19.680000  19.879999  1325700.0  19.420345
#:> 2019-12-30  20.000000  19.780001  19.879999  19.980000  2180200.0  19.518034
#:> 2019-12-31  19.900000  19.400000  19.799999  19.440001  3430600.0  18.990520
#:> 
#:> [1239 rows x 6 columns]
```


#### Splits and Dividends

This method is similar to getting pricing data, except that different data_sources is used.


```python
pdr.DataReader('AAPL',
  data_source = 'yahoo-actions',
  start='2014-01-06', 
  end='2015-06-15'
)
```

```
#:>               action     value
#:> 2015-05-07  DIVIDEND  0.130000
#:> 2015-02-05  DIVIDEND  0.117500
#:> 2014-11-06  DIVIDEND  0.117500
#:> 2014-08-07  DIVIDEND  0.117500
#:> 2014-06-09     SPLIT  0.142857
#:> 2014-05-08  DIVIDEND  0.117500
#:> 2014-02-06  DIVIDEND  0.108930
```

#### Merging OHLC and Splits/Dividends


```python
prices = pdr.DataReader('AAPL',
  data_source = 'yahoo',
  start='2014-06-06', 
  end='2014-06-12'
)

actions = pdr.DataReader('AAPL',
  data_source = 'yahoo-actions',
  start='2014-06-06', 
  end='2014-06-12'
)
```

Use `pandas.merge()` function to combine both prices and splits dataframe in **a new dataframe**. Non matching line will have NaN.


```python
pd.merge(prices, actions, how='outer', left_index=True, right_index=True) \
  .loc[:,['High','Low','Open','Close','action','value']]
```

```
#:>                  High        Low       Open      Close action     value
#:> 2014-06-06  23.259285  23.016787  23.210714  23.056072    NaN       NaN
#:> 2014-06-09  23.469999  22.937500  23.174999  23.424999  SPLIT  0.142857
#:> 2014-06-10  23.762501  23.392500  23.682501  23.562500    NaN       NaN
#:> 2014-06-11  23.690001  23.367500  23.532499  23.465000    NaN       NaN
#:> 2014-06-12  23.530001  22.975000  23.510000  23.072500    NaN       NaN
```

Alternatively, use pandas column assignment from the splits dataframe into price dataframe, it will automatically 'merge' based on the **index**. This approach reuse existing dataframe instead of creating new one.


```python
prices['action'], prices['value'] = actions.action, actions.value
prices[['High','Low','Open','Close','action','value']]
```

```
#:>                  High        Low       Open      Close action     value
#:> Date                                                                   
#:> 2014-06-06  23.259285  23.016787  23.210714  23.056072    NaN       NaN
#:> 2014-06-09  23.469999  22.937500  23.174999  23.424999  SPLIT  0.142857
#:> 2014-06-10  23.762501  23.392500  23.682501  23.562500    NaN       NaN
#:> 2014-06-11  23.690001  23.367500  23.532499  23.465000    NaN       NaN
#:> 2014-06-12  23.530001  22.975000  23.510000  23.072500    NaN       NaN
```

#### Query Multiple Stocks

** When multiple symbols are supplied to DataReader, dictionary containing multiple stock's result are returned.


```python
stocks = ['MLYBY', 'AAPL']
my_dict = pdr.DataReader( stocks,
  data_source = 'yahoo-actions',
  start='2014-01-06', 
  end='2015-06-15'
)

print(my_dict.keys())
```

```
#:> dict_keys(['MLYBY', 'AAPL'])
```

Iterate through the dictionary to get the dataframe data


```python
for i in my_dict.items():
  print('\n\nStock: ', i[0],
        '\nDataFrame:', i[1])
```

```
#:> 
#:> 
#:> Stock:  MLYBY 
#:> DataFrame:               action  value
#:> 2015-04-22  DIVIDEND  0.178
#:> 2014-09-24  DIVIDEND  0.152
#:> 2014-04-29  DIVIDEND  0.192
#:> 
#:> 
#:> Stock:  AAPL 
#:> DataFrame:               action     value
#:> 2015-05-07  DIVIDEND  0.130000
#:> 2015-02-05  DIVIDEND  0.117500
#:> 2014-11-06  DIVIDEND  0.117500
#:> 2014-08-07  DIVIDEND  0.117500
#:> 2014-06-09     SPLIT  0.142857
#:> 2014-05-08  DIVIDEND  0.117500
#:> 2014-02-06  DIVIDEND  0.108930
```

### `yfinance`

[yFinance](https://github.com/ranaroussi/yfinance)

- Support Yahoo only, **a better alternative**  
- This library has advantage of calculating adjsuted OHLC by **split and dividends**. 
- Dividends and Splits are conveniently incorporated into pricing dataframe, so no manual merging necessary.  
- Multiple symbols are represented in columns  
- This library provides stock information (not all exchanges are supported though)  

#### Stock Info

There are plenty of infomration we can get form the dictionary of returend by `info`


```python
import yfinance as yf
stock = yf.Ticker('AAPL')
stock.info.keys()
```

```
#:> dict_keys(['zip', 'sector', 'fullTimeEmployees', 'longBusinessSummary', 'city', 'phone', 'state', 'country', 'companyOfficers', 'website', 'maxAge', 'address1', 'industry', 'previousClose', 'regularMarketOpen', 'twoHundredDayAverage', 'trailingAnnualDividendYield', 'payoutRatio', 'volume24Hr', 'regularMarketDayHigh', 'navPrice', 'averageDailyVolume10Day', 'totalAssets', 'regularMarketPreviousClose', 'fiftyDayAverage', 'trailingAnnualDividendRate', 'open', 'toCurrency', 'averageVolume10days', 'expireDate', 'yield', 'algorithm', 'dividendRate', 'exDividendDate', 'beta', 'circulatingSupply', 'startDate', 'regularMarketDayLow', 'priceHint', 'currency', 'trailingPE', 'regularMarketVolume', 'lastMarket', 'maxSupply', 'openInterest', 'marketCap', 'volumeAllCurrencies', 'strikePrice', 'averageVolume', 'priceToSalesTrailing12Months', 'dayLow', 'ask', 'ytdReturn', 'askSize', 'volume', 'fiftyTwoWeekHigh', 'forwardPE', 'fromCurrency', 'fiveYearAvgDividendYield', 'fiftyTwoWeekLow', 'bid', 'tradeable', 'dividendYield', 'bidSize', 'dayHigh', 'exchange', 'shortName', 'longName', 'exchangeTimezoneName', 'exchangeTimezoneShortName', 'isEsgPopulated', 'gmtOffSetMilliseconds', 'quoteType', 'symbol', 'messageBoardId', 'market', 'annualHoldingsTurnover', 'enterpriseToRevenue', 'beta3Year', 'profitMargins', 'enterpriseToEbitda', '52WeekChange', 'morningStarRiskRating', 'forwardEps', 'revenueQuarterlyGrowth', 'sharesOutstanding', 'fundInceptionDate', 'annualReportExpenseRatio', 'bookValue', 'sharesShort', 'sharesPercentSharesOut', 'fundFamily', 'lastFiscalYearEnd', 'heldPercentInstitutions', 'netIncomeToCommon', 'trailingEps', 'lastDividendValue', 'SandP52WeekChange', 'priceToBook', 'heldPercentInsiders', 'nextFiscalYearEnd', 'mostRecentQuarter', 'shortRatio', 'sharesShortPreviousMonthDate', 'floatShares', 'enterpriseValue', 'threeYearAverageReturn', 'lastSplitDate', 'lastSplitFactor', 'legalType', 'lastDividendDate', 'morningStarOverallRating', 'earningsQuarterlyGrowth', 'dateShortInterest', 'pegRatio', 'lastCapGain', 'shortPercentOfFloat', 'sharesShortPriorMonth', 'category', 'fiveYearAverageReturn', 'regularMarketPrice', 'logo_url'])
```

```python
print(stock.info['longName'])
```

```
#:> Apple Inc.
```

#### OHLC EOD Pricing

**Split Adjusted**  

- OHLC columns are adjusted with splits  (when `auto_adjust=False`)
- 'Adj Close' columns is adjusted with **split and dividends**  
- 'start' and 'end' date **must be string**


```python
stock = yf.Ticker('AAPL')
stock.history(  start='2014-06-06', end='2015-06-15', auto_adjust = False)
```

```
#:>                  Open       High        Low      Close  Adj Close     Volume  Dividends  \
#:> Date                                                                                      
#:> 2014-06-06  23.210714  23.259285  23.016787  23.056072  20.639763  349938400        0.0   
#:> 2014-06-09  23.174999  23.469999  22.937500  23.424999  20.970028  301660000        0.0   
#:> 2014-06-10  23.682501  23.762501  23.392500  23.562500  21.093121  251108000        0.0   
#:> 2014-06-11  23.532499  23.690001  23.367500  23.465000  21.005835  182724000        0.0   
#:> 2014-06-12  23.510000  23.530001  22.975000  23.072500  20.654472  218996000        0.0   
#:> ...               ...        ...        ...        ...        ...        ...        ...   
#:> 2015-06-08  32.224998  32.302502  31.707500  31.950001  29.103498  210699200        0.0   
#:> 2015-06-09  31.674999  32.020000  31.405001  31.855000  29.016962  224301600        0.0   
#:> 2015-06-10  31.980000  32.334999  31.962500  32.220001  29.349443  156349200        0.0   
#:> 2015-06-11  32.294998  32.544998  32.119999  32.147499  29.283403  141563600        0.0   
#:> 2015-06-12  32.047501  32.082500  31.777500  31.792500  28.960032  147544800        0.0   
#:> 
#:>             Stock Splits  
#:> Date                      
#:> 2014-06-06           0.0  
#:> 2014-06-09           7.0  
#:> 2014-06-10           0.0  
#:> 2014-06-11           0.0  
#:> 2014-06-12           0.0  
#:> ...                  ...  
#:> 2015-06-08           0.0  
#:> 2015-06-09           0.0  
#:> 2015-06-10           0.0  
#:> 2015-06-11           0.0  
#:> 2015-06-12           0.0  
#:> 
#:> [257 rows x 8 columns]
```

**Split and Dividends Adjusted**  

- OHLC columns are adjusted with splits and  **dividends**  (when `auto_adjust=True`)  
- Therefore, 'Adj Close' column is redundant, hence removed.


```python
import yfinance as yf
stock = yf.Ticker('AAPL')
stock.history(  start='2014-06-06', end='2015-06-15', auto_adjust = True)
```

```
#:>                  Open       High        Low      Close     Volume  Dividends  \
#:> Date                                                                           
#:> 2014-06-06  20.778198  20.821679  20.604594  20.639763  349938400        0.0   
#:> 2014-06-09  20.746228  21.010312  20.533619  20.970028  301660000        0.0   
#:> 2014-06-10  21.200545  21.272161  20.940937  21.093121  251108000        0.0   
#:> 2014-06-11  21.066260  21.207255  20.918553  21.005835  182724000        0.0   
#:> 2014-06-12  21.046122  21.064026  20.567191  20.654472  218996000        0.0   
#:> ...               ...        ...        ...        ...        ...        ...   
#:> 2015-06-08  29.353996  29.424594  28.882603  29.103498  210699200        0.0   
#:> 2015-06-09  28.852998  29.167263  28.607055  29.016962  224301600        0.0   
#:> 2015-06-10  29.130824  29.454196  29.114883  29.349443  156349200        0.0   
#:> 2015-06-11  29.417761  29.645488  29.258353  29.283403  141563600        0.0   
#:> 2015-06-12  29.192314  29.224196  28.946368  28.960032  147544800        0.0   
#:> 
#:>             Stock Splits  
#:> Date                      
#:> 2014-06-06           0.0  
#:> 2014-06-09           7.0  
#:> 2014-06-10           0.0  
#:> 2014-06-11           0.0  
#:> 2014-06-12           0.0  
#:> ...                  ...  
#:> 2015-06-08           0.0  
#:> 2015-06-09           0.0  
#:> 2015-06-10           0.0  
#:> 2015-06-11           0.0  
#:> 2015-06-12           0.0  
#:> 
#:> [257 rows x 7 columns]
```

#### Splits and Dividends

Getting both Splits and Dividends


```python
stock.actions
```

```
#:>             Dividends  Stock Splits
#:> Date                               
#:> 2014-06-09     0.0000           7.0
#:> 2014-08-07     0.1175           0.0
#:> 2014-11-06     0.1175           0.0
#:> 2015-02-05     0.1175           0.0
#:> 2015-05-07     0.1300           0.0
```

Getting Dividends Only


```python
stock.dividends
```

```
#:> Date
#:> 2014-08-07    0.1175
#:> 2014-11-06    0.1175
#:> 2015-02-05    0.1175
#:> 2015-05-07    0.1300
#:> Name: Dividends, dtype: float64
```

Getting Splits Only


```python
stock.splits
```

```
#:> Date
#:> 2014-06-09    7.0
#:> Name: Stock Splits, dtype: float64
```

#### Query Using Periods

Available periods are: 1d, 5d, 1mo, 3mo, 6mo, 1y, 2y, 5y, 10y, ytd, **max**


```python
stock = yf.Ticker('AAPL')
stock.history(periods='max')
```

```
#:>                   Open        High         Low       Close     Volume  Dividends  \
#:> Date                                                                               
#:> 2020-10-20  115.999868  118.775087  115.430850  117.307617  124423700        0.0   
#:> 2020-10-21  116.469064  118.505551  116.249442  116.668724   89946000        0.0   
#:> 2020-10-22  117.247713  117.836701  114.392638  115.550644  101988000        0.0   
#:> 2020-10-23  116.189547  116.349275  114.083180  114.841873   82572600        0.0   
#:> 2020-10-26  113.813643  116.349269  112.685584  114.851852  111850700        0.0   
#:> ...                ...         ...         ...         ...        ...        ...   
#:> 2020-11-16  118.919998  120.989998  118.150002  120.300003   91183000        0.0   
#:> 2020-11-17  119.550003  120.669998  118.959999  119.389999   74271000        0.0   
#:> 2020-11-18  118.610001  119.820000  118.000000  118.029999   76322100        0.0   
#:> 2020-11-19  117.589996  119.059998  116.809998  118.639999   73860200        0.0   
#:> 2020-11-20  118.639999  118.769997  117.500000  117.610001   54692629        0.0   
#:> 
#:>             Stock Splits  
#:> Date                      
#:> 2020-10-20             0  
#:> 2020-10-21             0  
#:> 2020-10-22             0  
#:> 2020-10-23             0  
#:> 2020-10-26             0  
#:> ...                  ...  
#:> 2020-11-16             0  
#:> 2020-11-17             0  
#:> 2020-11-18             0  
#:> 2020-11-19             0  
#:> 2020-11-20             0  
#:> 
#:> [24 rows x 7 columns]
```
#### Query Multiple Stocks

- **Use `download()` function to query multiple stocks.  
- By default, it is grouped by column. Access data in `result['Column']['Symbol']`  
- To group by **Symbol**, use `group_by` parameter.  With this, access data in `result['Symbol']['Column']`  
- By default, `threads=True` for parallel downloading.


```python
stocks = ['MLYBY','AAPL']
df1 = yf.download(stocks, start='2014-06-06', end='2014-06-15')
```

```
#:> [                       0%                       ][*********************100%***********************]  2 of 2 completed
```

```python
df2 = yf.download(stocks, start='2014-06-06', end='2014-06-15', group_by='ticker')
```

```
#:> [                       0%                       ][*********************100%***********************]  2 of 2 completed
```

```python
print('Group by Column Name:\n', df1['Close']['AAPL'], '\n\n',
      'Group by Symbol:     ]n', df2['AAPL']['Close'])
```

```
#:> Group by Column Name:
#:>  Date
#:> 2014-06-06    23.056072
#:> 2014-06-09    23.424999
#:> 2014-06-10    23.562500
#:> 2014-06-11    23.465000
#:> 2014-06-12    23.072500
#:> 2014-06-13    22.820000
#:> Name: AAPL, dtype: float64 
#:> 
#:>  Group by Symbol:     ]n Date
#:> 2014-06-06    23.056072
#:> 2014-06-09    23.424999
#:> 2014-06-10    23.562500
#:> 2014-06-11    23.465000
#:> 2014-06-12    23.072500
#:> 2014-06-13    22.820000
#:> Name: Close, dtype: float64
```


### `world trading`

#### OHLC EOD Pricing




## Charting


```python
import cufflinks as cf  # Cufflinks
#cf.set_config_file(offline=True)  # set the plotting mode to offline
```


### Price Comparison


```python
stocks = ['XOM']
df = yf.download(stocks, start='2020-01-01', end='2020-01-30')
df['Close']
df.iplot()
```

```python
stocks = ['CVX']
df = yf.download(stocks, start='2019-01-01', end='2019-12-31')
df['Close']
df.iplot()
```



```python
# stocks = ['AAPL','MLYBY', 'PUBM.KL', 'HLFBF','1295.KL']
# stocks = ['AAPL','MLYBY', 'PUBM.KL', 'HLFBF']
stocks = ['AAPL']
df = yf.download(stocks, start='2020-01-01', end='2020-01-30')
df['Close']
df.iplot()
```


```python
stock = yf.Ticker('PUBM.KL')
#stock.history(periods='max')
stock.history(  start='2014-06-06', end='2015-06-15', auto_adjust = True)
```


```python
stock = yf.Ticker('1295.KL')
stock.history(  start='2014-06-06', end='2015-06-15', auto_adjust = True)
```


```python
stocks = ['MLYBY']
df = yf.download('MLYBY', start='2018-12-03', end='2019-03-21')
df
```

