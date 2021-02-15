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
EOT

# node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

exec $SHELL




