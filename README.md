# analysisCode

MATLAB analysis pipeline for oculomotor behavior and cerebellar physiology, including eye movement signal processing, saccade detection and removal, cycle-averaged response analysis, and single-trial calcium imaging integration.

## Overview

This is the primary analysis repository for the Stanford oculomotor cerebellum project, supporting the analysis of optokinetic reflex (OKR) and vestibulo-ocular reflex (VOR) eye movement data alongside fiber photometry calcium imaging from cerebellar Purkinje cells. The codebase spans the full analysis pipeline from raw signal import through desaccading, cycle averaging, population analysis, and figure generation for publication.

This repository has 44 commits representing active iterative development throughout the Stanford postdoctoral project.

## Contents

### Signal Import & Preprocessing
- `importDatObject.m` / `spike2import.m` — Import raw eye movement data from acquisition systems
- `calSampRate.m` / `caliToying.m` — Sampling rate calibration and verification for eye position signals
- `upsampDownsamp.m` — Resampling utilities for aligning data streams at different sampling rates
- `segmenting.m` — Segments continuous recordings into individual trials or stimulus cycles

### Eye Movement Analysis
- `desaccading.m` / `desacVel.m` / `clusterDesaccading.m` / `madDesacFrequencies.m` — Saccade detection and removal algorithms; multiple approaches including velocity threshold, MAD-based detection, and cluster-based identification
- `extendSaccadesToThres.m` — Extends saccade removal windows to signal return-to-threshold
- `removeArtifacts.m` / `removeTransients.m` / `removeAroundCenters.m` — Artifact and transient rejection for clean signal extraction
- `getSaccadeIdxs.m` / `getStartStop.m` / `findTightestCluster.m` — Supporting utilities for saccade indexing and epoch boundary detection
- `saccadeFilter.m` — Automated saccade filtering pipeline combining detection, extension, and interpolation

### Oculomotor Response Analysis
- `analysis.m` / `analysisPart2.m` — Main analysis scripts for OKR and VOR response characterization
- `cycAvgPlots.m` / `plotBlockCycAvgs.m` — Cycle-averaged eye velocity and position plotting across stimulus blocks
- `concatAnalysis.m` / `concatAnalyses.m` / `metaConcatAnalysis.m` — Concatenation and meta-analysis across sessions and frequency conditions
- `concatExcel05hz2hz.m` / `concatMultipleFreq.m` / `concatOculoCondition.m` — Frequency-specific and condition-specific data concatenation
- `popOKRanalyses.m` — Population-level OKR analysis across subjects
- `phaseCode.m` / `phasePlotting.m` — Phase analysis for sinusoidal stimulus responses
- `sinesFit.m` — Sine wave fitting to extract gain and phase from OKR/VOR responses
- `getF0.m` — Fundamental frequency extraction from sinusoidal response data

### Calcium Imaging Integration
- `singleTrialCalcium.m` — Single-trial calcium signal analysis aligned to oculomotor behavioral events
- `singleTrialConcatAnalyses.m` — Concatenation of single-trial calcium data across sessions
- `singleTrialCorrelations.m` — Correlation analysis between single-trial calcium signals and behavioral metrics
- `singleTrialPlots.m` — Visualization of single-trial calcium traces with behavioral overlays

### Visualization & Statistics
- `ampIdxPlots.m` — Amplitude index plotting for comparing response magnitudes across conditions
- `boxplotGraphing.m` — Publication-quality boxplot generation with individual data point overlays
- `correlationPlot.m` / `scatterCorr.m` — Scatter plot and correlation visualization
- `lineGraphs.m` / `lineGraphsLikelihood.m` / `linePlotFlippedAxes.m` / `linePlotsVORacuteShade.m` — Line graph variants for behavioral and physiological data
- `catOCplotting.m` / `dimBrightPlots.m` / `minDataPlot.m` / `pvPlotting.m` / `polarPlotting.m` — Specialized plots for oculomotor and calcium data
- `stackedPlot.m` — Stacked visualization of multiple data streams
- `timingHistograms.m` / `timingScatterPlots.m` — Event timing analysis and visualization
- `linearFitting.m` / `randBlockSort.m` / `putInContext.m` — Statistical fitting and block randomization utilities

### Output
- `write2excelSJ.m` — Exports analysis results to formatted Excel workbooks for downstream statistical analysis

## Requirements

- MATLAB R2018a or later
- Signal Processing Toolbox
- Statistics and Machine Learning Toolbox

## Related Publications

**Fanning A**, Shakhawat A, Raymond J. Population calcium responses of Purkinje cells in the oculomotor cerebellum driven by non-visual input. *Journal of Neurophysiology*, 2021;126(4):1391–1402.

Shim HG, **Fanning AS**, Raymond JL. Flexible Coupling of Synaptic and Intrinsic Plasticity in a Cerebellar Circuit. *Journal of Neuroscience*, 2026.
