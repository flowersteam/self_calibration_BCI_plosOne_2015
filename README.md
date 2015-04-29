This folder contains the code associated to the following paper:

## Title

Exploiting task constraints for self-calibrated brain-machine interface control using error-related potentials.
I. Iturrate, J. Grizou, J. Omedes, P-Y. Oudeyer, M. Lopes and L. Montesano

## Abstract

This paper presents a new approach for self-calibration BCI for reaching tasks using error-related potentials. The proposed method exploits task constraints to simultaneously calibrate the decoder and control the device, by using a robust likelihood function and an ad-hoc planner to cope with the large uncertainty resulting from the unknown task and decoder. The method has been evaluated in closed-loop online experiments with 8 users using a previously proposed BCI protocol for reaching tasks over a grid. The results show that it is possible to have a usable BCI control from the beginning of the experiment without any prior calibration. Furthermore, comparisons with simulations and previous results obtained using standard calibration hint that both the quality of recorded signals and the performance of the system were comparable to those obtained with a standard calibration approach.

## Setting up the repository:
```
git clone https://github.com/flowersteam/self_calibration_BCI_plosOne_2015.git
cd self_calibration_BCI_plosOne_2015/
git submodule init
git submodule update

cd matlab_tools
git submodule init
git submodule update
```
Then add the files from this release following the path given in their zip folders (e.g. raw_data goes under data/raw_data).

## File organization and usage

The data/raw_data folder contains the raw data from the online experiments. This folder contains a self-contained [readme.txt](data/raw_data/readme.txt) file.

The data/experiments_selfCalibration folder contains the data from the online experiment including more information about the task and the evolution of our algorithm state. Some of these files are used for the analysis of the online results, see online folder description below.

The online folder contains all the code to analyse the online experiments as presented in the paper. Run the processData.m and the plotData.m script to generate the analysis. Do not forget to add the following folders to the Matlab path: bci_thesis, lfui, matlab_tools. The analysis file can also be downloaded from the release.

The offline folder contains the code to run the offline analysis used to compare our aself-calibration algortihm with the calibrated case using the same EEG data. To repeat the experiments, first create some jobs using the offline/samplingEEG/create_jobs.m script using the parameters you want to evaluate. Then run the offline/run_samplingEEG.m script to execute all the created jobs. Results of each individual run are stored under offline/samplingEEG/results. To analyse the results, run the offline/samplingEEG/analysis script. The analysis files are stored under offline/samplingEEG/analysis. finally run the offline/samplingEEG/generate_all_tables.m script to visualize the key informations. Do not forget to add the following folders to the Matlab path: bci_thesis, lfui, matlab_tools. The analysis files generate from the experiments performed for the paper can be downloaded from the release.
