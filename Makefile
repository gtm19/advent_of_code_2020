src = $(wildcard puzzles/day_*/*.Rmd)
obj = $(src:.Rmd=.md)

all: $(obj)

$(obj): $(src)
		Rscript \
		-e "knitr::knit(input = '$<', output = '$@')"
