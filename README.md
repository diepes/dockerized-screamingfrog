# Dockerized Screaming Frog SEO Spider

## Run Screaming Frog cli in docker container, with vnc x11 gui

- Based on Ubuntu 22.04 container
- Launches the X virtual frame buffer (Xvfb) which emulates an X11 display (For Screamingfrog's embeded browser working)

## Building

- Copy your licence.txt to current directory
- run `docker build -t screamingfrog .`

## Usage (docker run)

```sh
# Run Headless
mkdir /tmp/crawler;
docker run --rm \
  -p 5900:5900 --mount \
  source=/tmp/crawler,target=/mnt/crawler,type=bind \
  screamingfrog \
  --crawl https://vigor.nz \
  --save-crawl --timestamped-output \
  --output-folder /mnt/crawler \
  --headless

 #Run x11 vnc Gui
 docker run --rm \
  -p 5900:5900 --mount \
  source=/tmp/crawler,target=/mnt/crawler,type=bind \
  screamingfrog -consolelog -debug
```

### Connect with vnc to container

- On Mac - "Royal TSX" vnc://localhost:590
