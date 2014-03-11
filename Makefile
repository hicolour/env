today = sh date +"%d.%m.%Y"
clean: clean-workspace

base: 
	./.utils/install-base.sh
	./.utils/setup-base.sh


clean-workspace: 
	rm -rf workspace

copy: clean-workspace
	mkdir workspace
	cp Makefile workspace/
	cp *.tex workspace/
	#cp *.png workspace/
	cp *.jpg workspace/
	cp latex-util/* workspace/
	cp latex-font-georgia/* workspace/

pdf: copy
	make -C workspace workspace-pdf
	cp -rf workspace/*.pdf .
	make clean-workspace

install: 
	cp latex-font-georgia/texmf ~/

workspace-pdf:
	-pdflatex *CV*.tex


dev: copy
	make -C workspace workspace-pdf
	cp -rf workspace/*.pdf .