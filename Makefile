NAME=frish
all: generate

run:
	./run.sh out.1.py

generate:
	node ./pbp/das/das2json.mjs $(NAME).drawio
	python3 main.py . 'forthish.frish' main $(NAME).drawio.json | node ./pbp/kernel/splitoutput.js

init:
	npm install yargs prompt-sync ohm-js @xmldom/xmldom
