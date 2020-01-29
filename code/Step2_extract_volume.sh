#!/bin/bash


# Artemis Zavaliangos-Petropulu, ###zavalian(at)usc(dot)edu###, 1/17/2020


export FSLDIR="/usr/local/fsl-5.0.7"
    . ${FSLDIR}/etc/fslconf/fsl.sh


#################################EDIT THIS PATH#################################

##path to directory you are working in
workingdir=/ifs/loni/faculty/thompson/four_d/Artemis/stroke/hippodeep/github_ready/test
######################################################################################

###############################DO NOT EDIT FROM HERE ON######################################


cd ${workingdir}
#create a directory where all of the csv will output to
mkdir ${workingdir}/csv

#create a csv with headings for subject ID and the left and right hippocampal volumes of each segmentation method
echo " SubjID,Manual_L,Manual_R,FSaseg_L,FSaseg_R,Hippodeep_L,Hippodeep_R,FSsubfields_L,FSsubfields_R" >> ${workingdir}/csv/volumes.csv



subjects=`ls -d c0*`

for subj in ${subjects};
  do
    Man_L=`/usr/local/fsl-5.0.7/bin/fslstats ${subj}/${subj}_segs/${subj}_hipp_manual_L.nii.gz -V`      ##use /usr/local/fsl-5.0.7/bin/fslstats to calculate the volume of the hippocampus
    Man_L_ready=($Man_L)							  ##assign it to a variable
    Man_R=`/usr/local/fsl-5.0.7/bin/fslstats ${subj}/${subj}_segs/${subj}_hipp_manual_R.nii.gz -V`
    Man_R_ready=($Man_R)

    FS_L=`/usr/local/fsl-5.0.7/bin/fslstats ${subj}/${subj}_segs/${subj}_hipp_FSaseg_L.nii.gz -V`
    FS_L_ready=($FS_L)
    FS_R=`/usr/local/fsl-5.0.7/bin/fslstats ${subj}/${subj}_segs/${subj}_hipp_FSaseg_R.nii.gz -V`
    FS_R_ready=($FS_R)

    Hippodeep_L=`/usr/local/fsl-5.0.7/bin/fslstats ${subj}/${subj}_segs/${subj}_hipp_hippodeep_L.nii.gz -V`
    Hippodeep_L_ready=($Hippodeep_L)
    Hippodeep_R=`/usr/local/fsl-5.0.7/bin/fslstats ${subj}/${subj}_segs/${subj}_hipp_hippodeep_R.nii.gz -V`
    Hippodeep_R_ready=($Hippodeep_R)

    Subfields_L=`/usr/local/fsl-5.0.7/bin/fslstats ${subj}/${subj}_segs/${subj}_hipp_FSsubfields_L.nii.gz -V`
    Subfields_L_ready=($Subfields_L)
    Subfields_R=`/usr/local/fsl-5.0.7/bin/fslstats ${subj}/${subj}_segs/${subj}_hipp_FSsubfields_R.nii.gz -V`
    Subfields_R_ready=($Subfields_R)

##print the subject name and the left and right hippocampal volumes for each segmentation method
    echo ${subj},${Man_L_ready[0]},${Man_R_ready[0]},${FS_L_ready[0]},${FS_R_ready[0]},${Hippodeep_L_ready[0]},${Hippodeep_R_ready[0]},${Subfields_L_ready[0]},${Subfields_R_ready[0]} >> ${workingdir}/csv/volumes.csv

  done
