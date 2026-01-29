NAME=frish

# there are several steps
# 1. convert the diagram 'xinterpret.drawio' to 'out.frish' ("frish" is a meta-language that looks a lot like Python)
# 2. include the generated code into 'forthish.frish.m4' to create 'forthish.frish'
# 3. generate python code from forthish.frish
# 4. run the python code

# the diagram 'xinterpret.drawio' is only part of the program 'forthish.frish', it only covers one function
# within 'forthish.frish' that is easier to sketch than to manually write code for
# the diagram is basically a skeleton of control flow that shows which functions to call under which
# conditions
# the diagram converter does no "type checking" - it leaves that sort of heavy lifting up to the
# python/js/etc compiler (the .frish converter doesn't do any checking, either, but, it does stick comments
# into the generated code to make it easier to relate any problems back to the original .frish code)

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
	./pbp/runpbp ./pbp/dtree/dtree-transmogrifier.drawio ./pbp ./xinterpret.drawio

init:
	npm install yargs prompt-sync ohm-js @xmldom/xmldom
