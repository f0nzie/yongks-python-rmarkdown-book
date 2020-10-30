# NLP
Natural Language Processing







## Regular Expression
- Rgular expressions (called REs or regexes) is mandatory skill for NLP. The `re` is a **built-in* library  
- It is essentially a tiny, highly specialized programming language embedded inside Python and made available through the re module  
- Regular expression patterns are compiled into a series of bytecodes which are then executed by a matching engine written in C  

### Syntax
There are two methods to emply re. Below method compile a regex first, then apply it multiple times in subsequent code.


```python
import re
pattern = re.compile(r'put pattern here')
pattern.match('put text here')
```

Second method below employ compile and match in single line. The pattern cannot be reused, therefore good for onetime usage only.


```python
import re
pattern = (r'put pattern here')
re.match(pattern, r'put text here')  # compile and match in single line
```

### Finding

#### Find The First Match
There are two ways to find the first match:  
- **`re.search`** find first match anywhere in text, including multiline  
- **`re.match`** find first match at the BEGINNING of text, similar to `re.search`with `^`  
- Both returns first match, return  **MatchObject**  
- Both returns **None** if no match is found  


```python
pattern1 = re.compile('123') 
pattern2 = re.compile('123')
pattern3 = re.compile('^123')  # equivalent to above
text = 'abc123xyz'

## Single Line Text Example
print( 're.search found a match somewhere:\n',
       pattern1.search(text), '\n', ## found
       '\nre.match did not find anything at the beginning:\n',
       pattern2.match(text), '\n',
       '\nre.search did not find anything at beginning too:\n',
       pattern3.search(text))        ## None
```

```
#:> re.search found a match somewhere:
#:>  <re.Match object; span=(3, 6), match='123'> 
#:>  
#:> re.match did not find anything at the beginning:
#:>  None 
#:>  
#:> re.search did not find anything at beginning too:
#:>  None
```

Returned **MatchObject** provides useful information about the matched string.


```python
age_pattern = re.compile(r'\d+')
age_text    = 'Ali is my teacher. He is 109 years old. his kid is 40 years old.'
first_found = age_pattern.search(age_text)

print('Found Object:           ', first_found,
      '\nInput Text:             ', first_found.string,
      '\nInput Pattern:          ', first_found.re,
      '\nFirst Found string:     ', first_found.group(),
      '\nFound Start Position:   ', first_found.start(),
      '\nFound End Position:     ', first_found.end(),
      '\nFound Span:             ', first_found.span(),)
```

```
#:> Found Object:            <re.Match object; span=(25, 28), match='109'> 
#:> Input Text:              Ali is my teacher. He is 109 years old. his kid is 40 years old. 
#:> Input Pattern:           re.compile('\\d+') 
#:> First Found string:      109 
#:> Found Start Position:    25 
#:> Found End Position:      28 
#:> Found Span:              (25, 28)
```

#### Find All Matches

**`findall()`** returns all matching string as **list**. If no matches found, it return an empty list.


```python
print(
  'Finding Two Digits:',
  re.findall(r'\d\d','abc123xyz456'), '\n',
  '\nFound Nothing:',
  re.findall(r'\d\d','abcxyz'))
```

```
#:> Finding Two Digits: ['12', '45'] 
#:>  
#:> Found Nothing: []
```

### Matching Condition

#### Meta Characters

```
[]     match any single character within the bracket
[1234] is the same as [1-4]
[0-39] is the same as [01239]
[a-e]  is the same as [abcde]
[^abc] means any character except a,b,c
[^0-9] means any character except 0-9
a|b:   a or b
{n,m}  at least n repetition, but maximum m repetition
()     grouping
```



```python
pattern = re.compile(r'[a-z]+')
text1 = "tempo"
text2 = "tempo1"
text3 = "123 tempo1"
text4 = " tempo"
print(
  'Matching Text1:', pattern.match(text1),
  '\nMatching Text2:', pattern.match(text2),
  '\nMatching Text3:', pattern.match(text3),
  '\nMatching Text4:', pattern.match(text4))
```

```
#:> Matching Text1: <re.Match object; span=(0, 5), match='tempo'> 
#:> Matching Text2: <re.Match object; span=(0, 5), match='tempo'> 
#:> Matching Text3: None 
#:> Matching Text4: None
```


#### Special Sequence

```
. : [^\n]
\d: [0-9]              \D: [^0-9]
\s: [ \t\n\r\f\v]      \S: [^ \t\n\r\f\v]
\w: [a-zA-Z0-9_]       \W: [^a-zA-Z0-9_]
\t: tab
\n: newline
\b: word boundry (delimited by space, \t, \n)
```

**Word Boundary Using `\b`**:  

- `\bABC` match if specified characters at the beginning of word (delimited by space, `\t`, `\n`), or beginning of newline  
- `ABC\b` match if specified characters at the end of word (delimited by space, `\t`, `\n`), or end of the line  


```python
text = "ABCD ABC XYZABC"
pattern1 = re.compile(r'\bABC')
pattern2 = re.compile(r'ABC\b')
pattern3 = re.compile(r'\bABC\b')

print('Match word that begins ABC:',
  pattern1.findall(text), '\n',
  'Match word that ends with ABC:',
  pattern2.findall(text),'\n',
  'Match isolated word with ABC:',
  pattern3.findall(text))
```

```
#:> Match word that begins ABC: ['ABC', 'ABC'] 
#:>  Match word that ends with ABC: ['ABC', 'ABC'] 
#:>  Match isolated word with ABC: ['ABC']
```

#### Repetition

When repetition is used, re will be **greedy**; it try to repeat as many times as possible. If **later portions of the pattern don’t match**, the matching engine will then **back up and try again** with fewer repetitions.

```
?:    zero or 1 occurance
*:    zero or more occurance
+:    one  or more occurance
```

**`?` Zero or 1 Occurance**


```python
text = 'abcbcdd'
pattern = re.compile(r'a[bcd]?b')
pattern.findall(text)
```

```
#:> ['ab']
```

**`+` At Least One Occurance**


```python
text = 'abcbcdd'
pattern = re.compile(r'a[bcd]+b')
pattern.findall(text)
```

```
#:> ['abcb']
```

**`*` Zero Or More Occurance Occurance**


```python
text = 'abcbcdd'
pattern = re.compile(r'a[bcd]*b')
pattern.findall(text)
```

```
#:> ['abcb']
```

#### Greedy vs Non-Greedy

- The `*`, `+`, and `?` qualifiers are all greedy; they match as much text as possible  
- If the `<.*>` is matched against `<a> b <c>`, it will match the entire string, and not just `<a>`  
- Adding **`?`** after the qualifier makes it perform the match in non-greedy; as few characters as possible will be matched. Using the RE <.*?> will match only '<a>'


```python
text = '<a> ali baba <c>'
greedy_pattern     = re.compile(r'<.*>')
non_greedy_pattern = re.compile(r'<.*?>')
print( 'Greedy:      ' ,        greedy_pattern.findall(text), '\n',
       'Non Greedy: ', non_greedy_pattern.findall(text) )
```

```
#:> Greedy:       ['<a> ali baba <c>'] 
#:>  Non Greedy:  ['<a>', '<c>']
```

### Grouping

When `()` is used in the pattern, retrive the grouping components in MatchObject with `.groups()`. Result is in list. Example below extract hours, minutes and am/pm into a list.

#### Capturing Group


```python
text = 'Today at Wednesday, 10:50pm, we go for a walk'
pattern = re.compile(r'(\d\d):(\d\d)(am|pm)')
m = pattern.search(text)
print(
  'All Gropus: ', m.groups(), '\n',
  'Group 1: ', m.group(1), '\n',
  'Group 2: ', m.group(2), '\n',
  'Group 3: ', m.group(3) )
```

```
#:> All Gropus:  ('10', '50', 'pm') 
#:>  Group 1:  10 
#:>  Group 2:  50 
#:>  Group 3:  pm
```

#### Non-Capturing Group

Having `(:? )` means don't capture this group


```python
text = 'Today at Wednesday, 10:50pm, we go for a walk'
pattern = re.compile(r'(:?\d\d):(?:\d\d)(am|pm)')
m = pattern.search(text)
print(
  'All Gropus: ', m.groups(), '\n',
  'Group 1: ', m.group(1), '\n',
  'Group 2: ', m.group(2) )
```

```
#:> All Gropus:  ('10', 'pm') 
#:>  Group 1:  10 
#:>  Group 2:  pm
```

### Splittitng

Pattern is used to match **delimters**.

#### Use `re.split()`


```python
print( re.split('@',  "aa@bb @ cc "), '\n',
       re.split('\|', "aa|bb | cc "), '\n',
       re.split('\n', "sentence1\nsentence2\nsentence3") )
```

```
#:> ['aa', 'bb ', ' cc '] 
#:>  ['aa', 'bb ', ' cc '] 
#:>  ['sentence1', 'sentence2', 'sentence3']
```

#### Use `re.compile().split()`


```python
pattern = re.compile(r"\|")
pattern.split("aa|bb | cc ")
```

```
#:> ['aa', 'bb ', ' cc ']
```

### Substitution `re.sub()`


#### Found Match

Example below repalce anything within `{{.*}}`

```python
re.sub(r'({{.*}})', 'Durian', 'I like to eat {{Food}}.', flags=re.IGNORECASE)
```

```
#:> 'I like to eat Durian.'
```

Replace ` AND ` with ` & `. This does not require `()` grouping

```python
re.sub(r'\sAND\s', ' & ', 'Baked Beans And Spam', flags=re.IGNORECASE)
```

```
#:> 'Baked Beans & Spam'
```

#### No Match

If not pattern not found, return the original text.

```python
re.sub(r'({{.*}})', 'Durian', 'I like to eat <Food>.', flags=re.IGNORECASE)
```

```
#:> 'I like to eat <Food>.'
```
### Practical Examples

#### Extracting Float


```python
re_float = re.compile(r'\d+(\.\d+)?')
def extract_float(x):
    money = x.replace(',','')
    result = re_float.search(money)
    return float(result.group()) if result else float(0)

print( extract_float('123,456.78'), '\n',
       extract_float('rm 123.78 (30%)'), '\n',
       extract_float('rm 123,456.78 (30%)') )
```

```
#:> 123456.78 
#:>  123.78 
#:>  123456.78
```
## Word Tokenizer

### Custom Tokenizer

#### Split By Regex Pattern

Use **regex** to split words based on **specific punctuation as delimeter**.  
The rule is: split input text when any one or more continuous occurances of specified character.


```python
import re
pattern = re.compile(r"[-\s.,;!?]+")
pattern.split("hi @ali--baba, you are aweeeeeesome! isn't it. Believe it.:)")
```

```
#:> ['hi', '@ali', 'baba', 'you', 'are', 'aweeeeeesome', "isn't", 'it', 'Believe', 'it', ':)']
```

#### Pick By Regex Pattern `nltk.tokenize.RegexpTokenizer`

Any sequence of chars fall within the bracket are considered tokens. Any chars not within the bracket are removed.


```python
from nltk.tokenize import RegexpTokenizer
my_tokenizer = RegexpTokenizer(r'[a-zA-Z0-9\']+')
my_tokenizer.tokenize("hi @ali--baba, you are aweeeeeesome! isn't it. Believe it.:")
```

```
#:> ['hi', 'ali', 'baba', 'you', 'are', 'aweeeeeesome', "isn't", 'it', 'Believe', 'it']
```

### `nltk.tokenize.word_tokenize()`

Words and punctuations are considered as tokens!


```python
import nltk
nltk.download('punkt')
```

```
#:> True
#:> 
#:> [nltk_data] Downloading package punkt to /home/msfz751/nltk_data...
#:> [nltk_data]   Package punkt is already up-to-date!
```



```python
from nltk.tokenize import word_tokenize
print( word_tokenize("hi @ali-baba, you are aweeeeeesome! isn't it. Believe it.:)") )
```

```
#:> ['hi', '@', 'ali-baba', ',', 'you', 'are', 'aweeeeeesome', '!', 'is', "n't", 'it', '.', 'Believe', 'it', '.', ':', ')']
```

### `nltk.tokenize.casual.casual_tokenize()`

- Support emoji
- Support reduction of repetition chars
- Support removing userid (\@someone)
- Good for social media text
- Punctuations are tokens!


```python
from nltk.tokenize.casual     import casual_tokenize
print( casual_tokenize("hi @ali-baba, you are aweeeeeesome! isn't it. Believe it. :)") )  
```

```
#:> ['hi', '@ali', '-', 'baba', ',', 'you', 'are', 'aweeeeeesome', '!', "isn't", 'it', '.', 'Believe', 'it', '.', ':)']
```

Example below shorten repeating chars, notice aweeeeeesome becomes aweeesome


```python
## shorten repeated chars
print( casual_tokenize("hi @ali-baba, you are aweeeeeesome! isn't it. Believe it.:)", 
          reduce_len=True))     
```

```
#:> ['hi', '@ali', '-', 'baba', ',', 'you', 'are', 'aweeesome', '!', "isn't", 'it', '.', 'Believe', 'it', '.', ':)']
```

Stripping off User ID


```python
## shorten repeated chars, stirp usernames
print( casual_tokenize("hi @ali-baba, you are aweeeeeesome! isn't it. Believe it.:)", 
          reduce_len=True,      
          strip_handles=True))  
```

```
#:> ['hi', '-', 'baba', ',', 'you', 'are', 'aweeesome', '!', "isn't", 'it', '.', 'Believe', 'it', '.', ':)']
```

### `nltk.tokenize.treebank.TreebankWordTokenizer().tokenize()`

Treebank assume input text is **A sentence**, hence any period combined with word is treated as token.


```python
from nltk.tokenize.treebank   import TreebankWordTokenizer
TreebankWordTokenizer().tokenize("hi @ali-baba, you are aweeeeeesome! isn't it. Believe it.:)")
```

```
#:> ['hi', '@', 'ali-baba', ',', 'you', 'are', 'aweeeeeesome', '!', 'is', "n't", 'it.', 'Believe', 'it.', ':', ')']
```

### Corpus Token Extractor

A corpus is a collection of documents (list of documents). 
A document is a text string containing one or many sentences.


```python
from nltk.tokenize import word_tokenize
from nlpia.data.loaders import harry_docs as corpus
```


```python
## Tokenize each doc to list, then add to a bigger list
doc_tokens=[]
for doc in corpus:
  doc_tokens += [word_tokenize(doc.lower())]

print('Corpus (Contain 3 Documents):\n',corpus,'\n',
      '\nTokenized result for each document:','\n',doc_tokens)
```

```
#:> Corpus (Contain 3 Documents):
#:>  ['The faster Harry got to the store, the faster and faster Harry would get home.', 'Harry is hairy and faster than Jill.', 'Jill is not as hairy as Harry.'] 
#:>  
#:> Tokenized result for each document: 
#:>  [['the', 'faster', 'harry', 'got', 'to', 'the', 'store', ',', 'the', 'faster', 'and', 'faster', 'harry', 'would', 'get', 'home', '.'], ['harry', 'is', 'hairy', 'and', 'faster', 'than', 'jill', '.'], ['jill', 'is', 'not', 'as', 'hairy', 'as', 'harry', '.']]
```

Unpack list of token lists from above using sum. To get the **vocabulary** (unique tokens), **convert list to set**.


```python
## unpack list of list to list
vocab = sum(doc_tokens,[])
print('\nCorpus Vacabulary (Unique Tokens):\n',
       sorted(set(vocab)))
```

```
#:> 
#:> Corpus Vacabulary (Unique Tokens):
#:>  [',', '.', 'and', 'as', 'faster', 'get', 'got', 'hairy', 'harry', 'home', 'is', 'jill', 'not', 'store', 'than', 'the', 'to', 'would']
```

## Sentence Tokenizer

This is about detecting sentence boundry and split text into list of sentences

### Sample Text


```python
text = '''
Hello Mr. Smith, how are you doing today?
The weather is great, and city is awesome.
The sky is pinkish-blue, Dr. Alba would agree.
You shouldn't eat hard things i.e. cardboard, stones and bushes
'''
```

### 'nltk.tokenize.punkt.PunktSentenceTokenizer`

- The `PunktSentenceTokenizer` is an sentence boundary detection algorithm. It is an unsupervised trainable model. This means it can be trained on unlabeled data, aka text that is not split into sentences  
- PunkSentneceTokenizer is based on work published on this paepr: [Unsupervised Multilingual Sentence Boundary Detection](https://www.mitpressjournals.org/doi/abs/10.1162/coli.2006.32.4.485#.V2ouLXUrLeQ)

#### Default Behavior

Vanila tokenizer splits sentences on period `.`, which is not desirable


```python
from nltk.tokenize.punkt import PunktSentenceTokenizer, PunktTrainer
#nltk.download('punkt')
tokenizer = PunktSentenceTokenizer()
tokenized_text = tokenizer.tokenize(text) 
for x in tokenized_text:
  print(x) 
```

```
#:> 
#:> Hello Mr.
#:> Smith, how are you doing today?
#:> The weather is great, and city is awesome.
#:> The sky is pinkish-blue, Dr.
#:> Alba would agree.
#:> You shouldn't eat hard things i.e.
#:> cardboard, stones and bushes
```

#### Pretrained Model - English Pickle

NLTK already includes a pre-trained version of the PunktSentenceTokenizer for English, as you can see, it is quite good


```python
tokenizer      = nltk.data.load('tokenizers/punkt/english.pickle')
tokenized_text = tokenizer.tokenize(text) 
for x in tokenized_text:
  print(x) 
```

```
#:> 
#:> Hello Mr. Smith, how are you doing today?
#:> The weather is great, and city is awesome.
#:> The sky is pinkish-blue, Dr. Alba would agree.
#:> You shouldn't eat hard things i.e.
#:> cardboard, stones and bushes
```

#### Adding Abbreviations

- The pretrained tokenizer is not perfect, it wrongly detected 'i.e.' as sentence boundary  
- Let's **teach** Punkt by adding the abbreviation to its parameter

**Adding Single Abbreviation**


```python

tokenizer      = nltk.data.load('tokenizers/punkt/english.pickle')

## Add apprevaitions to Tokenizer
tokenizer._params.abbrev_types.add('i.e')

tokenized_text = tokenizer.tokenize(text) 
for x in tokenized_text:
  print(x)
```

```
#:> 
#:> Hello Mr. Smith, how are you doing today?
#:> The weather is great, and city is awesome.
#:> The sky is pinkish-blue, Dr. Alba would agree.
#:> You shouldn't eat hard things i.e. cardboard, stones and bushes
```

**Add List of Abbreviations**

If you have more than one abbreviations, use `update()`  with the list of abbreviations


```python
from nltk.tokenize.punkt import PunktSentenceTokenizer, PunktParameters

## Add Abbreviations to Tokenizer
tokenizer =  nltk.data.load('tokenizers/punkt/english.pickle')
tokenizer._params.abbrev_types.update(['dr', 'vs', 'mr', 'mrs', 'prof', 'inc', 'i.e'])

sentences = tokenizer.tokenize(text) 
for x in sentences:
  print(x) 
```

```
#:> 
#:> Hello Mr. Smith, how are you doing today?
#:> The weather is great, and city is awesome.
#:> The sky is pinkish-blue, Dr. Alba would agree.
#:> You shouldn't eat hard things i.e. cardboard, stones and bushes
```

### `nltk.tokenize.sent_tokenize()`

The `sent_tokenize` function uses an instance of **PunktSentenceTokenizer**, which is already been trained and thus very well knows to mark the end and begining of sentence at what characters and punctuation.
 

```python
from nltk.tokenize import sent_tokenize

sentences = sent_tokenize(text)
for x in sentences:
  print(x) 
```

```
#:> 
#:> Hello Mr. Smith, how are you doing today?
#:> The weather is great, and city is awesome.
#:> The sky is pinkish-blue, Dr. Alba would agree.
#:> You shouldn't eat hard things i.e. cardboard, stones and bushes
```

## N-Gram

To create n-gram, first create 1-gram token


```python
from nltk.util import ngrams 
import re
sentence = "Thomas Jefferson began building the city, at the age of 25"
pattern = re.compile(r"[-\s.,;!?]+")
tokens = pattern.split(sentence)
print(tokens)
```

```
#:> ['Thomas', 'Jefferson', 'began', 'building', 'the', 'city', 'at', 'the', 'age', 'of', '25']
```

**ngrams()** is a generator, therefore, use **list()** to convert into full list


```python
ngrams(tokens,2)
```

```
#:> <generator object ngrams at 0x7f2046ea5c50>
```

Convert 1-gram to 2-Gram, wrap into list


```python
grammy = list( ngrams(tokens,2) )
print(grammy)
```

```
#:> [('Thomas', 'Jefferson'), ('Jefferson', 'began'), ('began', 'building'), ('building', 'the'), ('the', 'city'), ('city', 'at'), ('at', 'the'), ('the', 'age'), ('age', 'of'), ('of', '25')]
```

Combine each 2-gram into a string object


```python
[ " ".join(x) for x in grammy]
```

```
#:> ['Thomas Jefferson', 'Jefferson began', 'began building', 'building the', 'the city', 'city at', 'at the', 'the age', 'age of', 'of 25']
```

## Stopwords

### Custom Stop Words

Build the custom stop words dictionary.


```python
stop_words = ['a','an','the','on','of','off','this','is','at']
```

Tokenize text and remove stop words


```python
sentence = "The house is on fire"
tokens   = word_tokenize(sentence)
tokens_without_stopwords = [ x for x in tokens if x not in stop_words ]

print(' Original Tokens  : ', tokens, '\n',
      'Removed Stopwords: ',tokens_without_stopwords)
```

```
#:>  Original Tokens  :  ['The', 'house', 'is', 'on', 'fire'] 
#:>  Removed Stopwords:  ['The', 'house', 'fire']
```

### NLTK Stop Words

Contain 179 words, in a list form


```python
import nltk
nltk.download('stopwords')
```

```
#:> True
#:> 
#:> [nltk_data] Downloading package stopwords to
#:> [nltk_data]     /home/msfz751/nltk_data...
#:> [nltk_data]   Package stopwords is already up-to-date!
```



```python
import nltk
#nltk.download('stopwords')
nltk_stop_words = nltk.corpus.stopwords.words('english')
print('Total NLTK Stopwords: ', len(nltk_stop_words),'\n',
      nltk_stop_words)
```

```
#:> Total NLTK Stopwords:  179 
#:>  ['i', 'me', 'my', 'myself', 'we', 'our', 'ours', 'ourselves', 'you', "you're", "you've", "you'll", "you'd", 'your', 'yours', 'yourself', 'yourselves', 'he', 'him', 'his', 'himself', 'she', "she's", 'her', 'hers', 'herself', 'it', "it's", 'its', 'itself', 'they', 'them', 'their', 'theirs', 'themselves', 'what', 'which', 'who', 'whom', 'this', 'that', "that'll", 'these', 'those', 'am', 'is', 'are', 'was', 'were', 'be', 'been', 'being', 'have', 'has', 'had', 'having', 'do', 'does', 'did', 'doing', 'a', 'an', 'the', 'and', 'but', 'if', 'or', 'because', 'as', 'until', 'while', 'of', 'at', 'by', 'for', 'with', 'about', 'against', 'between', 'into', 'through', 'during', 'before', 'after', 'above', 'below', 'to', 'from', 'up', 'down', 'in', 'out', 'on', 'off', 'over', 'under', 'again', 'further', 'then', 'once', 'here', 'there', 'when', 'where', 'why', 'how', 'all', 'any', 'both', 'each', 'few', 'more', 'most', 'other', 'some', 'such', 'no', 'nor', 'not', 'only', 'own', 'same', 'so', 'than', 'too', 'very', 's', 't', 'can', 'will', 'just', 'don', "don't", 'should', "should've", 'now', 'd', 'll', 'm', 'o', 're', 've', 'y', 'ain', 'aren', "aren't", 'couldn', "couldn't", 'didn', "didn't", 'doesn', "doesn't", 'hadn', "hadn't", 'hasn', "hasn't", 'haven', "haven't", 'isn', "isn't", 'ma', 'mightn', "mightn't", 'mustn', "mustn't", 'needn', "needn't", 'shan', "shan't", 'shouldn', "shouldn't", 'wasn', "wasn't", 'weren', "weren't", 'won', "won't", 'wouldn', "wouldn't"]
```

### SKLearn Stop Words

Contain 318 stop words, in frozenset form


```python
from sklearn.feature_extraction.text import ENGLISH_STOP_WORDS as sklearn_stop_words
print(' Total Sklearn Stopwords: ', len(sklearn_stop_words),'\n\n',
       sklearn_stop_words)
```

```
#:>  Total Sklearn Stopwords:  318 
#:> 
#:>  frozenset({'give', 'someone', 'why', 'my', 'latterly', 'a', 'anywhere', 'whereas', 'us', 'de', 'made', 'last', 'thus', 'least', 'either', 'system', 'besides', 'nor', 'somehow', 'beside', 'call', 'fill', 'should', 'back', 'two', 'anything', 'thick', 'after', 'due', 'must', 'do', 'whom', 'first', 'be', 'across', 'via', 'some', 'it', 'the', 'at', 'hereby', 'somewhere', 'being', 'further', 'three', 'itself', 'describe', 'rather', 'same', 'always', 'whatever', 'while', 'whoever', 'moreover', 'now', 'hasnt', 'whole', 'mine', 'former', 'beforehand', 'sometime', 'of', 'you', 'very', 'sincere', 'has', 'thereby', 'against', 'only', 'until', 'thin', 'that', 'whether', 'un', 'thereupon', 'enough', 'above', 'ie', 'next', 'are', 'everywhere', 'fire', 'herself', 'she', 'himself', 'throughout', 'ten', 'anyway', 'more', 'several', 'became', 'in', 'what', 'full', 'around', 'co', 'whose', 'up', 'down', 'once', 'seems', 'whence', 'since', 'within', 'cry', 'interest', 'alone', 'becomes', 'except', 'i', 'than', 'on', 'another', 'show', 'off', 'ever', 'seem', 'is', 'might', 'an', 'he', 'therefore', 'hereupon', 'one', 'his', 'already', 'name', 'beyond', 'was', 'with', 'see', 'and', 'few', 'none', 'yet', 'we', 'eg', 'among', 'these', 'how', 'hers', 'have', 'put', 'yourself', 'everyone', 'though', 'done', 'before', 'fifty', 'there', 'also', 'couldnt', 'often', 'all', 'four', 'mill', 'had', 'am', 'not', 'sometimes', 'too', 'cant', 'herein', 'may', 'towards', 'everything', 'found', 'themselves', 'about', 'any', 'amongst', 'eleven', 'go', 'inc', 'part', 'for', 'amoungst', 'side', 'although', 'etc', 'from', 'else', 'cannot', 'hereafter', 'because', 'hundred', 'hence', 'empty', 'twelve', 'or', 'under', 'namely', 'much', 'its', 'whereupon', 'thru', 'will', 'otherwise', 'into', 'each', 'five', 'then', 'neither', 'so', 'below', 'ours', 'top', 'nothing', 'seeming', 'detail', 'six', 'serious', 'others', 'thereafter', 'could', 'but', 'without', 'con', 'yourselves', 'own', 'still', 'ltd', 'amount', 'per', 'both', 'this', 'toward', 'please', 'sixty', 'out', 'wherever', 'onto', 'bill', 'twenty', 'which', 'nobody', 'would', 'as', 'nowhere', 'can', 'been', 'find', 'anyhow', 'whereby', 'behind', 'upon', 'many', 'together', 'take', 'latter', 'here', 'afterwards', 'were', 'become', 'yours', 'again', 'myself', 'other', 'through', 'where', 'never', 'indeed', 'something', 'eight', 'our', 'such', 're', 'well', 'keep', 'them', 'most', 'your', 'seemed', 'perhaps', 'whither', 'fifteen', 'between', 'get', 'during', 'her', 'they', 'if', 'him', 'mostly', 'move', 'anyone', 'thence', 'however', 'front', 'less', 'no', 'whereafter', 'over', 'to', 'who', 'nevertheless', 'elsewhere', 'ourselves', 'nine', 'their', 'those', 'me', 'when', 'along', 'by', 'therein', 'almost', 'becoming', 'forty', 'every', 'formerly', 'bottom', 'even', 'noone', 'whenever', 'wherein', 'meanwhile', 'third'})
```

### Combined NLTK and SKLearn Stop Words


```python
combined_stop_words = list( set(nltk_stop_words) | set(sklearn_stop_words) )
print('Total combined NLTK and SKLearn Stopwords:', len( combined_stop_words ),'\n'
      'Stopwords shared among NLTK and SKlearn  :', len( list( set(nltk_stop_words) & set(sklearn_stop_words)) ))
```

```
#:> Total combined NLTK and SKLearn Stopwords: 378 
#:> Stopwords shared among NLTK and SKlearn  : 119
```

## Normalizing

Similar things are combined into single normalized form. This will reduced the vocabulary.

### Case Folding

If tokens aren't cap normalized, you will end up with large word list.
However, some information is often communicated by capitalization of word, such as name of places. If names are important, consider using proper noun.



```python
tokens = ['House','Visitor','Center']
[ x.lower() for x in tokens]
```

```
#:> ['house', 'visitor', 'center']
```


### Stemming

- Output of a stemmer is **not necessary a proper word**
- Automatically convert words to **lower cap**
- **Porter stemmer** is a lifetime refinement with 300 lines of python code  
- Stemming is faster then Lemmatization


```python
from nltk.stem.porter import PorterStemmer
stemmer = PorterStemmer()
tokens = ('house','Housing','hOuses', 'Malicious','goodness')
[stemmer.stem(x) for x in tokens ]
```

```
#:> ['hous', 'hous', 'hous', 'malici', 'good']
```

### Lemmatization

NLTK uses connections within **princeton WordNet** graph for word meanings.


```python
nltk.download('wordnet')
```

```
#:> True
#:> 
#:> [nltk_data] Downloading package wordnet to /home/msfz751/nltk_data...
#:> [nltk_data]   Package wordnet is already up-to-date!
```

```python
from nltk.stem import WordNetLemmatizer
lemmatizer = WordNetLemmatizer()

print( lemmatizer.lemmatize("better", pos ='a'), '\n',
       lemmatizer.lemmatize("better", pos ='n') )
```

```
#:> good 
#:>  better
```


```python
print( lemmatizer.lemmatize("good", pos ='a'), '\n',
       lemmatizer.lemmatize("good", pos ='n') )
```

```
#:> good 
#:>  good
```

### Comparing Stemming and Lemmatization

- Lemmatization is slower than stemming
= Lemmatization is better at retaining meanings
- Lemmatization produce valid english word
- Stemming not necessary produce valid english word
- Both reduce vocabulary size, but increase ambiguity
- For search engine application, stemming and lemmatization will improve recall as it associate more documents with the same query words, however with the cost of reducing precision and accuracy.

For search-based chatbot where accuracy is more important, it should first search with unnormalzied words.



## Wordnet

WordNet® is a large lexical database of English. Nouns, verbs, adjectives and adverbs are grouped into sets of cognitive synonyms (synsets), each expressing a distinct concept. Synsets are interlinked by means of conceptual-semantic and lexical relations.  

WordNet superficially resembles a thesaurus, in that it groups words together based on their meanings. However, there are some important distinctions:  
- WordNet interlinks not just word forms—strings of letters—but specific senses of words. As a result, words that are found in close proximity to one another in the network are semantically disambiguated  
- WordNet labels the semantic relations among words, whereas the groupings of words in a thesaurus does not follow any explicit pattern other than meaning similarity  

[Wordnet Princeton](https://wordnet.princeton.edu)

[Wordnet Online Browser](http://wordnetweb.princeton.edu/perl/webwn)

### NLTK and Wordnet

NLTK (version 3.7.6) includes the English WordNet (147,307 words and 117,659 synonym sets)


```python
from nltk.corpus import wordnet as wn

s = set( wn.all_synsets() )
w = set(wn.words())
print('Total words in wordnet  : ' ,   len(w),
      '\nTotal synsets in wordnet: ' , len(s) )
```

```
#:> Total words in wordnet  :  147306 
#:> Total synsets in wordnet:  117659
```

### Synset

#### Notation

A synset is the basic construct of a word in wordnet. It contains the **Word** itself, with its **POS** tag and **Usage**: **`word.pos.nn`**


```python
wn.synset('breakdown.n.03')
```

```
#:> Synset('breakdown.n.03')
```

Breaking down the construct:

```
'breakdown' = Word
'n'         = Part of Speech
'03'        = Usage (01 for most common usage and a higher number would indicate lesser common usages)
```

#### Part of Speech

Wordnet support five POS tags

```
n - NOUN
v - VERB
a - ADJECTIVE
s - ADJECTIVE SATELLITE
r - ADVERB
```


```python
print(wn.ADJ, wn.ADJ_SAT, wn.ADV, wn.NOUN, wn.VERB)
```

```
#:> a s r n v
```

#### Synset Similarity

Let's see how similar are the below two nouns


```python
w1 = wn.synset('dog.n.01')
w2 = wn.synset('ship.n.01')
print(w1.wup_similarity(w2))
```

```
#:> 0.4
```


```python
w1 = wn.synset('ship.n.01')
w2 = wn.synset('boat.n.01')
print(w1.wup_similarity(w2))
```

```
#:> 0.9090909090909091
```


### Synsets

- Synsets is a collection of synsets, which are synonyms that share a common meaning  
- A synset (member of Synsets) is identified with a 3-part name of the form: 
- A synset can contain one or more lemmas, which represent a specific sense of a specific word  
- A synset can contain one or more **Hyponyms and Hypernyms**. These are specific and generalized concepts respectively. For example, 'beach house' and 'guest house' are hyponyms of 'house'. They are more specific concepts of 'house'. And 'house' is a hypernym of 'guest house' because it is the general concept  
-  **Hyponyms and Hypernyms** are also called lexical relations


```python
dogs = wn.synsets('dog') # get all synsets for word 'dog'

for d in dogs:  ## iterate through each Synset
  print(d,':\nDefinition:', d.definition(),
           '\nExample:',    d.examples(),
           '\nLemmas:',     d.lemma_names(),
           '\nHyponyms:',   d.hyponyms(), 
           '\nHypernyms:',  d.hypernyms(), '\n\n')
```

```
#:> Synset('dog.n.01') :
#:> Definition: a member of the genus Canis (probably descended from the common wolf) that has been domesticated by man since prehistoric times; occurs in many breeds 
#:> Example: ['the dog barked all night'] 
#:> Lemmas: ['dog', 'domestic_dog', 'Canis_familiaris'] 
#:> Hyponyms: [Synset('basenji.n.01'), Synset('corgi.n.01'), Synset('cur.n.01'), Synset('dalmatian.n.02'), Synset('great_pyrenees.n.01'), Synset('griffon.n.02'), Synset('hunting_dog.n.01'), Synset('lapdog.n.01'), Synset('leonberg.n.01'), Synset('mexican_hairless.n.01'), Synset('newfoundland.n.01'), Synset('pooch.n.01'), Synset('poodle.n.01'), Synset('pug.n.01'), Synset('puppy.n.01'), Synset('spitz.n.01'), Synset('toy_dog.n.01'), Synset('working_dog.n.01')] 
#:> Hypernyms: [Synset('canine.n.02'), Synset('domestic_animal.n.01')] 
#:> 
#:> 
#:> Synset('frump.n.01') :
#:> Definition: a dull unattractive unpleasant girl or woman 
#:> Example: ['she got a reputation as a frump', "she's a real dog"] 
#:> Lemmas: ['frump', 'dog'] 
#:> Hyponyms: [] 
#:> Hypernyms: [Synset('unpleasant_woman.n.01')] 
#:> 
#:> 
#:> Synset('dog.n.03') :
#:> Definition: informal term for a man 
#:> Example: ['you lucky dog'] 
#:> Lemmas: ['dog'] 
#:> Hyponyms: [] 
#:> Hypernyms: [Synset('chap.n.01')] 
#:> 
#:> 
#:> Synset('cad.n.01') :
#:> Definition: someone who is morally reprehensible 
#:> Example: ['you dirty dog'] 
#:> Lemmas: ['cad', 'bounder', 'blackguard', 'dog', 'hound', 'heel'] 
#:> Hyponyms: [Synset('perisher.n.01')] 
#:> Hypernyms: [Synset('villain.n.01')] 
#:> 
#:> 
#:> Synset('frank.n.02') :
#:> Definition: a smooth-textured sausage of minced beef or pork usually smoked; often served on a bread roll 
#:> Example: [] 
#:> Lemmas: ['frank', 'frankfurter', 'hotdog', 'hot_dog', 'dog', 'wiener', 'wienerwurst', 'weenie'] 
#:> Hyponyms: [Synset('vienna_sausage.n.01')] 
#:> Hypernyms: [Synset('sausage.n.01')] 
#:> 
#:> 
#:> Synset('pawl.n.01') :
#:> Definition: a hinged catch that fits into a notch of a ratchet to move a wheel forward or prevent it from moving backward 
#:> Example: [] 
#:> Lemmas: ['pawl', 'detent', 'click', 'dog'] 
#:> Hyponyms: [] 
#:> Hypernyms: [Synset('catch.n.06')] 
#:> 
#:> 
#:> Synset('andiron.n.01') :
#:> Definition: metal supports for logs in a fireplace 
#:> Example: ['the andirons were too hot to touch'] 
#:> Lemmas: ['andiron', 'firedog', 'dog', 'dog-iron'] 
#:> Hyponyms: [] 
#:> Hypernyms: [Synset('support.n.10')] 
#:> 
#:> 
#:> Synset('chase.v.01') :
#:> Definition: go after with the intent to catch 
#:> Example: ['The policeman chased the mugger down the alley', 'the dog chased the rabbit'] 
#:> Lemmas: ['chase', 'chase_after', 'trail', 'tail', 'tag', 'give_chase', 'dog', 'go_after', 'track'] 
#:> Hyponyms: [Synset('hound.v.01'), Synset('quest.v.02'), Synset('run_down.v.07'), Synset('tree.v.03')] 
#:> Hypernyms: [Synset('pursue.v.02')]
```




## Part Of Speech (POS)

- In corpus linguistics, part-of-speech tagging (POS tagging or PoS tagging or POST), also called **grammatical tagging** or **word-category disambiguation**, is the process of marking up a word in a text (corpus) as corresponding to a particular part of speech, based on both its definition and its context—i.e., its relationship with adjacent and related words in a phrase, sentence, or paragraph  
- This is useful for Information Retrieval, Text to Speech, Word Sense Disambiguation  
- The primary target of Part-of-Speech(POS) tagging is to identify the grammatical group of a given word. Whether it is a NOUN, PRONOUN, ADJECTIVE, VERB, ADVERBS, etc. based on the context  
- A simplified form of this is commonly taught to school-age children, in the identification of words as nouns, verbs, adjectives, adverbs, etc  

### Tag Sets

- Schools commonly teach that there are 9 parts of speech in English: noun, verb, article, adjective, preposition, pronoun, adverb, conjunction, and interjection  
- However, there are clearly many more categories and sub-categories 


```python
 nltk.download('universal_tagset')
```

#### Universal Tagset

This tagset contains **12** coarse tags

```
VERB - verbs (all tenses and modes)
NOUN - nouns (common and proper)
PRON - pronouns
ADJ - adjectives
ADV - adverbs
ADP - adpositions (prepositions and postpositions)
CONJ - conjunctions
DET - determiners
NUM - cardinal numbers
PRT - particles or other function words
X - other: foreign words, typos, abbreviations
. - punctuation
```

#### Penn Treebank Tagset

- This is the most popular "tag set" for American English, developed in the Penn Treebank project  
- It has **36 POS tags plus 12** others for punctuations and special symbols  

[PENN POS Tagset](https://www.sketchengine.eu/penn-treebank-tagset/)


```python
nltk.download('tagsets')
```

```
#:> True
#:> 
#:> [nltk_data] Downloading package tagsets to /home/msfz751/nltk_data...
#:> [nltk_data]   Package tagsets is already up-to-date!
```

```python
nltk.help.upenn_tagset()
```

```
#:> $: dollar
#:>     $ -$ --$ A$ C$ HK$ M$ NZ$ S$ U.S.$ US$
#:> '': closing quotation mark
#:>     ' ''
#:> (: opening parenthesis
#:>     ( [ {
#:> ): closing parenthesis
#:>     ) ] }
#:> ,: comma
#:>     ,
#:> --: dash
#:>     --
#:> .: sentence terminator
#:>     . ! ?
#:> :: colon or ellipsis
#:>     : ; ...
#:> CC: conjunction, coordinating
#:>     & 'n and both but either et for less minus neither nor or plus so
#:>     therefore times v. versus vs. whether yet
#:> CD: numeral, cardinal
#:>     mid-1890 nine-thirty forty-two one-tenth ten million 0.5 one forty-
#:>     seven 1987 twenty '79 zero two 78-degrees eighty-four IX '60s .025
#:>     fifteen 271,124 dozen quintillion DM2,000 ...
#:> DT: determiner
#:>     all an another any both del each either every half la many much nary
#:>     neither no some such that the them these this those
#:> EX: existential there
#:>     there
#:> FW: foreign word
#:>     gemeinschaft hund ich jeux habeas Haementeria Herr K'ang-si vous
#:>     lutihaw alai je jour objets salutaris fille quibusdam pas trop Monte
#:>     terram fiche oui corporis ...
#:> IN: preposition or conjunction, subordinating
#:>     astride among uppon whether out inside pro despite on by throughout
#:>     below within for towards near behind atop around if like until below
#:>     next into if beside ...
#:> JJ: adjective or numeral, ordinal
#:>     third ill-mannered pre-war regrettable oiled calamitous first separable
#:>     ectoplasmic battery-powered participatory fourth still-to-be-named
#:>     multilingual multi-disciplinary ...
#:> JJR: adjective, comparative
#:>     bleaker braver breezier briefer brighter brisker broader bumper busier
#:>     calmer cheaper choosier cleaner clearer closer colder commoner costlier
#:>     cozier creamier crunchier cuter ...
#:> JJS: adjective, superlative
#:>     calmest cheapest choicest classiest cleanest clearest closest commonest
#:>     corniest costliest crassest creepiest crudest cutest darkest deadliest
#:>     dearest deepest densest dinkiest ...
#:> LS: list item marker
#:>     A A. B B. C C. D E F First G H I J K One SP-44001 SP-44002 SP-44005
#:>     SP-44007 Second Third Three Two * a b c d first five four one six three
#:>     two
#:> MD: modal auxiliary
#:>     can cannot could couldn't dare may might must need ought shall should
#:>     shouldn't will would
#:> NN: noun, common, singular or mass
#:>     common-carrier cabbage knuckle-duster Casino afghan shed thermostat
#:>     investment slide humour falloff slick wind hyena override subhumanity
#:>     machinist ...
#:> NNP: noun, proper, singular
#:>     Motown Venneboerger Czestochwa Ranzer Conchita Trumplane Christos
#:>     Oceanside Escobar Kreisler Sawyer Cougar Yvette Ervin ODI Darryl CTCA
#:>     Shannon A.K.C. Meltex Liverpool ...
#:> NNPS: noun, proper, plural
#:>     Americans Americas Amharas Amityvilles Amusements Anarcho-Syndicalists
#:>     Andalusians Andes Andruses Angels Animals Anthony Antilles Antiques
#:>     Apache Apaches Apocrypha ...
#:> NNS: noun, common, plural
#:>     undergraduates scotches bric-a-brac products bodyguards facets coasts
#:>     divestitures storehouses designs clubs fragrances averages
#:>     subjectivists apprehensions muses factory-jobs ...
#:> PDT: pre-determiner
#:>     all both half many quite such sure this
#:> POS: genitive marker
#:>     ' 's
#:> PRP: pronoun, personal
#:>     hers herself him himself hisself it itself me myself one oneself ours
#:>     ourselves ownself self she thee theirs them themselves they thou thy us
#:> PRP$: pronoun, possessive
#:>     her his mine my our ours their thy your
#:> RB: adverb
#:>     occasionally unabatingly maddeningly adventurously professedly
#:>     stirringly prominently technologically magisterially predominately
#:>     swiftly fiscally pitilessly ...
#:> RBR: adverb, comparative
#:>     further gloomier grander graver greater grimmer harder harsher
#:>     healthier heavier higher however larger later leaner lengthier less-
#:>     perfectly lesser lonelier longer louder lower more ...
#:> RBS: adverb, superlative
#:>     best biggest bluntest earliest farthest first furthest hardest
#:>     heartiest highest largest least less most nearest second tightest worst
#:> RP: particle
#:>     aboard about across along apart around aside at away back before behind
#:>     by crop down ever fast for forth from go high i.e. in into just later
#:>     low more off on open out over per pie raising start teeth that through
#:>     under unto up up-pp upon whole with you
#:> SYM: symbol
#:>     % & ' '' ''. ) ). * + ,. < = > @ A[fj] U.S U.S.S.R * ** ***
#:> TO: "to" as preposition or infinitive marker
#:>     to
#:> UH: interjection
#:>     Goodbye Goody Gosh Wow Jeepers Jee-sus Hubba Hey Kee-reist Oops amen
#:>     huh howdy uh dammit whammo shucks heck anyways whodunnit honey golly
#:>     man baby diddle hush sonuvabitch ...
#:> VB: verb, base form
#:>     ask assemble assess assign assume atone attention avoid bake balkanize
#:>     bank begin behold believe bend benefit bevel beware bless boil bomb
#:>     boost brace break bring broil brush build ...
#:> VBD: verb, past tense
#:>     dipped pleaded swiped regummed soaked tidied convened halted registered
#:>     cushioned exacted snubbed strode aimed adopted belied figgered
#:>     speculated wore appreciated contemplated ...
#:> VBG: verb, present participle or gerund
#:>     telegraphing stirring focusing angering judging stalling lactating
#:>     hankerin' alleging veering capping approaching traveling besieging
#:>     encrypting interrupting erasing wincing ...
#:> VBN: verb, past participle
#:>     multihulled dilapidated aerosolized chaired languished panelized used
#:>     experimented flourished imitated reunifed factored condensed sheared
#:>     unsettled primed dubbed desired ...
#:> VBP: verb, present tense, not 3rd person singular
#:>     predominate wrap resort sue twist spill cure lengthen brush terminate
#:>     appear tend stray glisten obtain comprise detest tease attract
#:>     emphasize mold postpone sever return wag ...
#:> VBZ: verb, present tense, 3rd person singular
#:>     bases reconstructs marks mixes displeases seals carps weaves snatches
#:>     slumps stretches authorizes smolders pictures emerges stockpiles
#:>     seduces fizzes uses bolsters slaps speaks pleads ...
#:> WDT: WH-determiner
#:>     that what whatever which whichever
#:> WP: WH-pronoun
#:>     that what whatever whatsoever which who whom whosoever
#:> WP$: WH-pronoun, possessive
#:>     whose
#:> WRB: Wh-adverb
#:>     how however whence whenever where whereby whereever wherein whereof why
#:> ``: opening quotation mark
#:>     ` ``
```

#### Claws5 Tagset

[Claws5 POS Tagset](https://www.sketchengine.eu/english-claws5-part-of-speech-tagset/)


```python
nltk.help.claws5_tagset()
```

```
#:> AJ0: adjective (unmarked)
#:>     good, old
#:> AJC: comparative adjective
#:>     better, older
#:> AJS: superlative adjective
#:>     best, oldest
#:> AT0: article
#:>     THE, A, AN
#:> AV0: adverb (unmarked)
#:>     often, well, longer, furthest
#:> AVP: adverb particle
#:>     up, off, out
#:> AVQ: wh-adverb
#:>     when, how, why
#:> CJC: coordinating conjunction
#:>     and, or
#:> CJS: subordinating conjunction
#:>     although, when
#:> CJT: the conjunction THAT
#:>     that
#:> CRD: cardinal numeral
#:>     3, fifty-five, 6609 (excl one)
#:> DPS: possessive determiner form
#:>     your, their
#:> DT0: general determiner
#:>     these, some
#:> DTQ: wh-determiner
#:>     whose, which
#:> EX0: existential THERE
#:>     there
#:> ITJ: interjection or other isolate
#:>     oh, yes, mhm
#:> NN0: noun (neutral for number)
#:>     aircraft, data
#:> NN1: singular noun
#:>     pencil, goose
#:> NN2: plural noun
#:>     pencils, geese
#:> NP0: proper noun
#:>     London, Michael, Mars
#:> NULL: the null tag (for items not to be tagged)
#:> ORD: ordinal
#:>     sixth, 77th, last
#:> PNI: indefinite pronoun
#:>     none, everything
#:> PNP: personal pronoun
#:>     you, them, ours
#:> PNQ: wh-pronoun
#:>     who, whoever
#:> PNX: reflexive pronoun
#:>     itself, ourselves
#:> POS: the possessive (or genitive morpheme)
#:>     's or '
#:> PRF: the preposition OF
#:>     of
#:> PRP: preposition (except for OF)
#:>     for, above, to
#:> PUL: punctuation
#:>     left bracket - ( or [ )
#:> PUN: punctuation
#:>     general mark - . ! , : ; - ? ...
#:> PUQ: punctuation
#:>     quotation mark - ` ' "
#:> PUR: punctuation
#:>     right bracket - ) or ]
#:> TO0: infinitive marker TO
#:>     to
#:> UNC: "unclassified" items which are not words of the English lexicon
#:> VBB: the "base forms" of the verb "BE" (except the infinitive)
#:>     am, are
#:> VBD: past form of the verb "BE"
#:>     was, were
#:> VBG: -ing form of the verb "BE"
#:>     being
#:> VBI: infinitive of the verb "BE"
#:>     be
#:> VBN: past participle of the verb "BE"
#:>     been
#:> VBZ: -s form of the verb "BE"
#:>     is, 's
#:> VDB: base form of the verb "DO" (except the infinitive)
#:>     do
#:> VDD: past form of the verb "DO"
#:>     did
#:> VDG: -ing form of the verb "DO"
#:>     doing
#:> VDI: infinitive of the verb "DO"
#:>     do
#:> VDN: past participle of the verb "DO"
#:>     done
#:> VDZ: -s form of the verb "DO"
#:>     does
#:> VHB: base form of the verb "HAVE" (except the infinitive)
#:>     have
#:> VHD: past tense form of the verb "HAVE"
#:>     had, 'd
#:> VHG: -ing form of the verb "HAVE"
#:>     having
#:> VHI: infinitive of the verb "HAVE"
#:>     have
#:> VHN: past participle of the verb "HAVE"
#:>     had
#:> VHZ: -s form of the verb "HAVE"
#:>     has, 's
#:> VM0: modal auxiliary verb
#:>     can, could, will, 'll
#:> VVB: base form of lexical verb (except the infinitive)
#:>     take, live
#:> VVD: past tense form of lexical verb
#:>     took, lived
#:> VVG: -ing form of lexical verb
#:>     taking, living
#:> VVI: infinitive of lexical verb
#:>     take, live
#:> VVN: past participle form of lex. verb
#:>     taken, lived
#:> VVZ: -s form of lexical verb
#:>     takes, lives
#:> XX0: the negative NOT or N'T
#:>     not
#:> ZZ0: alphabetical symbol
#:>     A, B, c, d
```

#### Brown Tagset

[Brown POS Tagset](https://en.wikipedia.org/wiki/Brown_Corpus#Part-of-speech_tags_used)


```python
nltk.help.brown_tagset()
```

```
#:> (: opening parenthesis
#:>     (
#:> ): closing parenthesis
#:>     )
#:> *: negator
#:>     not n't
#:> ,: comma
#:>     ,
#:> --: dash
#:>     --
#:> .: sentence terminator
#:>     . ? ; ! :
#:> :: colon
#:>     :
#:> ABL: determiner/pronoun, pre-qualifier
#:>     quite such rather
#:> ABN: determiner/pronoun, pre-quantifier
#:>     all half many nary
#:> ABX: determiner/pronoun, double conjunction or pre-quantifier
#:>     both
#:> AP: determiner/pronoun, post-determiner
#:>     many other next more last former little several enough most least only
#:>     very few fewer past same Last latter less single plenty 'nough lesser
#:>     certain various manye next-to-last particular final previous present
#:>     nuf
#:> AP$: determiner/pronoun, post-determiner, genitive
#:>     other's
#:> AP+AP: determiner/pronoun, post-determiner, hyphenated pair
#:>     many-much
#:> AT: article
#:>     the an no a every th' ever' ye
#:> BE: verb 'to be', infinitive or imperative
#:>     be
#:> BED: verb 'to be', past tense, 2nd person singular or all persons plural
#:>     were
#:> BED*: verb 'to be', past tense, 2nd person singular or all persons plural, negated
#:>     weren't
#:> BEDZ: verb 'to be', past tense, 1st and 3rd person singular
#:>     was
#:> BEDZ*: verb 'to be', past tense, 1st and 3rd person singular, negated
#:>     wasn't
#:> BEG: verb 'to be', present participle or gerund
#:>     being
#:> BEM: verb 'to be', present tense, 1st person singular
#:>     am
#:> BEM*: verb 'to be', present tense, 1st person singular, negated
#:>     ain't
#:> BEN: verb 'to be', past participle
#:>     been
#:> BER: verb 'to be', present tense, 2nd person singular or all persons plural
#:>     are art
#:> BER*: verb 'to be', present tense, 2nd person singular or all persons plural, negated
#:>     aren't ain't
#:> BEZ: verb 'to be', present tense, 3rd person singular
#:>     is
#:> BEZ*: verb 'to be', present tense, 3rd person singular, negated
#:>     isn't ain't
#:> CC: conjunction, coordinating
#:>     and or but plus & either neither nor yet 'n' and/or minus an'
#:> CD: numeral, cardinal
#:>     two one 1 four 2 1913 71 74 637 1937 8 five three million 87-31 29-5
#:>     seven 1,119 fifty-three 7.5 billion hundred 125,000 1,700 60 100 six
#:>     ...
#:> CD$: numeral, cardinal, genitive
#:>     1960's 1961's .404's
#:> CS: conjunction, subordinating
#:>     that as after whether before while like because if since for than altho
#:>     until so unless though providing once lest s'posin' till whereas
#:>     whereupon supposing tho' albeit then so's 'fore
#:> DO: verb 'to do', uninflected present tense, infinitive or imperative
#:>     do dost
#:> DO*: verb 'to do', uninflected present tense or imperative, negated
#:>     don't
#:> DO+PPSS: verb 'to do', past or present tense + pronoun, personal, nominative, not 3rd person singular
#:>     d'you
#:> DOD: verb 'to do', past tense
#:>     did done
#:> DOD*: verb 'to do', past tense, negated
#:>     didn't
#:> DOZ: verb 'to do', present tense, 3rd person singular
#:>     does
#:> DOZ*: verb 'to do', present tense, 3rd person singular, negated
#:>     doesn't don't
#:> DT: determiner/pronoun, singular
#:>     this each another that 'nother
#:> DT$: determiner/pronoun, singular, genitive
#:>     another's
#:> DT+BEZ: determiner/pronoun + verb 'to be', present tense, 3rd person singular
#:>     that's
#:> DT+MD: determiner/pronoun + modal auxillary
#:>     that'll this'll
#:> DTI: determiner/pronoun, singular or plural
#:>     any some
#:> DTS: determiner/pronoun, plural
#:>     these those them
#:> DTS+BEZ: pronoun, plural + verb 'to be', present tense, 3rd person singular
#:>     them's
#:> DTX: determiner, pronoun or double conjunction
#:>     neither either one
#:> EX: existential there
#:>     there
#:> EX+BEZ: existential there + verb 'to be', present tense, 3rd person singular
#:>     there's
#:> EX+HVD: existential there + verb 'to have', past tense
#:>     there'd
#:> EX+HVZ: existential there + verb 'to have', present tense, 3rd person singular
#:>     there's
#:> EX+MD: existential there + modal auxillary
#:>     there'll there'd
#:> FW-*: foreign word: negator
#:>     pas non ne
#:> FW-AT: foreign word: article
#:>     la le el un die der ein keine eine das las les Il
#:> FW-AT+NN: foreign word: article + noun, singular, common
#:>     l'orchestre l'identite l'arcade l'ange l'assistance l'activite
#:>     L'Universite l'independance L'Union L'Unita l'osservatore
#:> FW-AT+NP: foreign word: article + noun, singular, proper
#:>     L'Astree L'Imperiale
#:> FW-BE: foreign word: verb 'to be', infinitive or imperative
#:>     sit
#:> FW-BER: foreign word: verb 'to be', present tense, 2nd person singular or all persons plural
#:>     sind sunt etes
#:> FW-BEZ: foreign word: verb 'to be', present tense, 3rd person singular
#:>     ist est
#:> FW-CC: foreign word: conjunction, coordinating
#:>     et ma mais und aber och nec y
#:> FW-CD: foreign word: numeral, cardinal
#:>     une cinq deux sieben unam zwei
#:> FW-CS: foreign word: conjunction, subordinating
#:>     bevor quam ma
#:> FW-DT: foreign word: determiner/pronoun, singular
#:>     hoc
#:> FW-DT+BEZ: foreign word: determiner + verb 'to be', present tense, 3rd person singular
#:>     c'est
#:> FW-DTS: foreign word: determiner/pronoun, plural
#:>     haec
#:> FW-HV: foreign word: verb 'to have', present tense, not 3rd person singular
#:>     habe
#:> FW-IN: foreign word: preposition
#:>     ad de en a par con dans ex von auf super post sine sur sub avec per
#:>     inter sans pour pendant in di
#:> FW-IN+AT: foreign word: preposition + article
#:>     della des du aux zur d'un del dell'
#:> FW-IN+NN: foreign word: preposition + noun, singular, common
#:>     d'etat d'hotel d'argent d'identite d'art
#:> FW-IN+NP: foreign word: preposition + noun, singular, proper
#:>     d'Yquem d'Eiffel
#:> FW-JJ: foreign word: adjective
#:>     avant Espagnol sinfonica Siciliana Philharmonique grand publique haute
#:>     noire bouffe Douce meme humaine bel serieuses royaux anticus presto
#:>     Sovietskaya Bayerische comique schwarzen ...
#:> FW-JJR: foreign word: adjective, comparative
#:>     fortiori
#:> FW-JJT: foreign word: adjective, superlative
#:>     optimo
#:> FW-NN: foreign word: noun, singular, common
#:>     ballet esprit ersatz mano chatte goutte sang Fledermaus oud def kolkhoz
#:>     roi troika canto boite blutwurst carne muzyka bonheur monde piece force
#:>     ...
#:> FW-NN$: foreign word: noun, singular, common, genitive
#:>     corporis intellectus arte's dei aeternitatis senioritatis curiae
#:>     patronne's chambre's
#:> FW-NNS: foreign word: noun, plural, common
#:>     al culpas vopos boites haflis kolkhozes augen tyrannis alpha-beta-
#:>     gammas metis banditos rata phis negociants crus Einsatzkommandos
#:>     kamikaze wohaws sabinas zorrillas palazzi engages coureurs corroborees
#:>     yori Ubermenschen ...
#:> FW-NP: foreign word: noun, singular, proper
#:>     Karshilama Dieu Rundfunk Afrique Espanol Afrika Spagna Gott Carthago
#:>     deus
#:> FW-NPS: foreign word: noun, plural, proper
#:>     Svenskarna Atlantes Dieux
#:> FW-NR: foreign word: noun, singular, adverbial
#:>     heute morgen aujourd'hui hoy
#:> FW-OD: foreign word: numeral, ordinal
#:>     18e 17e quintus
#:> FW-PN: foreign word: pronoun, nominal
#:>     hoc
#:> FW-PP$: foreign word: determiner, possessive
#:>     mea mon deras vos
#:> FW-PPL: foreign word: pronoun, singular, reflexive
#:>     se
#:> FW-PPL+VBZ: foreign word: pronoun, singular, reflexive + verb, present tense, 3rd person singular
#:>     s'excuse s'accuse
#:> FW-PPO: pronoun, personal, accusative
#:>     lui me moi mi
#:> FW-PPO+IN: foreign word: pronoun, personal, accusative + preposition
#:>     mecum tecum
#:> FW-PPS: foreign word: pronoun, personal, nominative, 3rd person singular
#:>     il
#:> FW-PPSS: foreign word: pronoun, personal, nominative, not 3rd person singular
#:>     ich vous sie je
#:> FW-PPSS+HV: foreign word: pronoun, personal, nominative, not 3rd person singular + verb 'to have', present tense, not 3rd person singular
#:>     j'ai
#:> FW-QL: foreign word: qualifier
#:>     minus
#:> FW-RB: foreign word: adverb
#:>     bas assai deja um wiederum cito velociter vielleicht simpliciter non zu
#:>     domi nuper sic forsan olim oui semper tout despues hors
#:> FW-RB+CC: foreign word: adverb + conjunction, coordinating
#:>     forisque
#:> FW-TO+VB: foreign word: infinitival to + verb, infinitive
#:>     d'entretenir
#:> FW-UH: foreign word: interjection
#:>     sayonara bien adieu arigato bonjour adios bueno tchalo ciao o
#:> FW-VB: foreign word: verb, present tense, not 3rd person singular, imperative or infinitive
#:>     nolo contendere vive fermate faciunt esse vade noli tangere dites duces
#:>     meminisse iuvabit gosaimasu voulez habla ksu'u'peli'afo lacheln miuchi
#:>     say allons strafe portant
#:> FW-VBD: foreign word: verb, past tense
#:>     stabat peccavi audivi
#:> FW-VBG: foreign word: verb, present participle or gerund
#:>     nolens volens appellant seq. obliterans servanda dicendi delenda
#:> FW-VBN: foreign word: verb, past participle
#:>     vue verstrichen rasa verboten engages
#:> FW-VBZ: foreign word: verb, present tense, 3rd person singular
#:>     gouverne sinkt sigue diapiace
#:> FW-WDT: foreign word: WH-determiner
#:>     quo qua quod que quok
#:> FW-WPO: foreign word: WH-pronoun, accusative
#:>     quibusdam
#:> FW-WPS: foreign word: WH-pronoun, nominative
#:>     qui
#:> HV: verb 'to have', uninflected present tense, infinitive or imperative
#:>     have hast
#:> HV*: verb 'to have', uninflected present tense or imperative, negated
#:>     haven't ain't
#:> HV+TO: verb 'to have', uninflected present tense + infinitival to
#:>     hafta
#:> HVD: verb 'to have', past tense
#:>     had
#:> HVD*: verb 'to have', past tense, negated
#:>     hadn't
#:> HVG: verb 'to have', present participle or gerund
#:>     having
#:> HVN: verb 'to have', past participle
#:>     had
#:> HVZ: verb 'to have', present tense, 3rd person singular
#:>     has hath
#:> HVZ*: verb 'to have', present tense, 3rd person singular, negated
#:>     hasn't ain't
#:> IN: preposition
#:>     of in for by considering to on among at through with under into
#:>     regarding than since despite according per before toward against as
#:>     after during including between without except upon out over ...
#:> IN+IN: preposition, hyphenated pair
#:>     f'ovuh
#:> IN+PPO: preposition + pronoun, personal, accusative
#:>     t'hi-im
#:> JJ: adjective
#:>     ecent over-all possible hard-fought favorable hard meager fit such
#:>     widespread outmoded inadequate ambiguous grand clerical effective
#:>     orderly federal foster general proportionate ...
#:> JJ$: adjective, genitive
#:>     Great's
#:> JJ+JJ: adjective, hyphenated pair
#:>     big-large long-far
#:> JJR: adjective, comparative
#:>     greater older further earlier later freer franker wider better deeper
#:>     firmer tougher faster higher bigger worse younger lighter nicer slower
#:>     happier frothier Greater newer Elder ...
#:> JJR+CS: adjective + conjunction, coordinating
#:>     lighter'n
#:> JJS: adjective, semantically superlative
#:>     top chief principal northernmost master key head main tops utmost
#:>     innermost foremost uppermost paramount topmost
#:> JJT: adjective, superlative
#:>     best largest coolest calmest latest greatest earliest simplest
#:>     strongest newest fiercest unhappiest worst youngest worthiest fastest
#:>     hottest fittest lowest finest smallest staunchest ...
#:> MD: modal auxillary
#:>     should may might will would must can could shall ought need wilt
#:> MD*: modal auxillary, negated
#:>     cannot couldn't wouldn't can't won't shouldn't shan't mustn't musn't
#:> MD+HV: modal auxillary + verb 'to have', uninflected form
#:>     shouldda musta coulda must've woulda could've
#:> MD+PPSS: modal auxillary + pronoun, personal, nominative, not 3rd person singular
#:>     willya
#:> MD+TO: modal auxillary + infinitival to
#:>     oughta
#:> NN: noun, singular, common
#:>     failure burden court fire appointment awarding compensation Mayor
#:>     interim committee fact effect airport management surveillance jail
#:>     doctor intern extern night weekend duty legislation Tax Office ...
#:> NN$: noun, singular, common, genitive
#:>     season's world's player's night's chapter's golf's football's
#:>     baseball's club's U.'s coach's bride's bridegroom's board's county's
#:>     firm's company's superintendent's mob's Navy's ...
#:> NN+BEZ: noun, singular, common + verb 'to be', present tense, 3rd person singular
#:>     water's camera's sky's kid's Pa's heat's throat's father's money's
#:>     undersecretary's granite's level's wife's fat's Knife's fire's name's
#:>     hell's leg's sun's roulette's cane's guy's kind's baseball's ...
#:> NN+HVD: noun, singular, common + verb 'to have', past tense
#:>     Pa'd
#:> NN+HVZ: noun, singular, common + verb 'to have', present tense, 3rd person singular
#:>     guy's Knife's boat's summer's rain's company's
#:> NN+IN: noun, singular, common + preposition
#:>     buncha
#:> NN+MD: noun, singular, common + modal auxillary
#:>     cowhand'd sun'll
#:> NN+NN: noun, singular, common, hyphenated pair
#:>     stomach-belly
#:> NNS: noun, plural, common
#:>     irregularities presentments thanks reports voters laws legislators
#:>     years areas adjustments chambers $100 bonds courts sales details raises
#:>     sessions members congressmen votes polls calls ...
#:> NNS$: noun, plural, common, genitive
#:>     taxpayers' children's members' States' women's cutters' motorists'
#:>     steelmakers' hours' Nations' lawyers' prisoners' architects' tourists'
#:>     Employers' secretaries' Rogues' ...
#:> NNS+MD: noun, plural, common + modal auxillary
#:>     duds'd oystchers'll
#:> NP: noun, singular, proper
#:>     Fulton Atlanta September-October Durwood Pye Ivan Allen Jr. Jan.
#:>     Alpharetta Grady William B. Hartsfield Pearl Williams Aug. Berry J. M.
#:>     Cheshire Griffin Opelika Ala. E. Pelham Snodgrass ...
#:> NP$: noun, singular, proper, genitive
#:>     Green's Landis' Smith's Carreon's Allison's Boston's Spahn's Willie's
#:>     Mickey's Milwaukee's Mays' Howsam's Mantle's Shaw's Wagner's Rickey's
#:>     Shea's Palmer's Arnold's Broglio's ...
#:> NP+BEZ: noun, singular, proper + verb 'to be', present tense, 3rd person singular
#:>     W.'s Ike's Mack's Jack's Kate's Katharine's Black's Arthur's Seaton's
#:>     Buckhorn's Breed's Penny's Rob's Kitty's Blackwell's Myra's Wally's
#:>     Lucille's Springfield's Arlene's
#:> NP+HVZ: noun, singular, proper + verb 'to have', present tense, 3rd person singular
#:>     Bill's Guardino's Celie's Skolman's Crosson's Tim's Wally's
#:> NP+MD: noun, singular, proper + modal auxillary
#:>     Gyp'll John'll
#:> NPS: noun, plural, proper
#:>     Chases Aderholds Chapelles Armisteads Lockies Carbones French Marskmen
#:>     Toppers Franciscans Romans Cadillacs Masons Blacks Catholics British
#:>     Dixiecrats Mississippians Congresses ...
#:> NPS$: noun, plural, proper, genitive
#:>     Republicans' Orioles' Birds' Yanks' Redbirds' Bucs' Yankees' Stevenses'
#:>     Geraghtys' Burkes' Wackers' Achaeans' Dresbachs' Russians' Democrats'
#:>     Gershwins' Adventists' Negroes' Catholics' ...
#:> NR: noun, singular, adverbial
#:>     Friday home Wednesday Tuesday Monday Sunday Thursday yesterday tomorrow
#:>     tonight West East Saturday west left east downtown north northeast
#:>     southeast northwest North South right ...
#:> NR$: noun, singular, adverbial, genitive
#:>     Saturday's Monday's yesterday's tonight's tomorrow's Sunday's
#:>     Wednesday's Friday's today's Tuesday's West's Today's South's
#:> NR+MD: noun, singular, adverbial + modal auxillary
#:>     today'll
#:> NRS: noun, plural, adverbial
#:>     Sundays Mondays Saturdays Wednesdays Souths Fridays
#:> OD: numeral, ordinal
#:>     first 13th third nineteenth 2d 61st second sixth eighth ninth twenty-
#:>     first eleventh 50th eighteenth- Thirty-ninth 72nd 1/20th twentieth
#:>     mid-19th thousandth 350th sixteenth 701st ...
#:> PN: pronoun, nominal
#:>     none something everything one anyone nothing nobody everybody everyone
#:>     anybody anything someone no-one nothin
#:> PN$: pronoun, nominal, genitive
#:>     one's someone's anybody's nobody's everybody's anyone's everyone's
#:> PN+BEZ: pronoun, nominal + verb 'to be', present tense, 3rd person singular
#:>     nothing's everything's somebody's nobody's someone's
#:> PN+HVD: pronoun, nominal + verb 'to have', past tense
#:>     nobody'd
#:> PN+HVZ: pronoun, nominal + verb 'to have', present tense, 3rd person singular
#:>     nobody's somebody's one's
#:> PN+MD: pronoun, nominal + modal auxillary
#:>     someone'll somebody'll anybody'd
#:> PP$: determiner, possessive
#:>     our its his their my your her out thy mine thine
#:> PP$$: pronoun, possessive
#:>     ours mine his hers theirs yours
#:> PPL: pronoun, singular, reflexive
#:>     itself himself myself yourself herself oneself ownself
#:> PPLS: pronoun, plural, reflexive
#:>     themselves ourselves yourselves
#:> PPO: pronoun, personal, accusative
#:>     them it him me us you 'em her thee we'uns
#:> PPS: pronoun, personal, nominative, 3rd person singular
#:>     it he she thee
#:> PPS+BEZ: pronoun, personal, nominative, 3rd person singular + verb 'to be', present tense, 3rd person singular
#:>     it's he's she's
#:> PPS+HVD: pronoun, personal, nominative, 3rd person singular + verb 'to have', past tense
#:>     she'd he'd it'd
#:> PPS+HVZ: pronoun, personal, nominative, 3rd person singular + verb 'to have', present tense, 3rd person singular
#:>     it's he's she's
#:> PPS+MD: pronoun, personal, nominative, 3rd person singular + modal auxillary
#:>     he'll she'll it'll he'd it'd she'd
#:> PPSS: pronoun, personal, nominative, not 3rd person singular
#:>     they we I you ye thou you'uns
#:> PPSS+BEM: pronoun, personal, nominative, not 3rd person singular + verb 'to be', present tense, 1st person singular
#:>     I'm Ahm
#:> PPSS+BER: pronoun, personal, nominative, not 3rd person singular + verb 'to be', present tense, 2nd person singular or all persons plural
#:>     we're you're they're
#:> PPSS+BEZ: pronoun, personal, nominative, not 3rd person singular + verb 'to be', present tense, 3rd person singular
#:>     you's
#:> PPSS+BEZ*: pronoun, personal, nominative, not 3rd person singular + verb 'to be', present tense, 3rd person singular, negated
#:>     'tain't
#:> PPSS+HV: pronoun, personal, nominative, not 3rd person singular + verb 'to have', uninflected present tense
#:>     I've we've they've you've
#:> PPSS+HVD: pronoun, personal, nominative, not 3rd person singular + verb 'to have', past tense
#:>     I'd you'd we'd they'd
#:> PPSS+MD: pronoun, personal, nominative, not 3rd person singular + modal auxillary
#:>     you'll we'll I'll we'd I'd they'll they'd you'd
#:> PPSS+VB: pronoun, personal, nominative, not 3rd person singular + verb 'to verb', uninflected present tense
#:>     y'know
#:> QL: qualifier, pre
#:>     well less very most so real as highly fundamentally even how much
#:>     remarkably somewhat more completely too thus ill deeply little overly
#:>     halfway almost impossibly far severly such ...
#:> QLP: qualifier, post
#:>     indeed enough still 'nuff
#:> RB: adverb
#:>     only often generally also nevertheless upon together back newly no
#:>     likely meanwhile near then heavily there apparently yet outright fully
#:>     aside consistently specifically formally ever just ...
#:> RB$: adverb, genitive
#:>     else's
#:> RB+BEZ: adverb + verb 'to be', present tense, 3rd person singular
#:>     here's there's
#:> RB+CS: adverb + conjunction, coordinating
#:>     well's soon's
#:> RBR: adverb, comparative
#:>     further earlier better later higher tougher more harder longer sooner
#:>     less faster easier louder farther oftener nearer cheaper slower tighter
#:>     lower worse heavier quicker ...
#:> RBR+CS: adverb, comparative + conjunction, coordinating
#:>     more'n
#:> RBT: adverb, superlative
#:>     most best highest uppermost nearest brightest hardest fastest deepest
#:>     farthest loudest ...
#:> RN: adverb, nominal
#:>     here afar then
#:> RP: adverb, particle
#:>     up out off down over on in about through across after
#:> RP+IN: adverb, particle + preposition
#:>     out'n outta
#:> TO: infinitival to
#:>     to t'
#:> TO+VB: infinitival to + verb, infinitive
#:>     t'jawn t'lah
#:> UH: interjection
#:>     Hurrah bang whee hmpf ah goodbye oops oh-the-pain-of-it ha crunch say
#:>     oh why see well hello lo alas tarantara rum-tum-tum gosh hell keerist
#:>     Jesus Keeeerist boy c'mon 'mon goddamn bah hoo-pig damn ...
#:> VB: verb, base: uninflected present, imperative or infinitive
#:>     investigate find act follow inure achieve reduce take remedy re-set
#:>     distribute realize disable feel receive continue place protect
#:>     eliminate elaborate work permit run enter force ...
#:> VB+AT: verb, base: uninflected present or infinitive + article
#:>     wanna
#:> VB+IN: verb, base: uninflected present, imperative or infinitive + preposition
#:>     lookit
#:> VB+JJ: verb, base: uninflected present, imperative or infinitive + adjective
#:>     die-dead
#:> VB+PPO: verb, uninflected present tense + pronoun, personal, accusative
#:>     let's lemme gimme
#:> VB+RP: verb, imperative + adverbial particle
#:>     g'ahn c'mon
#:> VB+TO: verb, base: uninflected present, imperative or infinitive + infinitival to
#:>     wanta wanna
#:> VB+VB: verb, base: uninflected present, imperative or infinitive; hypenated pair
#:>     say-speak
#:> VBD: verb, past tense
#:>     said produced took recommended commented urged found added praised
#:>     charged listed became announced brought attended wanted voted defeated
#:>     received got stood shot scheduled feared promised made ...
#:> VBG: verb, present participle or gerund
#:>     modernizing improving purchasing Purchasing lacking enabling pricing
#:>     keeping getting picking entering voting warning making strengthening
#:>     setting neighboring attending participating moving ...
#:> VBG+TO: verb, present participle + infinitival to
#:>     gonna
#:> VBN: verb, past participle
#:>     conducted charged won received studied revised operated accepted
#:>     combined experienced recommended effected granted seen protected
#:>     adopted retarded notarized selected composed gotten printed ...
#:> VBN+TO: verb, past participle + infinitival to
#:>     gotta
#:> VBZ: verb, present tense, 3rd person singular
#:>     deserves believes receives takes goes expires says opposes starts
#:>     permits expects thinks faces votes teaches holds calls fears spends
#:>     collects backs eliminates sets flies gives seeks reads ...
#:> WDT: WH-determiner
#:>     which what whatever whichever whichever-the-hell
#:> WDT+BER: WH-determiner + verb 'to be', present tense, 2nd person singular or all persons plural
#:>     what're
#:> WDT+BER+PP: WH-determiner + verb 'to be', present, 2nd person singular or all persons plural + pronoun, personal, nominative, not 3rd person singular
#:>     whaddya
#:> WDT+BEZ: WH-determiner + verb 'to be', present tense, 3rd person singular
#:>     what's
#:> WDT+DO+PPS: WH-determiner + verb 'to do', uninflected present tense + pronoun, personal, nominative, not 3rd person singular
#:>     whaddya
#:> WDT+DOD: WH-determiner + verb 'to do', past tense
#:>     what'd
#:> WDT+HVZ: WH-determiner + verb 'to have', present tense, 3rd person singular
#:>     what's
#:> WP$: WH-pronoun, genitive
#:>     whose whosever
#:> WPO: WH-pronoun, accusative
#:>     whom that who
#:> WPS: WH-pronoun, nominative
#:>     that who whoever whosoever what whatsoever
#:> WPS+BEZ: WH-pronoun, nominative + verb 'to be', present, 3rd person singular
#:>     that's who's
#:> WPS+HVD: WH-pronoun, nominative + verb 'to have', past tense
#:>     who'd
#:> WPS+HVZ: WH-pronoun, nominative + verb 'to have', present tense, 3rd person singular
#:>     who's that's
#:> WPS+MD: WH-pronoun, nominative + modal auxillary
#:>     who'll that'd who'd that'll
#:> WQL: WH-qualifier
#:>     however how
#:> WRB: WH-adverb
#:>     however when where why whereby wherever how whenever whereon wherein
#:>     wherewith wheare wherefore whereof howsabout
#:> WRB+BER: WH-adverb + verb 'to be', present, 2nd person singular or all persons plural
#:>     where're
#:> WRB+BEZ: WH-adverb + verb 'to be', present, 3rd person singular
#:>     how's where's
#:> WRB+DO: WH-adverb + verb 'to do', present, not 3rd person singular
#:>     howda
#:> WRB+DOD: WH-adverb + verb 'to do', past tense
#:>     where'd how'd
#:> WRB+DOD*: WH-adverb + verb 'to do', past tense, negated
#:>     whyn't
#:> WRB+DOZ: WH-adverb + verb 'to do', present tense, 3rd person singular
#:>     how's
#:> WRB+IN: WH-adverb + preposition
#:>     why'n
#:> WRB+MD: WH-adverb + modal auxillary
#:>     where'd
```

### Tagging Techniques

There are few types of tagging techniques:  

- Lexical-based  
- Rule-based  (Brill)
- Probalistic/Stochastic-based  (Conditional Random Fields-CRFs, Hidden Markov Models-HMM)
- Neural network-based  

NLTK supports the below taggers: 
```
from nltk.tag.brill      import BrillTagger
from nltk.tag.hunpos     import HunposTagger
from nltk.tag.stanford   import StanfordTagger, StanfordPOSTagger, StanfordNERTagger
from nltk.tag.hmm        import HiddenMarkovModelTagger, HiddenMarkovModelTrainer
from nltk.tag.senna      import SennaTagger, SennaChunkTagger, SennaNERTagger
from nltk.tag.crf        import CRFTagger
from nltk.tag.perceptron import PerceptronTagger
```

#### nltk `PerceptronTagger` 

PerceptronTagger produce tags with **Penn Treebank** tagset


```python
from nltk.tag import PerceptronTagger

nltk.download('averaged_perceptron_tagger')
```

```
#:> True
#:> 
#:> [nltk_data] Downloading package averaged_perceptron_tagger to
#:> [nltk_data]     /home/msfz751/nltk_data...
#:> [nltk_data]   Package averaged_perceptron_tagger is already up-to-
#:> [nltk_data]       date!
```

```python
tagger = PerceptronTagger()
print('Tagger Classes:', tagger.classes, 
      '\n\n# Classes:', len(tagger.classes))
```

```
#:> Tagger Classes: {'RP', 'JJR', 'CC', 'VBZ', 'IN', 'UH', 'DT', 'VBN', 'NN', 'NNS', 'PRP', 'VBG', "''", 'PRP$', 'POS', 'WP$', 'NNPS', ':', 'FW', '(', 'WP', 'NNP', 'RBR', 'VBP', 'TO', '``', 'RB', 'WRB', 'PDT', 'MD', 'JJ', 'VB', '.', '#', 'LS', ')', 'RBS', ',', 'SYM', 'CD', 'JJS', 'VBD', '$', 'WDT', 'EX'} 
#:> 
#:> # Classes: 45
```

### Performing Tagging `nltk.pos_tag()`

Tagging works sentence by sentence:  

- Document fist must be splitted into sentences  
- Each sentence need to be tokenized into words  
- Default NTLK uses `PerceptronTagger`


```python
#nltk.download('averaged_perceptron_tagger')
#import nltk
#from nltk.tokenize import word_tokenize, sent_tokenize 
doc = '''Sukanya, Rajib and Naba are my good friends. Sukanya is getting married next year. Marriage is a big step in one's life. It is both exciting and frightening. But friendship is a sacred bond between people. It is a special kind of love between us. Many of you must have tried searching for a friend but never found the right one.'''

sentences = nltk.sent_tokenize(doc)
for sentence in sentences:
  tokens = nltk.word_tokenize(sentence)
  tagged = nltk.pos_tag(tokens)
  print(tagged)
```

```
#:> [('Sukanya', 'NNP'), (',', ','), ('Rajib', 'NNP'), ('and', 'CC'), ('Naba', 'NNP'), ('are', 'VBP'), ('my', 'PRP$'), ('good', 'JJ'), ('friends', 'NNS'), ('.', '.')]
#:> [('Sukanya', 'NNP'), ('is', 'VBZ'), ('getting', 'VBG'), ('married', 'VBN'), ('next', 'JJ'), ('year', 'NN'), ('.', '.')]
#:> [('Marriage', 'NN'), ('is', 'VBZ'), ('a', 'DT'), ('big', 'JJ'), ('step', 'NN'), ('in', 'IN'), ('one', 'CD'), ("'s", 'POS'), ('life', 'NN'), ('.', '.')]
#:> [('It', 'PRP'), ('is', 'VBZ'), ('both', 'DT'), ('exciting', 'VBG'), ('and', 'CC'), ('frightening', 'NN'), ('.', '.')]
#:> [('But', 'CC'), ('friendship', 'NN'), ('is', 'VBZ'), ('a', 'DT'), ('sacred', 'JJ'), ('bond', 'NN'), ('between', 'IN'), ('people', 'NNS'), ('.', '.')]
#:> [('It', 'PRP'), ('is', 'VBZ'), ('a', 'DT'), ('special', 'JJ'), ('kind', 'NN'), ('of', 'IN'), ('love', 'NN'), ('between', 'IN'), ('us', 'PRP'), ('.', '.')]
#:> [('Many', 'JJ'), ('of', 'IN'), ('you', 'PRP'), ('must', 'MD'), ('have', 'VB'), ('tried', 'VBN'), ('searching', 'VBG'), ('for', 'IN'), ('a', 'DT'), ('friend', 'NN'), ('but', 'CC'), ('never', 'RB'), ('found', 'VBD'), ('the', 'DT'), ('right', 'JJ'), ('one', 'NN'), ('.', '.')]
```

## Sentiment

### NLTK and Senti-Wordnet

- SentiWordNet **extends Wordnet Synsets** with positive and negative sentiment scores  
- The extension was achieved via a complex mix of propagation methods and classifiers. It is thus not a gold standard resource like WordNet (which was compiled by humans), but it has proven useful in a wide range of tasks  
- It contains similar number of synsets as wordnet


```python
from nltk.corpus import sentiwordnet as swn
nltk.download('sentiwordnet')
```

```
#:> True
#:> 
#:> [nltk_data] Downloading package sentiwordnet to
#:> [nltk_data]     /home/msfz751/nltk_data...
#:> [nltk_data]   Package sentiwordnet is already up-to-date!
```

```python
s = set( swn.all_senti_synsets() )
print('Total synsets in senti-wordnet  : ' ,   len(s))
```

```
#:> Total synsets in senti-wordnet  :  117659
```

#### Senti-Synset

- Senti-Wordnet extends wordnet with three(3) sentiment scores: positive, negative, objective  
- All three scores added up to value 1.0


```python
breakdown = swn.senti_synset('breakdown.n.03')
print(
  breakdown, '\n'
  'Positive:', breakdown.pos_score(), '\n',
  'Negative:', breakdown.neg_score(), '\n',
  'Objective:',breakdown.obj_score()
)
```

```
#:> <breakdown.n.03: PosScore=0.0 NegScore=0.25> 
#:> Positive: 0.0 
#:>  Negative: 0.25 
#:>  Objective: 0.75
```

#### Senti-Synsets

Get all the synonmys, with and without the POS information


```python
print( list(swn.senti_synsets('slow')), '\n\n',  ## without POS tag
       list(swn.senti_synsets('slow', 'a')) )   ## with POS tag
```

```
#:> [SentiSynset('decelerate.v.01'), SentiSynset('slow.v.02'), SentiSynset('slow.v.03'), SentiSynset('slow.a.01'), SentiSynset('slow.a.02'), SentiSynset('dense.s.04'), SentiSynset('slow.a.04'), SentiSynset('boring.s.01'), SentiSynset('dull.s.08'), SentiSynset('slowly.r.01'), SentiSynset('behind.r.03')] 
#:> 
#:>  [SentiSynset('slow.a.01'), SentiSynset('slow.a.02'), SentiSynset('dense.s.04'), SentiSynset('slow.a.04'), SentiSynset('boring.s.01'), SentiSynset('dull.s.08')]
```

Get the score for first synset


```python
first_synset = list(swn.senti_synsets('slow','a'))[0]

print(
  first_synset, '\n',
  'Positive:',  first_synset.pos_score(), '\n',
  'Negative:',  first_synset.neg_score(), '\n',
  'Objective:', first_synset.obj_score()
)
```

```
#:> <slow.a.01: PosScore=0.0 NegScore=0.0> 
#:>  Positive: 0.0 
#:>  Negative: 0.0 
#:>  Objective: 1.0
```

#### Converting POS-tag into Wordnet POS-tag

**Using Function**


```python
import nltk
from nltk.tokenize import word_tokenize
from nltk.corpus import wordnet as wn

def penn_to_wn(tag):
    """
    Convert between the PennTreebank tags to simple Wordnet tags
    """
    if tag.startswith('J'):
        return wn.ADJ
    elif tag.startswith('N'):
        return wn.NOUN
    elif tag.startswith('R'):
        return wn.ADV
    elif tag.startswith('V'):
        return wn.VERB
    return None

wt = word_tokenize("Star Wars is a wonderful movie")
penn_tags = nltk.pos_tag(wt)
wordnet_tags = [ (x, penn_to_wn(y)) for (x,y) in penn_tags ]

print(
'Penn Tags    :', penn_tags, 
'\nWordnet Tags :', wordnet_tags)
```

```
#:> Penn Tags    : [('Star', 'NNP'), ('Wars', 'NNP'), ('is', 'VBZ'), ('a', 'DT'), ('wonderful', 'JJ'), ('movie', 'NN')] 
#:> Wordnet Tags : [('Star', 'n'), ('Wars', 'n'), ('is', 'v'), ('a', None), ('wonderful', 'a'), ('movie', 'n')]
```

**Using defaultdict**


```python
import nltk
from nltk.corpus import wordnet as wn
from nltk import word_tokenize, pos_tag
from collections import defaultdict

tag_map = defaultdict(lambda : None)
tag_map['J'] = wn.ADJ
tag_map['R'] = wn.ADV
tag_map['V'] = wn.VERB
tag_map['N'] = wn.NOUN

wt = word_tokenize("Star Wars is a wonderful movie")
penn_tags = nltk.pos_tag(wt)
wordnet_tags = [ (x, tag_map[y[0]]) for (x,y) in penn_tags ]

print(
'Penn Tags    :', penn_tags, 
'\nWordnet Tags :', wordnet_tags)
```

```
#:> Penn Tags    : [('Star', 'NNP'), ('Wars', 'NNP'), ('is', 'VBZ'), ('a', 'DT'), ('wonderful', 'JJ'), ('movie', 'NN')] 
#:> Wordnet Tags : [('Star', 'n'), ('Wars', 'n'), ('is', 'v'), ('a', None), ('wonderful', 'a'), ('movie', 'n')]
```

### Vader

- It is a rule based sentiment analyzer, contain 7503 lexicons
- It is good for **social media** because lexicon contain **emoji and short** form text
- Contain only **3 n-gram**
- Supported by NTLK or install vader seperately (pip install vaderSentiment)  

#### Vader Lexicon

The lexicon is a dictionary. To make it iterable, need to convert into list:  
- Step 1: Convert `dict` to `dict_items`, which is a list containing items, each item is one dict  
- Step 2: Unpack `dict_items` to `list`


```python
#from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer   ## seperate pip installed library
from nltk.sentiment.vader import SentimentIntensityAnalyzer

nltk.download('vader_lexicon')
```

```
#:> True
#:> 
#:> [nltk_data] Downloading package vader_lexicon to
#:> [nltk_data]     /home/msfz751/nltk_data...
#:> [nltk_data]   Package vader_lexicon is already up-to-date!
```

```python
vader_lex  = SentimentIntensityAnalyzer().lexicon  # get the lexicon dictionary
vader_list = list(vader_lex.items())               # convert to items then list
print( 'Total Vader Lexicon:', len(vader_lex),'\n',
        vader_list[1:10], vader_list[220:240] )
```

```
#:> Total Vader Lexicon: 7502 
#:>  [('%)', -0.4), ('%-)', -1.5), ('&-:', -0.4), ('&:', -0.7), ("( '}{' )", 1.6), ('(%', -0.9), ("('-:", 2.2), ("(':", 2.3), ('((-:', 2.1)] [('b^d', 2.6), ('cwot', -2.3), ("d-':", -2.5), ('d8', -3.2), ('d:', 1.2), ('d:<', -3.2), ('d;', -2.9), ('d=', 1.5), ('doa', -2.3), ('dx', -3.0), ('ez', 1.5), ('fav', 2.0), ('fcol', -1.8), ('ff', 1.8), ('ffs', -2.8), ('fkm', -2.4), ('foaf', 1.8), ('ftw', 2.0), ('fu', -3.7), ('fubar', -3.0)]
```

**There is only four N-Gram in the lexicon**


```python
print('List of N-grams: ')
```

```
#:> List of N-grams:
```

```python
[ (tok,score) for tok, score in vader_list if " " in tok]
```

```
#:> [("( '}{' )", 1.6), ("can't stand", -2.0), ('fed up', -1.8), ('screwed up', -1.5)]
```

If stemming or lemmatization is used, stem/lemmatize the vader lexicon too


```python
[ (tok,score) for tok, score in vader_list if "lov" in tok]
```

```
#:> [('beloved', 2.3), ('lovable', 3.0), ('love', 3.2), ('loved', 2.9), ('lovelies', 2.2), ('lovely', 2.8), ('lover', 2.8), ('loverly', 2.8), ('lovers', 2.4), ('loves', 2.7), ('loving', 2.9), ('lovingly', 3.2), ('lovingness', 2.7), ('unlovable', -2.7), ('unloved', -1.9), ('unlovelier', -1.9), ('unloveliest', -1.9), ('unloveliness', -2.0), ('unlovely', -2.1), ('unloving', -2.3)]
```

#### Polarity Scoring

Scoring result is a dictionary of:

- neg
- neu
- pos
- compound
**neg, neu, pos adds up to 1.0**

Example below shows polarity for two sentences:


```python
corpus = ["Python is a very useful but hell difficult to learn",
        ":) :) :("]
for doc in corpus:
  print(doc, '-->', "\n:", SentimentIntensityAnalyzer().polarity_scores(doc) )
```

```
#:> Python is a very useful but hell difficult to learn --> 
#:> : {'neg': 0.554, 'neu': 0.331, 'pos': 0.116, 'compound': -0.8735}
#:> :) :) :( --> 
#:> : {'neg': 0.326, 'neu': 0.0, 'pos': 0.674, 'compound': 0.4767}
```

## Feature Representation

### The Data

A corpus is a collection of multiple documents. In the below example, each document is represented by a sentence.


```python
corpus = [
   'This is the first document, :)',
   'This document is the second document.',
   'And this is a third one',
   'Is this the first document?',
]
```

### Frequency Count

Using purely frequency count as a feature will obviously bias on long document (which contain a lot of words, hence words within the document will have very high frequency).

#### + Tokenizer

**Default Tokenizer**  
By default, vectorizer apply tokenizer to select minimum **2-chars alphanumeric words**.  Below **train** the vectorizer using **`fit_transform()`**.


```python
from sklearn.feature_extraction.text import CountVectorizer
vec = CountVectorizer()          # initialize the vectorizer
X   = vec.fit_transform(corpus)  # FIT the vectorizer, return fitted data
print(pd.DataFrame(X.toarray(), columns=vec.get_feature_names()),'\n\n',
      'Vocabulary: ', vec.vocabulary_)
```

```
#:>    and  document  first  is  one  second  the  third  this
#:> 0    0         1      1   1    0       0    1      0     1
#:> 1    0         2      0   1    0       1    1      0     1
#:> 2    1         0      0   1    1       0    0      1     1
#:> 3    0         1      1   1    0       0    1      0     1 
#:> 
#:>  Vocabulary:  {'this': 8, 'is': 3, 'the': 6, 'first': 2, 'document': 1, 'second': 5, 'and': 0, 'third': 7, 'one': 4}
```

**Custom Tokenizer**  
You can use a custom tokenizer, which is a **function that return list of words**. Example below uses nltk RegexpTokenizer function, which retains one or more alphanumeric characters.


```python
my_tokenizer = RegexpTokenizer(r'[a-zA-Z0-9\']+')  ## Custom Tokenizer
vec2 = CountVectorizer(tokenizer=my_tokenizer.tokenize) ## custom tokenizer's function
X2   = vec2.fit_transform(corpus)  # FIT the vectorizer, return fitted data
print(pd.DataFrame(X2.toarray(), columns=vec2.get_feature_names()),'\n\n',
      'Vocabulary: ', vec.vocabulary_)
```

```
#:>    a  and  document  first  is  one  second  the  third  this
#:> 0  0    0         1      1   1    0       0    1      0     1
#:> 1  0    0         2      0   1    0       1    1      0     1
#:> 2  1    1         0      0   1    1       0    0      1     1
#:> 3  0    0         1      1   1    0       0    1      0     1 
#:> 
#:>  Vocabulary:  {'this': 8, 'is': 3, 'the': 6, 'first': 2, 'document': 1, 'second': 5, 'and': 0, 'third': 7, 'one': 4}
```

**1 and 2-Word-Gram Tokenizer**  
Use `ngram_range()` to specify range of grams needed.


```python
vec3 = CountVectorizer(ngram_range=(1,2))          # initialize the vectorizer
X3   = vec3.fit_transform(corpus)     # FIT the vectorizer, return fitted data
print(pd.DataFrame(X3.toarray(), columns=vec3.get_feature_names()),'\n\n',
      'Vocabulary: ', vec.vocabulary_)
```

```
#:>    and  and this  document  document is  first  ...  third one  this  this document  \
#:> 0    0         0         1            0      1  ...          0     1              0   
#:> 1    0         0         2            1      0  ...          0     1              1   
#:> 2    1         1         0            0      0  ...          1     1              0   
#:> 3    0         0         1            0      1  ...          0     1              0   
#:> 
#:>    this is  this the  
#:> 0        1         0  
#:> 1        0         0  
#:> 2        1         0  
#:> 3        0         1  
#:> 
#:> [4 rows x 22 columns] 
#:> 
#:>  Vocabulary:  {'this': 8, 'is': 3, 'the': 6, 'first': 2, 'document': 1, 'second': 5, 'and': 0, 'third': 7, 'one': 4}
```

**Apply Trained Vectorizer**
Once the vectorizer had been trained, you can apply them on new corpus. **Tokens not in the vectorizer vocubulary are ignored**.


```python
new_corpus = ["My Name is Charlie Angel", "I love to watch Star Wars"]
XX = vec.transform(new_corpus)
pd.DataFrame(XX.toarray(), columns=vec.get_feature_names())
```

```
#:>    and  document  first  is  one  second  the  third  this
#:> 0    0         0      0   1    0       0    0      0     0
#:> 1    0         0      0   0    0       0    0      0     0
```

#### + Stop Words

Vectorizer can optionally be use with stop words list. Use `stop_words=english` to apply filtering using sklearn built-in stop word.  You can replace `english` with other word **list object**.


```python
vec4 = CountVectorizer(stop_words='english') ## sklearn stopwords list
X4 = vec4.fit_transform(corpus)
pd.DataFrame(X4.toarray(), columns=vec4.get_feature_names())
```

```
#:>    document  second
#:> 0         1       0
#:> 1         2       1
#:> 2         0       0
#:> 3         1       0
```

### TFIDF

#### Equation

$$tf(t,d) = \text{occurances of term t in document t} \\
n     = \text{number of documents} \\
df(t) = \text{number of documents containing term t} \\
idf(t)  = log \frac{n}{df(t))} + 1 \\
idf(t)  = log \frac{1+n}{1+df(t))} + 1 \text{.... smoothing, prevent zero division} \\
tfidf(t) = tf(t) * idf(t,d)    \text{.... raw, no normalization on tf(t)} \\
tfidf(t) = \frac{tf(t,d)}{||V||_2} * idf(t)    \text{.... tf normalized with euclidean norm}$$

#### `TfidfTransformer`

To generate TFIDF vectors, first run `CountVectorizer` to get frequency vector matrix. Then take the output into this transformer.


```python
from sklearn.feature_extraction.text import TfidfTransformer

corpus = [
    "apple apple apple apple apple banana",
    "apple apple",
    "apple apple apple banana",
    "durian durian durian"]
    
count_vec = CountVectorizer()
X = count_vec.fit_transform(corpus)

transformer1 = TfidfTransformer(smooth_idf=False,norm=None)
transformer2 = TfidfTransformer(smooth_idf=False,norm='l2')
transformer3 = TfidfTransformer(smooth_idf=True,norm='l2')

tfidf1 = transformer1.fit_transform(X)
tfidf2 = transformer2.fit_transform(X)
tfidf3 = transformer3.fit_transform(X)

print(
  'Frequency Count: \n', pd.DataFrame(X.toarray(), columns=count_vec.get_feature_names()),
  '\n\nVocabulary: ', count_vec.vocabulary_,
  '\n\nTFIDF Without Norm:\n',tfidf1.toarray(), 
  '\n\nTFIDF with L2 Norm:\n',tfidf2.toarray(),  
  '\n\nTFIDF with L2 Norm (smooth):\n',tfidf3.toarray())
```

```
#:> Frequency Count: 
#:>     apple  banana  durian
#:> 0      5       1       0
#:> 1      2       0       0
#:> 2      3       1       0
#:> 3      0       0       3 
#:> 
#:> Vocabulary:  {'apple': 0, 'banana': 1, 'durian': 2} 
#:> 
#:> TFIDF Without Norm:
#:>  [[6.43841036 1.69314718 0.        ]
#:>  [2.57536414 0.         0.        ]
#:>  [3.86304622 1.69314718 0.        ]
#:>  [0.         0.         7.15888308]] 
#:> 
#:> TFIDF with L2 Norm:
#:>  [[0.96711783 0.25432874 0.        ]
#:>  [1.         0.         0.        ]
#:>  [0.91589033 0.40142857 0.        ]
#:>  [0.         0.         1.        ]] 
#:> 
#:> TFIDF with L2 Norm (smooth):
#:>  [[0.97081492 0.23982991 0.        ]
#:>  [1.         0.         0.        ]
#:>  [0.92468843 0.38072472 0.        ]
#:>  [0.         0.         1.        ]]
```

#### `TfidfVectorizer`

This vectorizer gives end to end processing from corpus into TFIDF vector matrix, including tokenization, stopwords.


```python
from sklearn.feature_extraction.text import TfidfVectorizer
my_tokenizer = RegexpTokenizer(r'[a-zA-Z0-9\']+')  ## Custom Tokenizer

vec1 = TfidfVectorizer(tokenizer=my_tokenizer.tokenize,  stop_words='english') #default smooth_idf=True, norm='l2'
vec2 = TfidfVectorizer(tokenizer=my_tokenizer.tokenize, stop_words='english',smooth_idf=False)
vec3 = TfidfVectorizer(tokenizer=my_tokenizer.tokenize, stop_words='english', norm=None)

X1   = vec1.fit_transform(corpus)  # FIT the vectorizer, return fitted data
X2   = vec2.fit_transform(corpus)  # FIT the vectorizer, return fitted data
X3   = vec3.fit_transform(corpus)  # FIT the vectorizer, return fitted data

print(
  'TFIDF Features (Default with Smooth and L2 Norm):\n',
  pd.DataFrame(X1.toarray().round(3), columns=vec1.get_feature_names()),
  '\n\nTFIDF Features (without Smoothing):\n',
  pd.DataFrame(X2.toarray().round(3), columns=vec2.get_feature_names()),
  '\n\nTFIDF Features (without L2 Norm):\n',
  pd.DataFrame(X3.toarray().round(3), columns=vec3.get_feature_names())
  )
```

```
#:> TFIDF Features (Default with Smooth and L2 Norm):
#:>     apple  banana  durian
#:> 0  0.971   0.240     0.0
#:> 1  1.000   0.000     0.0
#:> 2  0.925   0.381     0.0
#:> 3  0.000   0.000     1.0 
#:> 
#:> TFIDF Features (without Smoothing):
#:>     apple  banana  durian
#:> 0  0.967   0.254     0.0
#:> 1  1.000   0.000     0.0
#:> 2  0.916   0.401     0.0
#:> 3  0.000   0.000     1.0 
#:> 
#:> TFIDF Features (without L2 Norm):
#:>     apple  banana  durian
#:> 0  6.116   1.511   0.000
#:> 1  2.446   0.000   0.000
#:> 2  3.669   1.511   0.000
#:> 3  0.000   0.000   5.749
```

## Appliction

### Document Similarity

Document1 and Document 2 are mutiplicate of Document0, therefore their consine similarity is the same.


```python
documents = (
    "apple apple banana",
    "apple apple banana apple apple banana",
    "apple apple banana apple apple banana apple apple banana")
    
from sklearn.feature_extraction.text import TfidfVectorizer
tfidf_vec = TfidfVectorizer()
tfidf_matrix = tfidf_vec.fit_transform(documents)

from sklearn.metrics.pairwise import cosine_similarity
print('Cosine Similarity betwen doc0 and doc1:\n',cosine_similarity(tfidf_matrix[0], tfidf_matrix[1]))
```

```
#:> Cosine Similarity betwen doc0 and doc1:
#:>  [[1.]]
```

```python
print('Cosine Similarity betwen doc1 and doc2:\n',cosine_similarity(tfidf_matrix[1], tfidf_matrix[2]))
```

```
#:> Cosine Similarity betwen doc1 and doc2:
#:>  [[1.]]
```

```python
print('Cosine Similarity betwen doc1 and doc2:\n',cosine_similarity(tfidf_matrix[0], tfidf_matrix[2]))
```

```
#:> Cosine Similarity betwen doc1 and doc2:
#:>  [[1.]]
```


## Naive Bayes

### Libraries


```python
from nlpia.data.loaders import get_data
from nltk.tokenize.casual     import casual_tokenize
from collections import Counter
```

### The Data


```python
movies = get_data('hutto_movies')   # download data
print(movies.head(), '\n\n',
      movies.describe())
```

```
#:>     sentiment                                               text
#:> id                                                              
#:> 1    2.266667  The Rock is destined to be the 21st Century's ...
#:> 2    3.533333  The gorgeously elaborate continuation of ''The...
#:> 3   -0.600000                     Effective but too tepid biopic
#:> 4    1.466667  If you sometimes like to go to the movies to h...
#:> 5    1.733333  Emerges as something rare, an issue movie that... 
#:> 
#:>            sentiment
#:> count  10605.000000
#:> mean       0.004831
#:> std        1.922050
#:> min       -3.875000
#:> 25%       -1.769231
#:> 50%       -0.080000
#:> 75%        1.833333
#:> max        3.941176
```

### Bag of Words

- Tokenize each record, remove single character token, then convert into list of counters (words-frequency pair).  
- Each item in the list is a counter, which represent word frequency within the record


```python
bag_of_words = []
for text in movies.text:
    tokens = casual_tokenize(text, reduce_len=True, strip_handles=True)  # tokenize
    tokens = [x for x in tokens if len(x)>1]                  ## remove single char token
    bag_of_words.append( Counter(tokens, strip_handles=True)  ## add to our BoW
    )

unique_words =  list( set([ y  for x in bag_of_words  for y in x.keys()]) )

print("Total Rows: ", len(bag_of_words),'\n\n',
      'Row 1 BoW: ',bag_of_words[:1],'\n\n',    # see the first two records
      'Row 2 BoW: ', bag_of_words[:2], '\n\n',
      'Total Unique Words: ', len(unique_words))
```

```
#:> Total Rows:  10605 
#:> 
#:>  Row 1 BoW:  [Counter({'to': 2, 'The': 1, 'Rock': 1, 'is': 1, 'destined': 1, 'be': 1, 'the': 1, '21st': 1, "Century's": 1, 'new': 1, 'Conan': 1, 'and': 1, 'that': 1, "he's": 1, 'going': 1, 'make': 1, 'splash': 1, 'even': 1, 'greater': 1, 'than': 1, 'Arnold': 1, 'Schwarzenegger': 1, 'Jean': 1, 'Claud': 1, 'Van': 1, 'Damme': 1, 'or': 1, 'Steven': 1, 'Segal': 1, 'strip_handles': 1})] 
#:> 
#:>  Row 2 BoW:  [Counter({'to': 2, 'The': 1, 'Rock': 1, 'is': 1, 'destined': 1, 'be': 1, 'the': 1, '21st': 1, "Century's": 1, 'new': 1, 'Conan': 1, 'and': 1, 'that': 1, "he's": 1, 'going': 1, 'make': 1, 'splash': 1, 'even': 1, 'greater': 1, 'than': 1, 'Arnold': 1, 'Schwarzenegger': 1, 'Jean': 1, 'Claud': 1, 'Van': 1, 'Damme': 1, 'or': 1, 'Steven': 1, 'Segal': 1, 'strip_handles': 1}), Counter({'of': 4, 'The': 2, 'gorgeously': 1, 'elaborate': 1, 'continuation': 1, 'Lord': 1, 'the': 1, 'Rings': 1, 'trilogy': 1, 'is': 1, 'so': 1, 'huge': 1, 'that': 1, 'column': 1, 'words': 1, 'cannot': 1, 'adequately': 1, 'describe': 1, 'co': 1, 'writer': 1, 'director': 1, 'Peter': 1, "Jackson's": 1, 'expanded': 1, 'vision': 1, "Tolkien's": 1, 'Middle': 1, 'earth': 1, 'strip_handles': 1})] 
#:> 
#:>  Total Unique Words:  20686
```

**Convert NaN into 0 then all features into integer**


```python
bows_df = pd.DataFrame.from_records(bag_of_words)
bows_df = bows_df.fillna(0).astype(int)  # replace NaN with 0, change to integer
bows_df.head()
```

```
#:>    The  Rock  is  destined  to  ...  Bearable  Staggeringly  ve  muttering  dissing
#:> 0    1     1   1         1   2  ...         0             0   0          0        0
#:> 1    2     0   1         0   0  ...         0             0   0          0        0
#:> 2    0     0   0         0   0  ...         0             0   0          0        0
#:> 3    0     0   1         0   4  ...         0             0   0          0        0
#:> 4    0     0   0         0   0  ...         0             0   0          0        0
#:> 
#:> [5 rows x 20686 columns]
```

### Build The Model


```python
from sklearn.naive_bayes import MultinomialNB
train_y  = movies.sentiment>0   # label
train_X  = bows_df              # features
nb_model = MultinomialNB().fit( train_X, train_y)
```

### Train Set Prediction

First, make a prediction on training data, then compare to ground truth. 


```python
train_predicted = nb_model.predict(bows_df)
print("Accuracy: ", np.mean(train_predicted==train_y).round(4))
```

```
#:> Accuracy:  0.9357
```

