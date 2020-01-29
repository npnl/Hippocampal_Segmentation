#!/bin/bash
#$ -S /bin/bash

# Artemis Zavaliangos-Petropulu, ###zavalian(at)usc(dot)edu###, 1/17/2020


export FREESURFER_HOME="/usr/local/freesurfer-6/"
export LIBGL_ALWAYS_INDIRECT=1
source $FREESURFER_HOME/SetUpFreeSurfer.sh


export FSLDIR="/usr/local/fsl-5.0.7"
    . ${FSLDIR}/etc/fslconf/fsl.sh

#################################EDIT THESE TWO PATHS#################################

##path to directory you are working in
workingdir=/ifs/loni/faculty/thompson/four_d/Artemis/stroke/hippodeep/github_ready/test
##path to hippodeep output
hippodeep=/ifs/loni/faculty/thompson/four_d/Artemis/stroke/hippodeep/Atlas_T1
######################################################################################




###############################DO NOT EDIT FROM HERE ON######################################
cd ${workingdir}


##this script assumes you have a working directory where you have already created folders for each individual subject where you will do the analysis

##to create a subject list, it takes the names of all of the folders in the working director that start with "c0"
##"c0" contains the first two characters of ATLAS subject name (example: c0003s0001t01). Modify this for your own dataset

subjects=`ls -d c0*`

for subj in ${subjects};
do


##path to subject analysis folder
output=${workingdir}/${subj}/${subj}_segs

##if you modified the hippodeep script to output in a specific naming convention, edit accordingly
cp ${hippodeep}/${subj}/${subj}_t1w_stx_mask_L.nii.gz ${output}/${subj}_hipp_hippodeep_L.nii.gz
cp ${hippodeep}/${subj}/${subj}_t1w_stx_mask_R.nii.gz ${output}/${subj}_hipp_hippodeep_R.nii.gz

##binarize the segmentation
/usr/local/fsl-5.0.7/bin/fslmaths ${output}/${subj}_hipp_hippodeep_L.nii.gz -bin ${output}/${subj}_hipp_hippodeep_L.nii.gz
/usr/local/fsl-5.0.7/bin/fslmaths ${output}/${subj}_hipp_hippodeep_R.nii.gz -bin ${output}/${subj}_hipp_hippodeep_R.nii.gz



done
