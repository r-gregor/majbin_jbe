#!/bin/bash
sleep 7
while [ "$(dropbox status)" != "Up to date" ]; do
	gr_EXPR="$(dropbox status)"
	echo -e "${gr_EXPR} \n"
	sleep 1
done

echo -e "\nUP TO DATE ... Done."

### IMPORTANT:
### if [/bin/bash] is added at the end of the script, the terminal window
### stays open if called from another terminal window!!
### cal from terminal: $> xfce-terminal -e ~/majstaf/coding/<scriptname> ...
/bin/bash

