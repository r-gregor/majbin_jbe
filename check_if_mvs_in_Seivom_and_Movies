#! /usr/bin/env bash
# filename: check_if_mvs_in_Seivom_and_Movies
#

my_seivom='/media/rgregor/E75F-1AEC/majmedia/Movies'
my_movies='/media/rgregor/E75F-1AEC/majmedia/Seivom'

 while read MV; do
	if [[ -d ${my_movies}/$MV ]]; then
		 echo "$MV in both dirs ..."
	fi;
done < <(ls -1 ${my_seivom})

