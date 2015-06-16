wget http://download.redis.io/redis-stable.tar.gz
tar -xzf redis-stable.tar.gz
cd redis-stable/
apt-get install tcl gcc jemalloc -y
make distclean
make install
make test

