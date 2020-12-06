---
title: '--- Day 5: Binary Boarding ---'
output: github_document
---



## The Challenge

This can be read [here](https://adventofcode.com/2020/day/5)

## The Solution

### Reading in Data


```r
seats <- readLines(
  here::here("puzzles", "day_05", "input.txt")
)
```

### Part 1

First, a function which takes a vector of codes [for example `c("R", "L", "R")`] and returns the column or row number.


```r
get_num <- function(code, .order = c("F", "B")) {
  
  rows_cols <- 1:2^(length(code)) - 1
  for (i in seq_along(code)) {
    
    rows_cols <- 
      split(
        rows_cols, 
        ifelse(seq_along(rows_cols) <= length(rows_cols) / 2, .order[1], .order[2])
      )[[code[i]]]
  }
  
  rows_cols
  
}
```

Then recursively use this function to extract the column number and row number of each seat, combining them as specified, and grabbing the highest number.


```r
seat_numbers <- 
  sapply(
    strsplit(seats, ""),
    function(seat_code) {
      
      col_code <- seat_code[seat_code %in% (lr <- c("L", "R"))]
      row_code <- seat_code[seat_code %in% (fb <- c("F", "B"))]
      
      (get_num(row_code, fb) * 8) + get_num(col_code, lr)
      
    }
  )

max(seat_numbers)
```

```
## [1] 930
```

### Part 2


```r
all_possible_seats <- sort(as.vector(outer(1:8, 8 * 1:128, FUN = `+`)))

missing_seats <- setdiff(all_possible_seats, sort(seat_numbers))

missing_seats[diff(missing_seats) > 1][2]
```

```
## [1] 515
```
