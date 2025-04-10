#! /usr/bin/env bash
for FFF in lynxd lynx-multi-dump-fromlist-en multi-dump-list.dat lynxdump-USERAGENT-webpage-to-file; do
	wget https://raw.githubusercontent.com/r-gregor/majbin_en/refs/heads/main/lynxdump/$FFF
done

