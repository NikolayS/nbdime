set -e

# this is ran in Dockerfile to setup and install nbdime
source env/bin/activate
pip install nodeenv
nodeenv -p
npm install -g lerna
(cd packages/labextension && npm install)
(cd packages/nbdime && npm install)
(cd packages/webapp && npm install)