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
##path to FreeSurfer results
FS_dir=/ifs/loni/faculty/thompson/four_d/Artemis/stroke/hippodeep/FS_60_atlas_all/
######################################################################################

###############################DO NOT EDIT FROM HERE ON######################################
cd ${workingdir}


##this script assumes you have a working directory where you have already created folders for each individual subject where you will do the analysis

##to create a subject list, it takes the names of all of the folders in the working director that start with "c0"
##"c0" contains the first two characters of ATLAS subject name (example: c0003s0001t01). Modify this for your own dataset

subjects=`ls -d c0*`



for subj in ${subjects};

do

#with the subject directory
mkdir -p ${workingdir}/${subj}/${subj}_segs
output=${workingdir}/${subj}/${subj}_segs

##convert aparc+aseg to native space and binarize the output
/usr/local/freesurfer-6/bin/mri_label2vol --seg ${FS_dir}/${subj}/mri/lh.hippoSfLabels-T1.v10.FSvoxelSpace.mgz --temp ${FS_dir}/${subj}/mri/rawavg.mgz --o ${FS_dir}/${subj}/mri/lh.hippoSfLabels-T1.v10.FSvoxelSpace_native.mgz --regheader ${FS_dir}/${subj}/mri/lh.hippoSfLabels-T1.v10.FSvoxelSpace.mgz
/usr/local/freesurfer-6/bin/mri_convert --in_type mgz --out_type nii --out_orientation RAS ${FS_dir}/${subj}/mri/lh.hippoSfLabels-T1.v10.FSvoxelSpace_native.mgz ${output}/${subj}_hipp_FSsubfields_L.nii.gz ##reorient
/usr/local/fsl-5.0.7/bin/fslmaths ${output}/${subj}_hipp_FSsubfields_L.nii.gz -bin ${output}/${subj}_hipp_FSsubfields_L.nii.gz ##replaces native space subfield seg with binarized version


/usr/local/freesurfer-6/bin/mri_label2vol --seg ${FS_dir}/${subj}/mri/rh.hippoSfLabels-T1.v10.FSvoxelSpace.mgz --temp ${FS_dir}/${subj}/mri/rawavg.mgz --o ${FS_dir}/${subj}/mri/rh.hippoSfLabels-T1.v10.FSvoxelSpace_native.mgz --regheader ${FS_dir}/${subj}/mri/rh.hippoSfLabels-T1.v10.FSvoxelSpace.mgz
/usr/local/freesurfer-6/bin/mri_convert --in_type mgz --out_type nii --out_orientation RAS ${FS_dir}/${subj}/mri/rh.hippoSfLabels-T1.v10.FSvoxelSpace_native.mgz ${output}/${subj}_hipp_FSsubfields_R.nii.gz ##reorient
/usr/local/fsl-5.0.7/bin/fslmaths ${output}/${subj}_hipp_FSsubfields_R.nii.gz -bin ${output}/${subj}_hipp_FSsubfields_R.nii.gz ##replaces native space subfield seg with binarized version

done
