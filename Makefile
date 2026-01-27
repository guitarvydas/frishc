NAME=frish

# there are 3 steps
# 1. manual! cd dtree ; make ; copy/paste out.frish into forthish.frish
# 2. generate python code from forthish.frish
# 3. run the python code

all: run

run: generate
	./run.sh out.1.py

generate: forthish.frish
	node ./pbp/das/das2json.mjs $(NAME).drawio
	rm -f out.*
	python3 main.py . 'forthish.frish' main $(NAME).drawio.json | node ./pbp/kernel/splitoutput.js

forthish.frish : ./dtree/out.frish forthish.frish.m4
	m4 forthish.frish.m4 | tr -d '\r' > forthish.frish

./dtree/out.frish : ./xinterpret.drawio
	rm -f out.*
	~/projects/pbp-dev/runpbp ~/projects/pbp-dev/dtree/dtree-transmogrifier ./pbp ./xinterpret.drawio
	echo
	echo "DONE 1"
	echo

init:
	npm install yargs prompt-sync ohm-js @xmldom/xmldom
