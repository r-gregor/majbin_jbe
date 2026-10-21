#! /usr/bin/env bash

# IZVID_smpl_(MAIL)_(1)__26092024_Avtorizirana_verzija.PDF
# FNAME="IZVID_smpl_(MAIL)_(1)__26092024_Avtorizirana_verzija"
# cd /home/rgregor/Documents/_ZA-TADEJO/Tadeja_Ortoped_izvid_20240926

FNAME="Poziv k predložitvi manjkajoče dokumentacije"
cd /home/rgregor/Documents/VALVASORJEVA-5/ZAMAKANJE_20250708/
pdftk "${FNAME}.pdf" input_pw PROMPT output "${FNAME}.nz.pdf"


