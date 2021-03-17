#!/usr/bin/env bash
cd /opt
rm -fr ss-tproxy
rm -fr shadowsocks-libev
rm -fr shadowsocksr-libev

apt update || exit 1
apt install --no-install-recommends git ipset psmisc build-essential pkg-config autoconf libtool cmake make gettext libpcre3-dev asciidoc xmlto libev-dev libc-ares-dev automake libmbedtls-dev libsodium-dev libssl-dev zlib1g-dev -y || exit 1

cd /opt
git clone https://github.com/aiocloud/ss-tproxy || exit 1
cd ss-tproxy
chmod +x ss-tproxy
cp -f ss-tproxy /usr/bin
cp -f ss-tproxy.service /etc/systemd/system
mkdir /etc/ss-tproxy
cp -f *.set /etc/ss-tproxy
cp -f ss-tproxy.conf /etc/ss-tproxy
cp -fr tcpnodes /etc/ss-tproxy
cp -fr udpnodes /etc/ss-tproxy
systemctl daemon-reload

cd /opt
git clone https://github.com/shadowsocks/shadowsocks-libev --depth 1 || exit 1
cd shadowsocks-libev
git submodule update --init
./autogen.sh || exit 1
./configure --disable-shared --enable-static || exit 1
make -j$(nproc) || exit 1
cd src
cp -f ss-redir /usr/bin/ss-redir

cd /opt
git clone https://github.com/shadowsocksrr/shadowsocksr-libev --depth 1 -b Akkariiin/develop || exit 1
cd shadowsocksr-libev
./autogen.sh || exit 1
./configure --disable-shared --enable-static || exit 1
make -j$(nproc) || exit 1
cd src
cp -f ss-redir /usr/bin/ssr-redir

cd /opt
rm -fr ss-tproxy
rm -fr shadowsocks-libev
rm -fr shadowsocksr-libev
exit 0