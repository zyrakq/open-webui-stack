# README

## Deployment

```bash
docker-compose up --build -d
```

## Opening access to containers with SSL from Let's Encrypt

In order for the container to be accessible from the outside, you need to:
- add the `cert-network` network
- fill in `VIRTUAL_PORT` - the port of the container to which you want to add access from the outside
- fill in `VIRTUAL_HOST` - the domain on which the container will be accessible
- fill in `LETSENCRYPT_HOST` - the domain to which the certificate is issued
- fill in `LETSENCRYPT_EMAIL` - the email for requesting the certificate

Example:

```yml
  kibana:
    environment:
      VIRTUAL_PORT: 8080
      VIRTUAL_HOST: ${VIRTUAL_HOST}
      LETSENCRYPT_HOST: ${LETSENCRYPT_HOST}
      LETSENCRYPT_EMAIL: ${LETSENCRYPT_EMAIL}
    networks:
      - cert-network

networks:
  cert-network:
    name: cert-network
    external: true
```