import os
# define email variables:
# Header info:
gFrom = os.getenv("FROM_SCRTS_YH")
gTo = ['gregor.redelonghi@energetika.si']
# gTo = ['gredelonghi@protonmail.com']
gSmtp = os.getenv("SMTP_SCRTS_YH")
gPort = os.getenv("PORT_SCRTS_YH")

# Credentials:
gUnm=os.getenv("UNM_SCRTS_YH")
gPsswd=os.getenv("PSSWD_SCRTS_YH")
