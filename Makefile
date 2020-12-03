all: puzzles/day_*/*.md

puzzles/day_%/%.md: puzzles/day_%/%.Rmd
		Rscript \
		-e "knitr::knit(input = '$<', output = '$@')"
