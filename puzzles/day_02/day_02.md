---
title: '--- Day 2: Password Philosophy ---'
output: github_document
---



## The Challenge

This can be read [here](https://adventofcode.com/2020/day/2)

## The Solution

### Reading in Data


```r
passwords <- 
  readLines(here::here("puzzles", "day_02", "input.txt"))

head(passwords)
```

```
## [1] "3-4 j: tjjj"                "7-10 h: nhhhhhgghphhh"     
## [3] "7-13 j: tpscbbstbdjsjbtcpj" "4-13 l: ckllmqzlvcsxpplqg" 
## [5] "3-11 n: nnrhnnnnnnnwsdnnnm" "5-6 d: ddddddb"
```

### Part 1


```r
test_1_function <- function(match) {
  appearances <- 
    length(
      gregexpr(match[4], match[5])[[1]]
    )

  appearances >= as.integer(match[2]) && appearances <= as.integer(match[3])
}

check_passwords <- function(passwords, check_fun) {
  matches <-
    regmatches(
      passwords, regexec(
        pattern = "(\\d+)-(\\d+) (\\w): (.+)", 
        passwords
      )
    )

  valid_test <-
    sapply(matches, check_fun)

  sum(valid_test)
}

check_passwords(passwords, test_1_function)
```

```
## [1] 483
```

### Part 2


```r
test_2_function <- function(match) {
  pw_split <- regmatches(match[5], gregexpr("\\w", match[5]))[[1]]
  sum(match[4] == pw_split[as.integer(match[2:3])]) == 1
}

check_passwords(passwords, test_2_function)
```

```
## [1] 482
```

