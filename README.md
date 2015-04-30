This folder contains the code associated to the following paper:

**Title**: Exploiting task constraints for self-calibrated brain-machine interface control using error-related potentials.

**Authors**: I. Iturrate, J. Grizou, J. Omedes, P-Y. Oudeyer, M. Lopes and L. Montesano

**Abstract**: This paper presents a new approach for self-calibration BCI for reaching tasks using error-related potentials. The proposed method exploits task constraints to simultaneously calibrate the decoder and control the device, by using a robust likelihood function and an ad-hoc planner to cope with the large uncertainty resulting from the unknown task and decoder. The method has been evaluated in closed-loop online experiments with 8 users using a previously proposed BCI protocol for reaching tasks over a grid. The results show that it is possible to have a usable BCI control from the beginning of the experiment without any prior calibration. Furthermore, comparisons with simulations and previous results obtained using standard calibration hint that both the quality of recorded signals and the performance of the system were comparable to those obtained with a standard calibration approach.

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
*Note: If you really don't want to use git, the result of the above commands are in the [AllSourceCode.zip](https://github.com/flowersteam/self_calibration_BCI_plosOne_2015/releases/download/plosOne/AllSourceCode.zip) file from the [plosOne release](https://github.com/flowersteam/self_calibration_BCI_plosOne_2015/releases/tag/plosOne).*

Finally, add the files from the [plosOne release](https://github.com/flowersteam/self_calibration_BCI_plosOne_2015/releases/tag/plosOne) following the path given in their respective zip folder:
- [data_1.zip](https://github.com/flowersteam/self_calibration_BCI_plosOne_2015/releases/download/plosOne/data_1.zip) contains the "raw_data" folder which should be located under "data/raw_data".
- [data_2.zip](https://github.com/flowersteam/self_calibration_BCI_plosOne_2015/releases/download/plosOne/data_2.zip) contains the "experiments_selfCalibration" folder which should be located under "data/experiments_selfCalibration".
- [online.zip](https://github.com/flowersteam/self_calibration_BCI_plosOne_2015/releases/download/plosOne/online.zip) contains the "analysis" folder which should be located under "online/analysis".
- [offline.zip](https://github.com/flowersteam/self_calibration_BCI_plosOne_2015/releases/download/plosOne/offline.zip) contains the "analysis" folder which should be located under "offline/samplingEEG/analysis".

## File organization and usage

- The data/raw_data folder ([data_1.zip](https://github.com/flowersteam/self_calibration_BCI_plosOne_2015/releases/download/plosOne/data_1.zip)) contains the raw data from the online experiments. This folder contains, in Matlab format,  the EEG-recorded error-related potentials from eight subjects in an online self-calibration experiment. The folder includes a readme.txt file explaining the data organization.

- The data/experiments_selfCalibration folder ([data_2.zip](https://github.com/flowersteam/self_calibration_BCI_plosOne_2015/releases/download/plosOne/data_2.zip)) contains the processed data from the online experiments. EEG are processed and formatted as detailled in the paper and are associated with more information about the task and the evolution of our algorithm state. Some of these files are used for the analysis of the online results, see online folder description below.

- The online folder contains the code to analyse the online experiments as presented in the paper. Run the processData.m script to generate the analysis, and the plotData.m script to visualize useful information. The analysis files can also be downloaded from the release: ([online.zip](https://github.com/flowersteam/self_calibration_BCI_plosOne_2015/releases/download/plosOne/online.zip)). Do not forget to add the following folders to the Matlab path: bci_thesis, lfui, matlab_tools.

- The offline folder contains the code to run the offline analysis comparing our self-calibration algortihm with the calibrated case using the acquired EEG data. To repeat the experiments:
  * create some jobs using the offline/samplingEEG/create_jobs.m script using the parameters you want to evaluate. Then run the offline/run_samplingEEG.m script to execute all the created jobs. Results of each individual run are stored under offline/samplingEEG/results. 
  * to analyse the results, run the offline/samplingEEG/analysis.m script. The analysis files are stored under offline/samplingEEG/analysis. The analysis files generated from the experiments performed for the paper can be downloaded from the release: [offline.zip](https://github.com/flowersteam/self_calibration_BCI_plosOne_2015/releases/download/plosOne/offline.zip).
  * to visualize the key informations, generate the tables by running the offline/samplingEEG/generate_all_tables.m script to visualize the key informations. 
  
  Do not forget to add the following folders to the Matlab path: bci_thesis, lfui, matlab_tools. 

## Going into details

If you want to enter into the code, we recommend to start exploring the following repository https://github.com/jgrizou/lfui. You will find there a simple annotated example of the self-calibration code under example/gridworld/run_gridworld.m

We recommend the following papers for more details on the algortihm. 

[1] Calibration-free BCI based control. Grizou, J., Iturrate, I., Montesano, L., Oudeyer, P. Y., & Lopes, M.. AAAI Conference on Artificial Intelligence, 2014. [[pdf]](https://hal.archives-ouvertes.fr/hal-00984068/document) [[bib]](https://hal.archives-ouvertes.fr/hal-00984068v1/bibtex) [[sources]](https://github.com/jgrizou/paper_conference_aaai_2014)

[2] Interactive learning from unlabeled instructions. Grizou, J., Iturrate, I., Montesano, L., Oudeyer, P. Y., & Lopes, M.. UAI Conference on Uncertainty in Artificial Intelligence, 2014. [[pdf]](https://hal.archives-ouvertes.fr/hal-01007689/document) [[bib]](https://hal.archives-ouvertes.fr/hal-01007689v1/bibtex) [[sources]](https://github.com/jgrizou/paper_conference_uai_2014)

For even more details and illustrative drawings of these ideas, please refer to the following thesis:

[3] Learning from Unlabeled Interaction Frames. PhD thesis. Université de Bordeaux, 2014. [[pdf]](https://www.dropbox.com/s/qsi54zsnsr2cn60/Thesis_Jonathan_Grizou.pdf?dl=0) [[bib]](https://hal.inria.fr/tel-01095562v1/bibtex) [[sources]](https://github.com/jgrizou/thesis_manuscript) [[code]](https://github.com/jgrizou/thesis_code) [[defense]](https://www.youtube.com/watch?v=w62IF3qj8-E) [[slides]](https://www.dropbox.com/s/7ubezx0ln82f0nh/thesis_slides_V3.pdf?dl=0)

For more details about the use of Errps in BCI control tasks, please refer to:

[4] Shared-control brain-computer interface for a two dimensional reaching task using EEG error-related potentials. Iturrate, I., Montesano, L., & Minguez, J.. In Engineering in Medicine and Biology Society (EMBC), 2013. [[pdf]](http://webdiis.unizar.es/~jminguez/articles/EMBC13_ErrorControl.pdf) [[bib]](http://scholar.google.fr/scholar.bib?q=info:c8V1jxaudtoJ:scholar.google.com/&output=citation&scisig=AAGBfm0AAAAAVUIxGugkmdgbgY6hcoMLM9Vkjzt_vh5K&scisf=4&hl=en)

