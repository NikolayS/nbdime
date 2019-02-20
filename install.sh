set -ex

source env/bin/activate
pip install nodeenv
nodeenv -p
npm install -g lerna
(cd packages/labextension && npm install)
(cd packages/nbdime && npm install)
(cd packages/webapp && npm install)
pip install -e .