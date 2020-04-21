addpath(genpath('/N/u/brlife/git/jsonlab'))
addpath(genpath('/N/u/brlife/git/spm12'))
gifti('test.gii');
mcc -m -R -nodisplay -a /N/u/brlife/git/spm12/@gifti -d compiled eccentricityVolumeThickness
exit
