sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install vim htop git curl
sudo apt-get -y install postgresql postgresql-contrib
sudo apt-get -y install redis-server
sudo apt-get -y install netcat-traditional jpegoptim pngcrush
sudo apt-get -y install gfortran libopenblas-dev liblapack-dev
sudo apt-get -y install libvips
sudo apt-get -y install npm

# python
sudo apt-get -y install --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
curl https://pyenv.run | bash

cat <<'EOT' >> ~/.bashrc 
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export DJANGO_SETTINGS_MODULE=escriptorium.local_settings
EOT

# node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

eval "$(awk '/pyenv/ {o=1}; o==1 {print}' ~/.bashrc)"

pyenv install 3.7.9
 
# download the escriptorium code and install dependencies
git clone https://gitlab.inria.fr/scripta/escriptorium.git
cd escriptorium
pyenv virtualenv 3.7.9 ocr
pyenv local ocr
pip install -U pip
pip install numpy
pip install -r app/requirements.txt

# set up the database
sudo service postgresql start
sudo -u postgres createuser -s $USER
createdb escriptorium

# start redis
sudo service redis-server start

# set up the webapp
pip install django-debug-toolbar django-extensions
cp app/escriptorium/local_settings.py.example app/escriptorium/local_settings.py
sed -i "s/provideyourusernamehere/$USER/; s/# 'USER'/'USER'/"  app/escriptorium/local_settings.py
echo "CELERY_TASK_ALWAYS_EAGER = True" | cat >>  app/escriptorium/local_settings.py

# the UI -- the horror of node.js 
nvm install node
cd front
npm install
npm run production

cd ../app
python manage.py migrate
python manage.py createsuperuser

echo "All done.  To run the server, issue:"
echo "python manage.py runserver 0.0.0.0:8000 --settings=escriptorium.local_settings"
