# Web Scrapping






## `requests`


### Creating A Session


```python
import requests
from requests.adapters import HTTPAdapter
from urllib3.util.retry import Retry
import random


_retries = Retry(connect=10,read=10,backoff_factor=1)   # backoff is incremental interval in seconds between retries
_timeout = (10,10)  ## connect, read timeout in seconds

rqs = requests.Session()
rqs.mount( 'http://' ,  HTTPAdapter(max_retries= _retries))
rqs.mount( 'https://' , HTTPAdapter(max_retries= _retries))
```



```python
link1 = 'https://www.yahoo.com'
link2 = 'http://mamamia777.com.au'
#user_agent = {'User-Agent': random.choice(_USER_AGENTS)}
#response1  = rqs.get(link1, timeout=_timeout)
#response2  = rqs.get(link2, timeout=_timeout)  
```



```python
print (page1.status_code)
```

### Rotating Broswer


```python
_USER_AGENTS = [
   #Chrome
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',
    'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36',
    'Mozilla/5.0 (Windows NT 5.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36',
    'Mozilla/5.0 (Windows NT 6.2; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36',
    'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36',
    'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36',
    'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36',
    'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',
    'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36',
    #Firefox
    'Mozilla/4.0 (compatible; MSIE 9.0; Windows NT 6.1)',
    'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko',
    'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; WOW64; Trident/5.0)',
    'Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko',
    'Mozilla/5.0 (Windows NT 6.2; WOW64; Trident/7.0; rv:11.0) like Gecko',
    'Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko',
    'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.0; Trident/5.0)',
    'Mozilla/5.0 (Windows NT 6.3; WOW64; Trident/7.0; rv:11.0) like Gecko',
    'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)',
    'Mozilla/5.0 (Windows NT 6.1; Win64; x64; Trident/7.0; rv:11.0) like Gecko',
    'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; WOW64; Trident/6.0)',
    'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)',
    'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 2.0.50727; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729)']
```


## `BeautifulSoup`

### Module Import


```python
from bs4 import BeautifulSoup
```

### HTML Tag Parsing 

#### Sample Data


```python
my_html = '''
<div id="my-id1" class='title'> 
    <p>This Is My Title</p>
    
    <div id="my-id2" class='subtitle' custom_attr='funny'>
        <p>This is Subtitle</p>
    </div>
    
    <div id="my-id3" class='title',   custom_attr='funny'>
        <p>This is paragraph1</p>
        <p>This is paragraph2</p>
        <h3>This is paragraph3</h3>
    </div>
</div>
'''
soup = BeautifulSoup(my_html)
```

#### First Match

**ID Selector**  
Everthing under the selected tag will be returned.


```python
soup.find(id='my-id1')
```

```
#:> <div class="title" id="my-id1">
#:> <p>This Is My Title</p>
#:> <div class="subtitle" custom_attr="funny" id="my-id2">
#:> <p>This is Subtitle</p>
#:> </div>
#:> <div class="title" custom_attr="funny" id="my-id3">
#:> <p>This is paragraph1</p>
#:> <p>This is paragraph2</p>
#:> <h3>This is paragraph3</h3>
#:> </div>
#:> </div>
```

**Class Selector**


```python
soup.find(class_='subtitle')
```

```
#:> <div class="subtitle" custom_attr="funny" id="my-id2">
#:> <p>This is Subtitle</p>
#:> </div>
```

**Attribute Selector**


```python
soup.find(custom_attr='funny')
```

```
#:> <div class="subtitle" custom_attr="funny" id="my-id2">
#:> <p>This is Subtitle</p>
#:> </div>
```


```python
soup.find(       custom_attr='funny')
```

```
#:> <div class="subtitle" custom_attr="funny" id="my-id2">
#:> <p>This is Subtitle</p>
#:> </div>
```

```python
soup.find('div', custom_attr='funny')
```

```
#:> <div class="subtitle" custom_attr="funny" id="my-id2">
#:> <p>This is Subtitle</p>
#:> </div>
```


#### Find All Matches

**`find_all`**  


```python
soup = BeautifulSoup(my_html)
multiple_result = soup.find_all(class_='title')
print( 'Item 0: \n',     multiple_result[0],
       '\n\nItem 1: \n', multiple_result[1])
```

```
#:> Item 0: 
#:>  <div class="title" id="my-id1">
#:> <p>This Is My Title</p>
#:> <div class="subtitle" custom_attr="funny" id="my-id2">
#:> <p>This is Subtitle</p>
#:> </div>
#:> <div class="title" custom_attr="funny" id="my-id3">
#:> <p>This is paragraph1</p>
#:> <p>This is paragraph2</p>
#:> <h3>This is paragraph3</h3>
#:> </div>
#:> </div> 
#:> 
#:> Item 1: 
#:>  <div class="title" custom_attr="funny" id="my-id3">
#:> <p>This is paragraph1</p>
#:> <p>This is paragraph2</p>
#:> <h3>This is paragraph3</h3>
#:> </div>
```

**CSS Selector using `select()`**  

Above can be achieved using css selector. It return an array of result (multiple matches).


```python
multiple_result = soup.select('.title')
print( 'Item 0: \n',     multiple_result[0],
       '\n\nItem 1: \n', multiple_result[1])
```

```
#:> Item 0: 
#:>  <div class="title" id="my-id1">
#:> <p>This Is My Title</p>
#:> <div class="subtitle" custom_attr="funny" id="my-id2">
#:> <p>This is Subtitle</p>
#:> </div>
#:> <div class="title" custom_attr="funny" id="my-id3">
#:> <p>This is paragraph1</p>
#:> <p>This is paragraph2</p>
#:> <h3>This is paragraph3</h3>
#:> </div>
#:> </div> 
#:> 
#:> Item 1: 
#:>  <div class="title" custom_attr="funny" id="my-id3">
#:> <p>This is paragraph1</p>
#:> <p>This is paragraph2</p>
#:> <h3>This is paragraph3</h3>
#:> </div>
```

More granular exmaple of css selector.


```python
soup.select('#my-id1 div.subtitle')
```

```
#:> [<div class="subtitle" custom_attr="funny" id="my-id2">
#:> <p>This is Subtitle</p>
#:> </div>]
```

Using **`contains()`**


```python
soup.select("p:contains('This is paragraph')")
```

```
#:> [<p>This is paragraph1</p>, <p>This is paragraph2</p>]
```
Combining ID, Class and Custom Attribute in the selector


```python
soup.select("div#my-id3.title[custom_attr='funny']:contains('This is paragraph')")
```

```
#:> [<div class="title" custom_attr="funny" id="my-id3">
#:> <p>This is paragraph1</p>
#:> <p>This is paragraph2</p>
#:> <h3>This is paragraph3</h3>
#:> </div>]
```

### Meta Parsing


```python
my_meta = '''
<meta property="description"   content="KUALA LUMPUR: blah blah"   category="Malaysia">
<meta property="publish-date"  content="2012-01-03">
'''
soup = BeautifulSoup(my_meta)
soup.find('meta', property='description')['content']
```

```
#:> 'KUALA LUMPUR: blah blah'
```

```python
soup.find('meta', property='description')['category']
```

```
#:> 'Malaysia'
```

```python
soup.find('meta', property='publish-date')['content']
```

```
#:> '2012-01-03'
```

```python
soup.find('meta', category='Malaysia')['property']
```

```
#:> 'description'
```

### Getting Content 

#### Get Content `get_text(strip=, separator=)`

- Use **`strip=True`** to strip whitespace from the beginning and end of each bit of text  
- Use **`separator='\\n'** to specify a string to be used to join the bits of text together
- It is recommended to use `strip=True, separator='\n'` so that result from different operating system will be consistant  


```python
soup = BeautifulSoup(my_html)
elem = soup.find(id = "my-id3")
elem.get_text(strip=False)
```

```
#:> '\nThis is paragraph1\nThis is paragraph2\nThis is paragraph3\n'
```

- strip=True combine with separator will retain only the user readable text portion of each tag, with separator seperating them


```python
elem.get_text(strip=True, separator='\n')
```

```
#:> 'This is paragraph1\nThis is paragraph2\nThis is paragraph3'
```

#### Splitting Content

It is useful to split using separator into list of string.


```python
elem = soup.find(id = "my-id3")
elem.get_text(strip=True, separator='\n').split('\n')
```

```
#:> ['This is paragraph1', 'This is paragraph2', 'This is paragraph3']
```

### Traversing

#### Get The Element


```python
elems = soup.select("div#my-id3.title[custom_attr='funny']:contains('This is paragraph')")
elem = elems[0]
elem
```

```
#:> <div class="title" custom_attr="funny" id="my-id3">
#:> <p>This is paragraph1</p>
#:> <p>This is paragraph2</p>
#:> <h3>This is paragraph3</h3>
#:> </div>
```

#### Traversing Children

**All Children In List  `findChildren()`**


```python
elem.findChildren()
```

```
#:> [<p>This is paragraph1</p>, <p>This is paragraph2</p>, <h3>This is paragraph3</h3>]
```

**Next Children `findNext()`**  

- If the element has children, this will get the immediate child  
- If the element has no children, this will find the next element in the hierechy  


```python
first_child = elem.fin
print( 
elem.findNext().get_text(strip=True), '\n', 
elem.findNext().findNext().get_text(strip=True), '\n')
```

```
#:> This is paragraph1 
#:>  This is paragraph2
```

#### Traversing To Parent `parent()`


```python
elem_parent = elem.parent
elem_parent.attrs
```

```
#:> {'id': 'my-id1', 'class': ['title']}
```

#### Get The Sibling `findPreviousSibling()`

Sibling is element at the same level of hierachy


```python
elem_prev_sib = elem.findPreviousSibling()
elem_prev_sib.attrs
```

```
#:> {'id': 'my-id2', 'class': ['subtitle'], 'custom_attr': 'funny'}
```

