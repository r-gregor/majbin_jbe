#! /usr/bin/env bash

# sendf2-mailx-yh
# 20171001
# _____________________________________________________________

# sourcing external config file:
source ~/majstaf/majbin/send_mail/send_config_yh.sh

if [ $# -ne 1 ]; then
	echo -e "\nThere should be one and only one argument: filename!"
	echo -e "Try again!\n"
	exit 1
fi

gAttf="$1"

echo -ne "\nChecking if file exists ... "
if [ ! -f "${gAttf}" ]; then
 	echo -e "\nThere is no ${gAttf}\n"
	exit 1
else
	echo "OK"
fi

echo -e "\nDo you really want to send home file:"
echo -e "[ ${gAttf} ]\n"
read -p "Press any key to confirm, or ctlr+c to quit _"

gFjl="${gAttf}"

# echo "BODY: Sending a file: ${gFjl} from d ..." | mailx -v -r ${gFROM} -s "Sending a file: ${gFjl} from d ..." -S smtp="${gSrv}" -S smtp-use-starttls -S smtp-auth=login -S smtp-auth-user=${gUnm} -S smtp-auth-password=${gPswd} -S ssl-verify=ignore -a "${gFjl}" ${gTO}
echo "BODY: Sending a file: ${gFjl} from d ..." | mailx -r ${gFROM} -s "Sending a file: ${gFjl} from d ..." --set=smtp="${gSrv}" --set=smtp-use-starttls --set=smtp-auth=login --set=smtp-auth-user=${gUnm} --set=smtp-auth-password=${gPswd} --set=ssl-verify=ignore -a "${gFjl}" ${gTO}

