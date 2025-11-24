FROM ghcr.io/livebook-dev/livebook:latest-cuda12

# Copy binary to production image.
COPY livebook.sh /app/start.sh

# Copy Tailscale binaries from the tailscale image on Docker Hub.
COPY --from=docker.io/tailscale/tailscale:stable /usr/local/bin/tailscaled /app/tailscaled
COPY --from=docker.io/tailscale/tailscale:stable /usr/local/bin/tailscale /app/tailscale
RUN mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale

ENV LIVEBOOK_IDENTITY_PROVIDER tailscale:/var/run/tailscale/tailscaled.sock
ENV HTTP_PROXY http://localhost:1055/
ENV HTTPS_PROXY http://localhost:1055/
ENV ALL_PROXY socks5://localhost:1055/

CMD ["/app/start.sh"]
