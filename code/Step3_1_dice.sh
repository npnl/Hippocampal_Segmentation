#!/bin/bash
#$ -S /bin/bash


# Artemis Zavaliangos-Petropulu, ###zavalian(at)usc(dot)edu###, 1/17/2020
###this script requires FSL and ANTs - download these dependencies and modify the paths accordingly

PATH=${PATH}:/usr/local/fsl-4.1.5_64bit/bin
FSLDIR=/usr/local/fsl-4.1.5_64bit
. ${FSLDIR}/etc/fslconf/fsl.sh



#################################EDIT THIS PATH#################################

##path to directory you are working in
workingdir=/ifs/loni/faculty/thompson/four_d/Artemis/stroke/hippodeep/github_ready/test
######################################################################################


###############################DO NOT EDIT FROM HERE ON######################################

cd ${workingdir}

subjects=`ls -d c0*`

for subj in ${subjects};
do


dir=${workingdir}/${subj}/${subj}_segs

mkdir ${workingdir}/${subj}/${subj}_dice

dicedir=${workingdir}/${subj}/${subj}_dice



#####################################CALCULATE DICE###############################################
########################################right hemisphere##########################################
##FSaseg vs manual
/usr/local/ANTs/bin/ImageMath 3 ${dicedir}/${subj}_right_FSasegvsManual DiceAndMinDistSum ${dir}/${subj}_hipp_manual_R.nii.gz ${dir}/${subj}_hipp_FSaseg_R.nii.gz
##Hippodeep vs manual
/usr/local/ANTs/bin/ImageMath 3 ${dicedir}/${subj}_right_HippodeepvsManual DiceAndMinDistSum ${dir}/${subj}_hipp_manual_R.nii.gz ${dir}/${subj}_hipp_hippodeep_R.nii.gz
##FSsubfields vs manual
/usr/local/ANTs/bin/ImageMath 3 ${dicedir}/${subj}_right_FSsubfieldsvsManual DiceAndMinDistSum ${dir}/${subj}_hipp_manual_R.nii.gz ${dir}/${subj}_hipp_FSsubfields_R.nii.gz

########################################left hemisphere##########################################
##FSaseg vs manual
/usr/local/ANTs/bin/ImageMath 3 ${dicedir}/${subj}_left_FSasegvsManual DiceAndMinDistSum ${dir}/${subj}_hipp_manual_L.nii.gz ${dir}/${subj}_hipp_FSaseg_L.nii.gz
##Hippodeep vs manual
/usr/local/ANTs/bin/ImageMath 3 ${dicedir}/${subj}_left_HippodeepvsManual DiceAndMinDistSum ${dir}/${subj}_hipp_manual_L.nii.gz ${dir}/${subj}_hipp_hippodeep_L.nii.gz
##FSsubfields vs manual
/usr/local/ANTs/bin/ImageMath 3 ${dicedir}/${subj}_left_FSsubfieldsvsManual DiceAndMinDistSum ${dir}/${subj}_hipp_manual_L.nii.gz ${dir}/${subj}_hipp_FSsubfields_L.nii.gz


done
