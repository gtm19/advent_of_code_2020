— Day 1: Report Repair —
================

## The Challenge

This can be read [here](https://adventofcode.com/2020/day/1)

## The Solution

### Reading in Data

``` r
nums <- 
  as.integer(
    readLines(here::here("puzzles", "day_01", "input.txt"))
  )

head(nums)
```

    ## [1] 1438  781 1917 1371 1336 1802

### Part 1

``` r
day_01_part1 <- function(nums, target = 2020L) {
  index <- 1
  
  while ({
    num_1 <- nums[index]
    other_nums <- setdiff(nums, num_1)
    !((target - num_1) %in% other_nums) && index <= length(nums)
  }) {
    index <- index + 1
  }
  
  return(nums[index] * (target - nums[index]))
}

day_01_part1(nums)
```

    ## [1] 1020099

### Part 2

``` r
day_01_part2 <- function(nums, target = 2020) {
  index <- 1
  while ({
    num_1 <- nums[index]
    other_nums <- setdiff(nums, num_1)
    is.na(
      part1 <- day_01_part1(other_nums, target - num_1)
      ) && index < length(nums)
  }) {
    index <- index + 1
  }
  return(num_1 * part1)
}

day_01_part2(nums)
```

    ## [1] 49214880
