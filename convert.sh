#!/bin/bash

prf=`jq -r '.prf' config.json`
freesurfer=`jq -r '.freesurfer' config.json`
hemi="lh rh"

# convert surfaces to gifti
for HEMI in $hemi
do
	mris_convert $freesurfer/surf/${HEMI}.pial ./${HEMI}.pial.surf.gii
	mris_convert -c $freesurfer/surf/${HEMI}.volume ./${HEMI}.pial.surf.gii ./${HEMI}.volume.surf.gii
	mris_convert -c $freesurfer/surf/${HEMI}.thickness ./${HEMI}.pial.surf.gii ./${HEMI}.thickness.surf.gii
	mris_convert -c $prf/${HEMI}.benson14_eccen ./${HEMI}.pial.surf.gii ./${HEMI}.benson14_eccen.surf.gii
done
