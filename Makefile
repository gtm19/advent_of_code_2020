puzzle_rmds = $(wildcard puzzles/*/*.Rmd)
puzzle_mds = $(puzzle_rmds:.Rmd=.md)

all: $(puzzle_mds)

%.md: %.Rmd
	Rscript \
	-e "knitr::knit(input = '$<', output = '$@')"

clean:
	rm -f puzzles/day_*/*.md
