# ss-tproxy
[![](https://img.shields.io/badge/Telegram-Group-blue)](https://t.me/aioCloud)
[![](https://img.shields.io/badge/Telegram-Channel-green)](https://t.me/aioCloud_channel)

我个人用的透明代理脚本

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
cp -fr tcpnodes /etc/ss-tproxy
cp -fr udpnodes /etc/ss-tproxy

systemctl daemon-reload

cd ~
rm -fr ss-tproxy

cd /opt
git clone https://github.com/shadowsocks/shadowsocks-libev --recurse --depth 1 || exit 1
cd shadowsocks-libev
apt install --no-install-recommends build-essential pkg-config autoconf libtool cmake make gettext libpcre3-dev asciidoc xmlto libev-dev libc-ares-dev automake libmbedtls-dev libsodium-dev libssl-dev -y
./autogen.sh || exit 1
./configure --disable-shared --enable-static || exit 1
make -j$(($(nproc) + 1)) || exit 1
cd src
cp -f ss-redir /usr/bin/ss-redir

cd /opt
git clone https://github.com/shadowsocksrr/shadowsocksr-libev --recurse --depth 1 -b Akkariiin/develop || exit 1
cd shadowsocksr-libev
./autogen.sh || exit 1
./configure --disable-shared --enable-static || exit 1
make -j$(($(nproc) + 1)) || exit 1
cd src
cp -f ss-redir /usr/bin/ssr-redir

cd /opt
rm -fr shadowsocks-libev
rm -fr shadowsocksr-libev

cd ~
# cd /etc/ss-tproxy
# nano /etc/ss-tproxy/ss-tproxy.conf
# cd /etc/ss-tproxy/tcpnodes
# nano ?
# cd /etc/ss-tproxy/udpnodes
# nano ?
# systemctl enable --now ss-tproxy
```
