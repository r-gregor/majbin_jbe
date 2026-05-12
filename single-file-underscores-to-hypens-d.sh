#! /bin/bash
### script that replaces spaces with hypens in filenames ...

if [ $# -ne 1 ]; then
    echo -e "Usage: $0 [single-filename-with-underscors]\n"
    exit
fi

inputf=$1

source_path=$(realpath $(dirname ${inputf}))
name=$(basename ${inputf})

renamed=$(echo ${name} | tr '_' '-')
# echo "renamed: ${renamed}"

echo "Renaming ${name} to ${renamed}"
# echo "mv -vvv ${source_path}/${name} ${source_path}/${renamed}"
mv -vvv ${source_path}/${name} ${source_path}/${renamed}
