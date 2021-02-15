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
export DJANGO_SETTINGS_MODULE=escriptorium.local_settings
echo "CELERY_TASK_ALWAYS_EAGER = True" | cat >>  app/escriptorium/local_settings.py

cd app
python manage.py migrate
python manage.py createsuperuser


# the UI -- the horror of node.js 
nvm install node
cd ../front
npm install

