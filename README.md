# openstartracker
A fast, robust, open-source startracker based on a new class of Bayesian startracker algorithms. Modified by SSI.

Features:

* Fast lost-in-space identification
* Image-to-image matching
* Collect and store size, shape and color information of unknown objects
* Track unknown objects between images
* Programmable python frontend / reusable C++ backend (BEAST-2) with no external dependencies 
* Uses astrometry.net for calibration (check if your camera is good enough by uploading your star images to nova.astrometry.net)
* Supports python 2 and 3 (see bottom)

### Basic setup:

#### Getting started using Docker

Install [Docker](https://docs.docker.com/install/) first, if you don't have it on your machine. Watch [this video](https://www.youtube.com/watch?v=6aBsjT5HoGY) on Docker to familiarize yourself with what it does first (most important is 0:00-15:00). We have to use Docker because this code necessitates a certain configuration; it probably won't immediately work on your machine.

Clone this repo and go to its root directory

```
git clone https://github.com/stanford-ssi/openstartracker.git && cd openstartracker
```

### With pre-written script (recommended)

Run the `setup.sh` script specifically as below

```
source setup.sh
```

This script will not only set up our Docker image, but will also create a succinct alias command `$ dstart` that we can use to enter the Docker container (rather than typing the excessively long command).

Doing this is recommended because changes in the native file system will transfer over to the Docker container with less hassle.

Now, to run any file,

```
dstart
cd tests
./unit_test.sh -crei science_cam_may8_0.05sec_gain40
```

An important thing to keep in mind is to *edit on your local machine* and *run in the Docker container with* `dstart`.

### Manually

Run the Dockerfile to build your image

```
docker build -t startracker1 .
```

Now you can run the Docker image, marking `-it` for interactive

```
docker run -it --name startracker1 --mount source:[openstartracker directory path on your machine],target=/
```
#### Additional packages needed for calibration and unit testing

Download fits files corresponding to your camera fov size (see astrometry.net for details)

~~~~
cd /usr/share/astrometry

sudo wget http://data.astrometry.net/4100/index-4112.fits
sudo wget http://data.astrometry.net/4100/index-4113.fits
sudo wget http://data.astrometry.net/4100/index-4114.fits
sudo wget http://data.astrometry.net/4100/index-4115.fits
sudo wget http://data.astrometry.net/4100/index-4116.fits
sudo wget http://data.astrometry.net/4100/index-4117.fits
sudo wget http://data.astrometry.net/4100/index-4118.fits
sudo wget http://data.astrometry.net/4100/index-4119.fits
~~~~

Now run the unit test

~~~~
dstart
cd tests
./unit_test.sh -crei science_cam_may8_0.05sec_gain40
~~~~

##### To calibrate a new camera:

~~~~
cd /home/openstartracker/
mkdir yourcamera
cd yourcamera && mkdir samples calibration_data
~~~~

1. Add 3-10 star images of different parts of the sky taken with your camera to `yourcamera/samples`.

2. Edit `APERTURE` and `EXPOSURE_TIME` in `calibrate.py` (you want to take images with the lowest exposure time that consistently solves)

3. Run `./unit_test.sh -crei yourcamera` to recalibrate and test.

The ESA test should have a score of >70. If it's worse than this, play around with exposure time (50ms is a good starting point).

##### Reference frames used:

For RA,DEC,Ori, openstartracker uses the same convention as astrometry.net, where RA and DEC are in the same frame as the star positions specified in the hipparcos catalogue (updated to the current year). Orientation is degrees east of north (ie orientation 0 means that up and down aligns with north-south)

