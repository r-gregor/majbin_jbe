#! /usr/bin/env bash

# ptn3="/usr/local/bin/python3.9"
ptn3="/usr/bin/python3"
PY3="./venv/bin/python3"

# venv_s1
echo "Creating virtual environment ./venv ..."
${ptn3} -m venv venv

echo "Upgrading pip to latest version ..."
${PY3} -m pip install --upgrade pip


# venv_s2
FILE=$(realpath ./requirements.txt)
echo $FILE

if [ -f $FILE ]; then
     echo "Installing required dependencies from requirements.txt ..."
     ${PY3} -m pip install -r requirements.txt
     # ${PY3} -m pip list
     echo "...done"
else
    echo "No requirements.txt file found"
fi

echo -e "To activate venv in bash shell run:\n\tsource ./venv/bin/activate!"

