NAME=frish

# there are 3 steps
# 1. manual! cd dtree ; make ; copy/paste out.frish into forthish.frish
# 2. generate python code from forthish.frish
# 3. run the python code

# frish is the name of the transmogrifier
# forthish.frish is a version of forth written in .frish syntax

all: run

run: forthish.py
	./run.sh forthish.py

forthish.py: forthish.frish
	node ./pbp/das/das2json.mjs $(NAME).drawio
	rm -f out.*
	python3 main.py . 'forthish.frish' main $(NAME).drawio.json | node ./pbp/kernel/splitoutput.js
	mv out.1.py forthish.py

forthish.frish : xinterpret.frish forthish.frish.m4
	m4 forthish.frish.m4 | tr -d '\r' > forthish.frish

xinterpret.frish : xinterpret.drawio
	pbp/dtree.sh . ./pbp xinterpret

init:
	npm install yargs prompt-sync ohm-js @xmldom/xmldom


dev:
	rm -f out.*
	rm -f pbp/dtree/out.*
	pbp/dtree.sh . ./pbp xinterpret
	m4 forthish.frish.m4 | tr -d '\r' > forthish.frish
	node ./pbp/das/das2json.mjs $(NAME).drawio
	rm -f out.*
	python3 main.py . 'forthish.frish' main $(NAME).drawio.json | node ./pbp/kernel/splitoutput.js
	mv out.1.py forthish.py
