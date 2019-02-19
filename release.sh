sudo apt-get -y install python3-pip
sudo apt-get -y install curl && sudo curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && sudo apt-get -y install build-essential nodejs
pip install --upgrade virtualenv
virtualenv -p python3 nbdime
. nbdime/bin/activate
python3 setup.py sdist bdist_wheel
docker build -t quay.io/dotmesh/nbdime:$1 .
docker login -u $QUAY_USER -p $QUAY_PASSWORD $RELEASE_DOCKER_REGISTRY
docker push quay.io/dotmesh/nbdime:$1