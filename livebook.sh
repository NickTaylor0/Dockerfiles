/app/tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
/app/tailscale up --auth-key=${TAILSCALE_AUTHKEY} --hostname=livebook
echo Tailscale started
ALL_PROXY=socks5://localhost:1055/ /app/bin/server
