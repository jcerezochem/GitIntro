LANG="en_EN.UTF8"
SHELL=/bin/bash

dist:compile_tutorial
	zip GitIntro.zip Tutorial/HandsOut/DoneCode -r
	zip GitIntro.zip Tutorial/HandsOut/Alice 
	zip GitIntro.zip Tutorial/HandsOut/Bob
	zip GitIntro.zip Tutorial/*pdf 
	zip GitIntro.zip Tutorial/*tex
	zip GitIntro.zip Presentation/*pdf

update_git_version:
	@echo ""
	@echo "==================================================="
	@git_hash=$$(git describe --long --dirty --always 2>/dev/null); \
	if (( $$? == 0 )); then \
	  echo "Current git version: $$git_hash"; \
	  git_date=$$(git show --date=format:'%B %d, %Y' -s --format=%cd 2>/dev/null); \
	  echo "Created on         : $$git_date"; \
	  echo "\renewcommand{\gitversion}{$$git_hash}" > Tutorial/version.tex; \
	  echo "\renewcommand{\gitdate}{$$git_date}"   >> Tutorial/version.tex; \
	fi
	@echo "==================================================="
	@echo ""

compile_tutorial:update_git_version
	cd Tutorial; pdflatex git_example.tex

