NAME=frish

# there are 3 steps
# 1. manual! cd dtree ; make ; copy/paste out.frish into forthish.frish
# 2. generate python code from forthish.frish
# 3. run the python code

all: run

run: generate
	./run.sh out.1.py

generate:
	node ./pbp/das/das2json.mjs $(NAME).drawio
	python3 main.py . 'forthish.frish' main $(NAME).drawio.json | node ./pbp/kernel/splitoutput.js

init:
	npm install yargs prompt-sync ohm-js @xmldom/xmldom
