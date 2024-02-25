#! /bin/bash

if [ $# -ne 2 ]; then
    echo "Must supply existing *.srt  and [movie] filename"
    exit 1
else
    old_srt_fname=$1
	old_movie_fname=$2
fi

if [ ! -f $fname ]; then
    echo "Must supply existing *.srt  and [movie] filename"
    exit 1
fi


fbase=${old_movie_fname%.*}
newext="srt"

newfname="${fbase}.${newext}"

echo "Copying $old_srt_fname to $newfname ..."
cp -v $old_srt_fname $newfname

