#!/bin/bash
module load matlab/2017a

mkdir compiled

cat > build.m <<END
addpath(genpath('/N/u/brlife/git/jsonlab'))
addpath(genpath('/N/u/Desktop/app-thickness-volume-eccentricity/gifti-master'))
mcc -m -R -nodisplay -d compiled eccentricityVolumeThickness
exit
END
matlab -nodisplay -nosplash -r build
