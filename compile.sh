#!/bin/bash
module load matlab/2017a

mkdir compiled

cat > build.m <<END
addpath(genpath('/N/u/brlife/git/jsonlab'))
addpath(genpath('/N/u/brlife/git/spm12'))
mcc -m -R -nodisplay -a /N/u/brlife/git/spm12/@gifti -d compiled eccentricityVolumeThickness
exit
END
matlab -nodisplay -nosplash -r build
