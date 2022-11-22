# thoughtworks-radar docker image

This docker image is build based on the https://github.com/thoughtworks/build-your-own-radar and is meant to run with
json/csv radar files which can be mounted into the directory /opt/build-your-own-radar/files.

## run

```bash
docker run -v /my/radar/files/:/opt/build-your-own-radar/files/ \
           -p 8080:8080 \
           ghcr.io/bakito/thoughtworks-radar:main
```
