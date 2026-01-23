NAME=frish

# there are 3 steps
# 1. manual! cd dtree ; make ; copy/paste out.frish into forthish.frish
# 2. generate python code from forthish.frish
# 3. run the python code

all: run

run: frishc.py
	./run.sh frishc.py

frishc.py: forthish.frish
	node ./pbp/das/das2json.mjs $(NAME).drawio
	rm -f out.*
	python3 main.py . 'forthish.frish' main $(NAME).drawio.json | node ./pbp/kernel/splitoutput.js
	mv out.1.py frishc.py

forthish.frish : xinterpret.frish forthish.frish.m4
	m4 forthish.frish.m4 | tr -d '\r' > forthish.frish

xinterpret.frish : xinterpret.drawio
	python pbp/dtree.py . ./pbp xinterpret

init:
	npm install yargs prompt-sync ohm-js @xmldom/xmldom

