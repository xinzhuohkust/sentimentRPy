
# sentimentRPy #

<img align='left' src="sentiment.png" width="188">

Author: *Xinzhuo Huang*

Version: 0.1.0

An R package for sentence-level and word-level sentiment analysis which support vectorization, multithreading and is robust to errors.

<br>
<br>
<br>
<br>
<br>
<br>
<br>


## Installation
```
remotes::install_github("xinzhuohkust/sentimentRPy")
```
## Usage

### word-level sentiment analysis
```
sentimentRPy::get_sentimentR(
    text = c("I am happy", "I am sad"),
    method = "word"
    )
```
### sentence-level sentiment analysis 
sentence-level will take the linking words of contrast and negation into account.
```
sentimentRPy::get_sentimentR(
    text = "I am not happy, but I am also not unhappy.",
    method = "sentence"
    )
```
multithreading model using all availabel CPU cores.

```
sentimentRPy::get_sentimentR(
    text = a large corpus,
    method = "sentence", # or word
    multisession = TRUE
    )
```

### sentence-level with *spacy* and *asent*

```
asent <- sentimentRPy::asent_setup(python = "C:\\Users\\xhuangcb\\anaconda3\\envs\\pytorch_gpu\\python.exe")
```
```
sentimentRPy::get_sentimentPy("I am not happy, but I am also not unhappy.")
```


