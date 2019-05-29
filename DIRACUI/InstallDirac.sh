#!/bin/bash
mkdir dirac_ui
cd dirac_ui
wget -np -O dirac-install https://raw.githubusercontent.com/DIRACGrid/DIRAC/integration/Core/scripts/dirac-install.py
# add --no-check-certificate to wget if needed
chmod u+x dirac-install
./dirac-install -r v6r20p26 -i 27 -g v14r1 -e COMDIRAC
.  bashrc
dirac-proxy-init -x # (needs user cert password)
dirac-configure -F -S GridPP -C dips://dirac01.grid.hep.ph.ic.ac.uk:9135/Configuration/Server -I
dirac-proxy-init -g skatelescope.eu_user -M # (e.g. dirac-proxy-init -g comet.j-parc.jp_user -M)
