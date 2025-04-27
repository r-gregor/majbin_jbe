import os
# define email variables:
# Header info:
gFrom = os.getenv("FROM_SCRTS_GG")
gTo = ['gregor.redelonghi@energetika.si']
# gTo = ['gredelonghi@protonmail.com']
gSmtp = os.getenv("SMTP_SCRTS_GG")
gPort = os.getenv("PORT_SCRTS_GG")

# Credentials:
gUnm=os.getenv("UNM_SCRTS_GG")
gPsswd=os.getenv("PSSWD_SCRTS_GG")
