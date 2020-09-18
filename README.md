# ss-tproxy
```bash
cd ~
git clone https://github.com/aiocloud/ss-tproxy || exit 1
cd ss-tproxy

chmod +x ss-tproxy
cp -f ss-tproxy /usr/bin
cp -f ss-tproxy.service /etc/systemd/system

mkdir /etc/ss-tproxy
cp -f *.set /etc/ss-tproxy
cp -f ss-tproxy.conf /etc/ss-tproxy
mkdir /etc/ss-tproxy/nodes
cp -f nodes/IPLC-SZHK-01 /etc/ss-tproxy/nodes

systemctl daemon-reload

cd ~
rm -fr ss-tproxy

cd /opt
git clone https://github.com/shadowsocks/shadowsocks-libev || exit 1
cd shadowsocks-libev
git submodule update --init || exit 1
apt install --no-install-recommends build-essential pkg-config autoconf libtool cmake make gettext libpcre3-dev asciidoc xmlto libev-dev libc-ares-dev automake libmbedtls-dev libsodium-dev libssl-dev -y
cmake . || exit 1
make -j4 || exit 1
cd bin
cp -f ss-redir /usr/bin/ss-redir

cd /opt
git clone https://github.com/shadowsocksrr/shadowsocksr-libev -b Akkariiin/develop || exit 1
cd shadowsocksr-libev
./autogen.sh || exit 1
./configure || exit 1
make -j4 || exit 1
cd src
cp -f ss-redir /usr/bin/ssr-redir
```
