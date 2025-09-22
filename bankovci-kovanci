#! /usr/bin/env python3
# -*- coding: utf-8 -*-

import sys

usage="Usage:\n" + sys.argv[0] + " <amounts to calculate>"


if len(sys.argv) < 2:
    print(usage)
    exit(1)
    
eurs = []

for i in range(1, len(sys.argv)):
    # print(sys.argv[i])
    eurs.append(float(sys.argv[i].replace(",", ".")))


def bankovci_kovanci(eur):
    
    eur2 = round(eur, 2)
    
    print("===================================")
    print("*** Znesek: {} EUR ***".format(eur2))

    
    BC = {
    "Bankovec 100 EUR" : 0,
    "Bankovec 50 EUR" : 0,
    "Bankovec 20 EUR" : 0,
    "Bankovec 10 EUR" : 0,
    "Bankovec 5 EUR" : 0,
    "Kovanec 2 EUR" : 0,
    "Kovanec 1 EUR" : 0,
    "Kovanec 50 centov" : 0,
    "Kovanec 20 centov" : 0,
    "Kovanec 10 centov" : 0,
    "Kovanec 5 centov" : 0,
    "Kovanec 2 centa" : 0,
    "Kovanec 1 cent" : 0}
    
    rest1 = 0
    BC["Bankovec 100 EUR"] += int(eur2 / 100)
    rest1 += (eur % 100)
    
    rest2 = 0
    BC["Bankovec 50 EUR"] += int(rest1 / 50)
    rest2 += (rest1 % 50)

    rest3 = 0
    BC["Bankovec 20 EUR"] += int(rest2 / 20)
    rest3 += (rest2 % 20)
    
    rest4 = 0
    BC["Bankovec 10 EUR"] += int(rest3 / 10)
    rest4 += (rest3 % 10)
    
    rest5 = 0
    BC["Bankovec 5 EUR"] += int(rest4 / 5)
    rest5 += (rest4 % 5)
    
    rest6 = 0 
    BC["Kovanec 2 EUR"] += int(rest5 / 2)
    rest6 += (rest5 % 2)

    rest7 = 0 
    BC["Kovanec 1 EUR"] += int(rest6 / 1)
    rest7 += (rest6 % 1)
   
    rest7 = round(rest7 * 100, 0)
        
    rest8 = 0 
    BC["Kovanec 50 centov"] += int(rest7 / 50)
    rest8 += (rest7 % 50)
  
    rest9 = 0 
    BC["Kovanec 20 centov"] += int(rest8 / 20)
    rest9 += (rest8 % 20)
    
    rest10 = 0 
    BC["Kovanec 10 centov"] += int(rest9 / 10)
    rest10 += (rest9 % 10)
   
    rest11 = 0   
    BC["Kovanec 5 centov"] += int(rest10  / 5)
    rest11 += (rest10 % 5)
   
    rest12 = 0
    BC["Kovanec 2 centa"] += int(rest11 / 2)
    rest12 += (rest11 % 2)
   
    rest13 = 0
    BC["Kovanec 1 cent"] += int(rest12 / 1)
    rest13 += (rest12 % 1)
    
    for k, v in BC.items():
        if v != 0:
            print("{} = {}x".format(k, v))


for znesek in eurs:
    bankovci_kovanci(znesek)
