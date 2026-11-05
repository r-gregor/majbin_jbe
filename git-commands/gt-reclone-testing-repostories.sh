#! /usr/bin/env bash
# fname: gt-reclone-testing-repostories.sh
# descpt: reclone testing repository
# 20261104 v1
# 20261104 v2
# 20261104 v3
# last: 20261104
# ---


# === GLOBALS ===
testing_dir="${HOME}/majstaf/coding2/testing"
gthb_url="https://github.com/r-gregor"
gtlb_url="https://gitlab.com/r-gregor"
gthb_ssh_dest="git@github.com:r-gregor"
gtlb_ssh_dest="git@gitlab.com:r-gregor"

# === FUNCTIONS ===
git_reclone() {
	local dest
	local option
	if [ $# -ne 2 ]; then
		printf "[e] no options given -- 2 required\n\n"
		exit 1
	else
		destination="${1}"
		option="${2}"
	fi

	git_dest="${gthb_url}/${destination}_testing.git"
	printf -- "[i] recloning '%s' ...\n---\n" "${git_dest}"

	/usr/bin/git clone "${git_dest}"

	printf -- "---\n[i] cd into '%s' ...\n" "${destination}_testing"
	cd "${destination}_testing"
	printf "[i] updating remotes ...\n"
	/usr/bin/git remote add "gh${option}tst" "${gthb_ssh_dest}/${destination}_testing.git"
	/usr/bin/git remote add "gl${option}tst" "${gtlb_ssh_dest}/${destination}_testing.git"
	/usr/bin/git remote rm origin

	printf "[i] remotes:\n"
	while read -r LINE; do
		printf "\t%s\n" "${LINE}"
	done < <(/usr/bin/git remote -v)

	cd ..
	printf "\n"
}

usage() {
printf "[!] usage: gt-reclone-testing-repostories -[cgjnprz]
           -c ... c_testing
           -g ... go_testing
           -j ... java_testing
           -n ... ncurses_testing
           -p ... python_testing
           -r ... rust_testing
           -z ... zig_testing

           only one option at a time allowed!
\n"
}

# === MAIN ===
no_args="true"
while getopts 'cgjnprz' ARG; do
	case $ARG in
		c )
			C=1
		;;

		g )
			G=1
		;;

		j )
			J=1
		;;

		n )
			N=1
		;;

		p )
			P=1
		;;

		r )
			R=1
		;;

		z )
			Z=1
		;;

		: )
			usage
			exit 1
		;;

		*)
			printf "[e] no such selection\n\n"
			isage
			exit 1
		;;
	esac
	no_args="false"
done

[[ "${no_args}" == "true" ]] && { usage; exit 1; }

if ((C + G + J + N + P + R + Z  > 1)); then
	printf "[e] only one of options at a time should be used.\n"
	usage
	exit 1
fi

[[ $C == 1 ]] && git_reclone c c
[[ $G == 1 ]] && git_reclone go g
[[ $J == 1 ]] && git_reclone java j
[[ $N == 1 ]] && git_reclone ncurses n
[[ $P == 1 ]] && git_reclone python p
[[ $R == 1 ]] && git_reclone rust r
[[ $Z == 1 ]] && git_reclone zig z

printf "\n"

