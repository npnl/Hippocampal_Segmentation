# Hippocampal_Segmentation

**Getting Started**

This github page provides bilateral manual hippocampal segmentations in stroke populations and code to test automated hippocampal segmentation tools for accuracy.

**Hippocampal Segmentations**

Bilateral manual hippocampal segmentations were generated for 30 participants of the Anatomical Tracings for Lesions After Stroke (ATLAS) dataset (Liew et al., 2018). Instructions for downloading the corresponding T1-w MRI for the hippocampal segmentations can be found in Liew et al., 2018: https://www.nature.com/articles/sdata201811

**Code**

The following code assumes you have run FreeSurfer version 6.0 with the hippocampal subfields flag and Hippodeep.

Dependencies include FreeSurfer version 6.0, Hippodeep, ANTs, and R.

These scripts assumes that the input data for FreeSurfer, Hippodeep, and the manual segmentations are all in the same space and there is a working directory already created with folders for each individual subject. All scripts require path modification 

*Step1_1_hippfromFSsubfields.sh* transforms the FSsubfields output from FreeSurfer space to MNI space and binarizes the segmentation
*Step1_2_hippfromFSaseg.sh* transforms the FSaseg output from FreeSurfer space to MNI space, singles out the hippocampus, and binarizes the segmentation
*Step1_3_hippfromhippodeep.sh* copies over the hippodeep output and binarizes the segmentation

Once these three scripts are run, each subject folder should have a folder called subject_segs where left and right hippocampal segmentations from FSsubfields, FSsseg, and hippodeep.
If you are doing your own manual segmentations, make a copy of the left and right manual segmentations in each subject_segs folder.
If you downloaded the manual segmentations from the NPNL github, make a copy of the left and right manual segmentations in each subject_segs folder.
These scripts assume you have named the manual segmentations as follows: "subject_hipp_manual_R.nii.gz" and "subject_hipp_manual_L.nii.gz" (ex. Subject1_hipp_manual_R.nii.gz and Subject1_hipp_manual_L.nii.gz)

*Step2_extract_volume.sh* extracts estimated hippocampal volume for all segmentations and outputs them into a csv. A folder called "csv" specifically for csv files that are used in the statistical analysis is generated in the working directory
*Step3_1_dice.sh* calculates spatial overlap (Dice Coefficient) using the ANTs tool ImageMath

*Step3_2_dicecompile.R* must be run using R. This script extracts the dice coefficient for every segmentation comparison and creates a compiled csv to be used for the statistical analysis

*Hippodeep_analysis.Rnw* is an Rmarkdown file that can be used for running statistical analyses

**CSV**

*Atlas_compare.csv* contains the meta data for the ATLAS participants used in Zavaliangos-Petropulu et al., 2020

*Dice.csv* is a sample output of Step3_2_dicecompile.R

*volume.csv* is a sample output of Step2_extract_volume.sh


**Support**

The best way to keep track of bugs or failures is to open a New Issues on the Github system. You can also contact the author via email at zavalian at usc dot edu

**Referencing**

Please reference our overview paper when using the manual hippocampal segmentations or code
Zavaliangos-Petropulu et al., (2020). Testing a convolutional neural network-based hippocampal segmentation method in a stroke population. bioRxiv preprint doi: 


