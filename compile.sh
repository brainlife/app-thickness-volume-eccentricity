#!/bin/bash
module load matlab/2019a

mkdir compiled

cat > build.m <<END
addpath(genpath('/N/u/brlife/git/jsonlab'))
addpath(genpath('/N/u/brlife/git/spm12'))
mcc -m -R -nodisplay -I /N/u/brlife/git/spm12/@gifti/private -d compiled eccentricityVolumeThickness
exit
END
matlab -nodisplay -nosplash -r build
