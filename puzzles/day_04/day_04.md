---
title: '--- Day 4: Passport Processing ---'
output: github_document
---



## The Challenge

This can be read [here](https://adventofcode.com/2020/day/4)

## The Solution

### Reading in Data


```r
passports <- readLines(
  here::here("puzzles", "day_04", "input.txt")
)

head(passports)
```

```
## [1] "ecl:hzl byr:1926 iyr:2010"                          
## [2] "pid:221225902 cid:61 hgt:186cm eyr:2021 hcl:#7d3b0c"
## [3] ""                                                   
## [4] "hcl:#efcc98 hgt:178 pid:433543520"                  
## [5] "eyr:2020 byr:1926"                                  
## [6] "ecl:blu cid:92"
```

### Part 1


```r
process_passports <- function(passports) {
  
  # Collapse into single string
  passports_squashed <- paste(passports, collapse = "\n")
  
  # Split on double newlines for each passport, and again on
  # single newlines or spaces for each category
  passports_split <- 
    strsplit(
      strsplit(passports_squashed, "\n{2}")[[1]], 
      "(\n|\\s)"
    )
  
  # For each 'passport', split each key:value into a named
  # list, and convert as necessary
  lapply(passports_split, function(passport_split) {
    
    k_v_splits <- strsplit(passport_split, ":")
    passport_details <- lapply(k_v_splits, `[[`, 2)
    names(passport_details) <- lapply(k_v_splits, `[[`, 1)
    
    passport_details[names(passport_details) %in% c("byr", "iyr", "eyr")] <- 
      as.integer(
        passport_details[names(passport_details) %in% c("byr", "iyr", "eyr")]
      )
    
    if (!is.null(passport_details$hgt)) {
      passport_details$hgt <-
        structure(
          as.integer(gsub("\\D", "", passport_details$hgt)),
          unit = gsub("[^(in|cm)]", "", passport_details$hgt)
        )
    }
    
    passport_details
  })
}

validate_part1 <- function(processed_pp, 
                           required_cols = c(
                             "byr",
                             "iyr",
                             "eyr",
                             "hgt",
                             "hcl",
                             "ecl",
                             "pid"
                           )) {
  sum(names(processed_pp) %in% required_cols) == length(required_cols)
}

sum(
  sapply(process_passports(passports), validate_part1)
)
```

```
## [1] 237
```

### Part 2


```r
validate_part2 <- function(processed_pp, 
                           required_cols = c(
                             "byr",
                             "iyr",
                             "eyr",
                             "hgt",
                             "hcl",
                             "ecl",
                             "pid"
                           )) {
  sum(names(processed_pp) %in% required_cols) == length(required_cols) &&
    # birth year:
    processed_pp$byr >= 1920 && processed_pp$byr <= 2002 &&
    
    # issue year:
    processed_pp$iyr >= 2010 && processed_pp$iyr <= 2020 &&
    
    # expiry year:
    processed_pp$eyr >= 2020 && processed_pp$eyr <= 2030 &&
    
    # hair colour:
    grepl("^#[a-f0-9]{6}$", processed_pp$hcl) &&
    
    # eye colour:
    processed_pp$ecl %in% c("amb", "blu", "brn", "gry", "grn", "hzl", "oth") &&
    
    # passport id:
    grepl("^\\d{9}$", processed_pp$pid) &&
    
    # height:
    if ((unit <- attr(hgt <- processed_pp$hgt, "unit")) == "in") {
      hgt >= 59 && hgt <= 76
    } else if (unit == "cm") {
      hgt >= 150 && hgt <= 193 
    } else {
      FALSE
    }
}

sum(
  sapply(process_passports(passports), validate_part2)
)
```

```
## [1] 172
```

