#! /usr/bin/env bash
# coding_diffs_d.sh (coding_diffs_v5.sh)
# 20230907 (en)
# 20230907 / 02 (d)
# ---


local_base="${HOME}/majstaf/coding"
remote_base="${HOME}/Dropbox/ODPRTO/MCDN_en/coding"


if [ $# -ne 2 ]; then
echo -e "Usage:\n\
\t $0 -[l] [num]

\t\t-[l]    ... -c (C), -j (JAVA), -p (PYTHON), -r (RUST)\n\
\t\t [num]  ... cd_108_* = cd_num_; num=108\n"
	exit
fi

L=$1
N=$2

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


local="${local_base}/${lang_test}"
remote="${remote_base}/${lang_test}"

export CODING_LOCAL="$(ls -1d ${local}/${ll}*_${N}_*)"
export CODING_REMOTE="$(ls -1d ${remote}/${ll}*_${N}_*)"

echo ${CODING_LOCAL} > ~/.tmp/CODING_LOCAL
echo ${CODING_REMOTE} > ~/.tmp/CODING_REMOTE

echo -e "\
LOCAL:\t${CODING_LOCAL}\n\
REMOTE:\t${CODING_REMOTE}"

echo "---"
diff -q ${CODING_LOCAL} ${CODING_REMOTE} | sed -e 's/\/home\/.*majstaf.*\//LOCAL  :: /g' -e 's/\/home\/.*Dropbox.*\//REMOTE :: /g' -e 's/Files LOCAL/        Files/g' # | grep -vi common

