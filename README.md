<h1 align="center">Bin cortical volume and thickness by eccentricity</h1>

<p align="center">
  Cortical thickness and volume summaries, grouped into pRF eccentricity bins, from a FreeSurfer output and a surface-mapped pRF dataset.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.243"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.243-blue.svg" alt="Run on brainlife.io"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-lightgrey.svg" alt="MIT license"></a>
</p>

## At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Bins FreeSurfer cortical thickness and volume by pRF eccentricity (0-1 to 0-5 degrees and periphery) and outputs a .mat summary and plots.**

Converts the FreeSurfer pial surface, thickness, volume and the pRF eccentricity map to GIFTI, then groups vertices into eccentricity bins (0-1, 0-2, 0-3, 0-4, 0-5 degrees and beyond 5 degrees) and reports the vertices, maximum, mean and standard deviation of thickness and volume per bin, with PNG graphs. Use it to relate visual-cortex morphometry to retinotopic eccentricity. The pRF data must be on the same subject's FreeSurfer surfaces.

| | |
|---|---|
| **Inputs** | `neuro/freesurfer` · `neuro/prf` |
| **Outputs** | `raw` |
| **Container** | `brainlife/freesurfer:6.0.0` |
| **Resources** | 1 CPUs · 0.5 h walltime |
| **Requires** | `FREESURFER_LICENSE` |
| **Run it** | [doi.org/10.25663/brainlife.app.243](https://doi.org/10.25663/brainlife.app.243) |

#### Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `freesurfer` | `neuro/freesurfer` | yes | The path to the top directory containing the output from Freesurfer |
| `prf` | `neuro/prf` | yes | The path to the directory containing the surface-mapped prf files from the prf datatype |

#### Outputs

| Output | Datatype | Description |
|---|---|---|
| `raw` | `raw` | This contains the data and figures outputted from the app |

<!-- brainlife-app:end -->

## Running the App

### On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.243](https://doi.org/10.25663/brainlife.app.243), choose a FreeSurfer output (`neuro/freesurfer`) and a pRF dataset (`neuro/prf`) mapped onto the same subject's FreeSurfer surfaces, and press **Execute**. The App writes a `raw` dataset tagged `volThickEcc` to your project. Use it to relate visual-cortex morphometry to retinotopic eccentricity.

### How it works

1. The pial surface, cortical thickness, cortical volume and the pRF eccentricity map (`lh/rh.eccentricity` in the pRF dataset) of each hemisphere are converted to GIFTI with FreeSurfer `mris_convert`.
2. Cortical vertices are binned by pRF eccentricity: 0–1, 0–2, 0–3, 0–4 and 0–5 degrees (foveal bins, cumulative), and beyond 5 degrees (periphery).
3. For each bin and hemisphere, the App keeps the vertices with non-zero values and reports the maximum, mean and standard deviation of thickness and volume (compiled MATLAB).

### Locally

You need [Singularity/Apptainer](https://apptainer.org/), [`jq`](https://jqlang.github.io/jq/) and a [FreeSurfer license](https://surfer.nmr.mgh.harvard.edu/registration.html). The App uses the `brainlife/freesurfer:6.0.0` and `brainlife/mcr:r2019a` containers.

1. Clone this repository and check out the registered version (`git checkout v1.0.0`).
2. Create `config.json` with the paths to your inputs (see `config.json_sample`):

   ```json
   {
       "freesurfer": "testdata/freesurfer/output",
       "prf": "testdata/prf/"
   }
   ```

3. Export your license and run the App:

   ```bash
   export FREESURFER_LICENSE="$(cat ~/freesurfer/license.txt)"
   ./main
   ```

## Outputs

```text
output.mat            per-hemisphere structures with the vertices, max, mean and SD of thickness and volume in each bin
foveal_v_periph.png   distribution of values in the foveal and peripheral bins
product.json          bin means, shown on brainlife.io
lh/rh.*.surf.gii      intermediate GIFTI surfaces and maps
```

## Citing

> [!TIP]
> If you use this App in your work, please cite the App, the software it builds on and brainlife.io (below). GitHub's **Cite this repository** button gives the App citation in APA and BibTeX.

- Bin cortical volume and thickness by eccentricity. brainlife.io App. [doi:10.25663/brainlife.app.243](https://doi.org/10.25663/brainlife.app.243)
- FreeSurfer methods citation: https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferMethodsCitation
- Fischl. FreeSurfer. *NeuroImage* 62:774-781 (2012). [doi:10.1016/j.neuroimage.2012.01.021](https://doi.org/10.1016/j.neuroimage.2012.01.021)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. *Scientific Data* 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## Authors

- Brad Caron
- Jasleen Jolly

**Contributors:** Soichi Hayashi

## Funding

[![Wellcome-226486/Z/22/Z](https://img.shields.io/badge/Wellcome-226486%2FZ%2F22%2FZ-purple.svg)](https://wellcome.org/)
[![NIH-NINDS-U24NS140384](https://img.shields.io/badge/NIH_NINDS-U24NS140384-green.svg)](https://reporter.nih.gov/project-details/11261037)
[![NIH-NINDS-UM1NS132207](https://img.shields.io/badge/NIH_NINDS-UM1NS132207-green.svg)](https://reporter.nih.gov/project-details/11411328)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://reporter.nih.gov/project-details/10262925)
[![NIH-NIBIB-R01EB030896](https://img.shields.io/badge/NIH_NIBIB-R01EB030896-green.svg)](https://reporter.nih.gov/project-details/10428625)
[![NIH-NIMH-R01MH126699](https://img.shields.io/badge/NIH_NIMH-R01MH126699-green.svg)](https://reporter.nih.gov/project-details/10460628)
[![NIH-NIDCD-R01DC020088](https://img.shields.io/badge/NIH_NIDCD-R01DC020088-green.svg)](https://reporter.nih.gov/project-details/11140284)
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-2203524](https://img.shields.io/badge/NSF_BCS-2203524-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2203524)
[![NSF-IIS-1636893](https://img.shields.io/badge/NSF_IIS-1636893-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-OAC-2148729](https://img.shields.io/badge/NSF_OAC-2148729-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148729)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-IIS-2148700](https://img.shields.io/badge/NSF_IIS-2148700-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148700)
[![NSF-OAC-1916518](https://img.shields.io/badge/NSF_OAC-1916518-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1916518)

<sub>brainlife.io is publicly funded, and acknowledging that support helps keep it running. This App was developed with support from Wellcome, the U.S. National Institutes of Health (including the BRAIN Initiative BRAIN CONNECTS program: The Axonal Projectome EXchange, U24NS140384, and the Center for Mesoscale Connectomics, UM1NS132207) and the U.S. National Science Foundation.</sub>

## License

MIT (see the [`LICENSE`](https://github.com/brainlife/app-thickness-volume-eccentricity/blob/v1.0.0/LICENSE) file on the `v1.0.0` branch). FreeSurfer is distributed under its own [license](https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferSoftwareLicense).
