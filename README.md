[![Abcdspec-compliant](https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg)](https://github.com/brain-life/abcd-spec)
[![Run on Brainlife.io](https://img.shields.io/badge/Brainlife-brainlife.app.243-blue.svg)](https://doi.org/10.25663/brainlife.app.243)

# Bin cortical volume and thickness by eccentricity 

This app will bin values of cortical thickness and volume from the Freesurfer pial surface by pRF eccentricity. This app takes as input a Freesurfer segmentation and a pRF mapping and outputs both a .mat structure and graph pngs.

Specifically, this app will bin cortical vertices by multiple pRF eccentricities. Currently, these bins include 0-1 degrees, 0-2 degrees, 0-3 degrees, 0-4 degrees, 0-5 degrees, and from 5 degrees onward (periphery). The data in the .mat structure includes all the vertices within each bin, the max, mean, and standard deviation of either the cortical thickness or cortical volume. 

### Authors 

- Brad Caron (bacaron@iu.edu)
- Jasleen Jolly (jasleen.jolly@eye.ox.ac.uk) 

### Contributors 

- Soichi Hayashi (hayashis@iu.edu) 

### Funding 

[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-1636893](https://img.shields.io/badge/NSF_BCS-1636893-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-ACI-1916518](https://img.shields.io/badge/NSF_ACI-1916518-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1916518)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://grantome.com/grant/NIH/R01-EB029272-01)

### Citations 

Please cite the following articles when publishing papers that used data, code or other resources created by the brainlife.io community. 

 

## Running the App 

### On Brainlife.io 

You can submit this App online at [https://doi.org/10.25663/brainlife.app.243](https://doi.org/10.25663/brainlife.app.243) via the 'Execute' tab. 

### Running Locally (on your machine) 

1. git clone this repo 

2. Inside the cloned directory, create `config.json` with something like the following content with paths to your input files. 

```json 
{
   "freesurfer":    "testdata/freesurfer/output',
   "prf":    "testdata/prf/"
} 
``` 

### Sample Datasets 

You can download sample datasets from Brainlife using [Brainlife CLI](https://github.com/brain-life/cli). 

```
npm install -g brainlife 
bl login 
mkdir input 
bl dataset download 
``` 

3. Launch the App by executing 'main' 

```bash 
./main 
``` 

## Output 

The main output of this App is is a .mat structure containing the binned thickness and volume data. PNG images of the distribution of values for each bin will also be included. 

#### Product.json 

The secondary output of this app is `product.json`. This file allows web interfaces, DB and API calls on the results of the processing. 

### Dependencies 

This App requires the following libraries when run locally. 

- Matlab: https://www.mathworks.com/help/install/install-products.html
- Freesurfer: https://surfer.nmr.mgh.harvard.edu/fswiki/DownloadAndInstall
- Singularity: https://singularity.lbl.gov/quickstart
