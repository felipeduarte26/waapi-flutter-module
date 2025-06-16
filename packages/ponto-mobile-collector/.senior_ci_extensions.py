import sys
import os

sys.path.append("./senior-ci")

def before_build():
	os.system("echo  Instalando sqlite")
	os.system("apt-get update -qq && apt-get install -y -qq libsqlite3-dev")
	os.system("echo  Instalacao do sqlite finalizada")
