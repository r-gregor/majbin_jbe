import os
# define email variables:
# Header info:
gFrom = os.getenv("FROM_SCRTS")
gTo = ['gregor.redelonghi@energetika.si']
gSmtp = os.getenv("SMTP_SCRTS")
gPort = os.getenv("PORT_SCRTS")

# Credentials:
gUnm=os.getenv("UNM_SCRTS")
gPsswd=os.getenv("PSSWD_SCRTS")
