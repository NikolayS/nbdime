apt-get install python3-pip
pip install --upgrade virtualenv
virtualenv -p python3 nbdime
. nbdime/bin/activate
python3 setup.py sdist bdist_wheel
docker build -t quay.io/dotmesh/nbdime:$1 .
docker login -u $QUAY_USER -p $QUAY_PASSWORD $RELEASE_DOCKER_REGISTRY
docker push quay.io/dotmesh/nbdime:$1