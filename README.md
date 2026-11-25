<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

**Bins FreeSurfer cortical thickness and volume by pRF eccentricity (0-1 to 0-5 degrees and periphery) and outputs a .mat summary and plots.**

Converts the FreeSurfer pial surface, thickness, volume and the pRF eccentricity map to GIFTI, then groups vertices into eccentricity bins (0-1, 0-2, 0-3, 0-4, 0-5 degrees and beyond 5 degrees) and reports the vertices, maximum, mean and standard deviation of thickness and volume per bin, with PNG graphs. Use it to relate visual-cortex morphometry to retinotopic eccentricity. The pRF data must be on the same subject's FreeSurfer surfaces.

Run it on brainlife.io: [https://doi.org/10.25663/brainlife.app.243](https://doi.org/10.25663/brainlife.app.243)

| Input | Datatype | Required | Description |
|---|---|---|---|
| `freesurfer` | `neuro/freesurfer` | yes | The path to the top directory containing the output from Freesurfer |
| `prf` | `neuro/prf` | yes | The path to the directory containing the surface-mapped prf files from the prf datatype |

| Output | Datatype | Description |
|---|---|---|
| `raw` | `raw` | This contains the data and figures outputted from the app |

Runtime: container `brainlife/freesurfer:6.0.0`; 1 CPUs; 0.5 h walltime; needs `FREESURFER_LICENSE`.

Please cite:
- FreeSurfer methods citation: https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferMethodsCitation

<!-- brainlife-app:end -->

# app-thickness-volume-eccentricity