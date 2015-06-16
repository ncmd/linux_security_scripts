cd
git clone https://github.com/yaronn/blessed-contrib.git
mkdir /etc/blessed-contrib
cd blessed-contrib
npm install
cp -r blessed-contrib/* /etc/blessed-contrib
apt-get install curl -y
curl -sL https://deb.nodesource.com/setup | bash -
apt-get install nodejs
yum install node npm -y
pacman -S nodejs -y

echo "node /etc/blessed-contrib/examples/dashboard.js" >> ~/.bash_profile

node /etc/blessed-contrib/examples/dashboard.js

