#! /usr/bin/env python3
# -*- coding: utf-8 -*-

names={720:"HD", 1080:"FHD", 2160:"UHD/4K", 4320:"8K"}

print(f'\nFactor  Horisontal Vertical   Name')
print(f'-----------------------------------')
for N1 in [1.0, 1.5, 2.0, 2.5, 3.0, 4.0, 5.0, 6.0]:
	# N1 = 1 + N/10.0
	V = 720.0 * N1
	H = 1280.0 * N1

	if V in names.keys():
		name=names[V]
	else:
		name=""

	# print(N1, H, V)
	print(f'{N1}:  {H:>12.0f}  {V:>7.0f} {name:>6}')

