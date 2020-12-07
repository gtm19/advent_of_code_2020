---
title: '--- Day 6: Custom Customs ---'
output: github_document
editor_options: 
  chunk_output_type: console
---



## The Challenge

This can be read [here](https://adventofcode.com/2020/day/6)

## The Solution

### Reading in Data


```r
questions <-
  readLines(
    here::here("puzzles", "day_06", "input.txt")
  )
```

### Part 1

First, I create a function which takes the vector of responses as an input, and returns a list containing one vector per response, and an attribute recording how many people submitted responses:


```r
cleanse_responses <- function(questions) {
  questions <- paste(questions, collapse ="\n")
  
  grouped_responses <- 
    strsplit(questions, "\n{2}")[[1]]
  
  lapply(
    grouped_responses,
    function(resp) {
      n_people <- length(strsplit(resp, "\n")[[1]])
      structure(
        regmatches(resp, gregexpr("\\w", resp))[[1]],
        n_people = n_people
      )
    }
  )
  
}

cleanse_responses(questions)[1]
```

```
## [[1]]
##  [1] "v" "m" "z" "o" "d" "a" "t" "s" "c" "n" "r" "f" "e" "k" "e" "p" "j" "k" "r"
## [20] "a" "b" "m" "i" "u" "s" "o" "f" "z" "c" "l" "t"
## attr(,"n_people")
## [1] 2
```

Then, for each of these cleansed responses, extract the length of the `unique()`d vector and add them up:


```r
summarise_responses <- function(questions, .fun) {
  sum(
    sapply(
      cleanse_responses(questions),
      .fun
    )
  )
}

summarise_responses(questions, function(x) length(unique(x)))
```

```
## [1] 6680
```

### Part 2

I just recycle the `summarise_responses()` function, but using a different summary `.fun()`:


```r
summarise_responses(
  questions, 
  function(x) sum(table(x) == attr(x, "n_people"))
)
```

```
## [1] 3117
```
