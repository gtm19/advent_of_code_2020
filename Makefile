rmd_files = $(wildcard puzzles/*/*.Rmd)
md_files = $(rmd_files:.Rmd=.md)

all: $(md_files)

%.md: %.Rmd
	Rscript \
	-e "knitr::knit(input = '$<', output = '$@')"

clean:
	rm -f $(md_files)
