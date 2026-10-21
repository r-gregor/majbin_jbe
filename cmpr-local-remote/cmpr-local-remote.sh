#! /usr/bin/env bash
# v4
# cmpr_local_remote.sh
# 20230907 (d)

local_base="${HOME}/majstaf/coding"
remote_base="${HOME}/Dropbox/ODPRTO/MCDN_en/coding"

if [ $# -ne 1 ]; then
echo -e "Usage:\n\
\t $0 -[l]

\t\t-[l]    ... -c (C), -j (JAVA), -p (PYTHON), -r (RUST)\n"
	exit
fi

L=$1

if [ "$L" = "-c" ]; then
	lang_test="C_Cpp_*/c_*_testing"
	ll="c"
elif [ "$L" = "-g" ]; then
	lang_test="GO_*/GO_*_testing"
	ll="g"
elif [ "$L" = "-j" ]; then
	lang_test="JAVA_*/JAVA_*_testing"
	ll="j"
elif [ "$L" = "-p" ]; then
	lang_test="PYTHON_*/PYTHON_*_testing"
	ll="p"
elif [ "$L" = "-r" ]; then
	lang_test="RUST_*/rust_*_testing"
	ll="r"
else
	echo -e "Something went wrong!\n"
	exit
fi

LOCAL="${local_base}/${lang_test}"
REMOTE="${remote_base}/${lang_test}"

local_to_remote() {
	for LF in $(ls ${LOCAL} | grep ${ll}[dn]_); do
		single=0
		for RF in $(ls ${REMOTE} | grep ${ll}[dn]_); do
			if [ $(echo $LF | cut -b 8-) = $(echo $RF | cut -b 8-) ]; then
				echo "$LF"
				echo "$RF"
				echo -e "---"
				single=1
			fi
		done
	done
}

local_singles() {
	for LF in $(ls ${LOCAL} | grep ${ll}[dn]_); do
		single=0
		for RF in $(ls ${REMOTE} | grep ${ll}[dn]_); do
			if [ $(echo $LF | cut -b 8-) = $(echo $RF | cut -b 8-) ]; then
				single=1
			fi
		done
		if [ $single -eq 0 ]; then
			echo "$LF -- SINGLE"
		fi
	done
	echo "---"
}
remote_singles() {
	for RF in $(ls ${REMOTE} | grep ${ll}[dn]_); do
		single=0
		for LF in $(ls ${LOCAL} | grep ${ll}[dn]_); do
			if [ $(echo $RF | cut -b 8-) = $(echo $LF | cut -b 8-) ]; then
				single=1
			fi
		done
		if [ $single -eq 0 ]; then
			echo "$RF -- SINGLE"
		fi
	done
	echo "---"
}

local_to_remote
local_singles
remote_singles

