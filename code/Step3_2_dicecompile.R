##ImageMaths outputs individual csvs for each dice test ran.
#This code helps compile the results from each test to make a csv that can then be used for the statistical analysis
This code should be run using R or RStudio

#################################EDIT THIS PATH#################################
workingdir=c('/ifs/loni/faculty/thompson/four_d/Artemis/stroke/hippodeep/github_ready/test/')  ##path to the parent directory of your data (where each participant has an indiviudal folder)
outputdir=c('/ifs/loni/faculty/thompson/four_d/Artemis/stroke/hippodeep/github_ready/test/csv')  ##path to the directory where you will keep your spreadsheets


####EDIT SUBJECT LIST#####
#make a subject list to loop through. Here you should include every subject that you plan to use separated by commas
subjects<-c('c0003s0001t01','c0003s0004t01','c0003s0010t01','c0003s0019t01','c0003s0021t01','c0003s0022t01','c0003s0023t01','c0003s0028t01','c0003s0032t01','c0003s0033t01','c0003s0040t01','c0003s0045t01','c0003s0050t01','c0003s0055t01','c0003s0056t01','c0005s0007t01','c0005s0009t01','c0005s0010t01','c0005s0013t01','c0005s0017t01','c0006s0001t01','c0007s0002t01','c0007s0013t01','c0007s0015t01','c0007s0017t01','c0007s0032t01','c0007s0034t01','c0008s0028t01','c0008s0031t01','c0008s0033t01')     ##subject list

######################################################################################


###############################DO NOT EDIT FROM HERE ON######################################


DICE<-data.frame(matrix(ncol=7,nrow=0)) ## creates an empty data frame where you will compile the ImageMaths output
colnames(DICE)<-c('Label.Name','Dice','RO','Percent_of_Region_1_In_Overlap','Percent_of_Region_2_In_Overlap','Hemisphere','Test') ##these headers are the exact same a the individual ImageMaths output


##loop through each subject folder
for (i in 1:length(subjects)){
  subj<-subjects[i]

  ##collect the left FS-Aseg dice results
  MvF_L_csv=paste(workingdir,subj,'/',subj,'_results/dice/',subj,'_left_manualvsFS.csv',sep='')
  MvF_L<-read.csv(paste(text=MvF_L_csv))
  MvF_L$Label.Name<-subj ##add subject ID as the Label.Name
  MvF_L$Hem<-c('LEFT')
  MvF_L$Test<-c('FSasegvsManual')

  ##collect the right FS-Aseg dice results
  MvF_R_csv=paste(workingdir,subj,'/',subj,'_results/dice/',subj,'_right_manualvsFS.csv',sep='')
  MvF_R<-read.csv(paste(text=MvF_R_csv))
  MvF_R$Label.Name<-subj  ##add subject ID as the Label.Name
  MvF_R$Hem<-c('RIGHT')
  MvF_R$Test<-c('FSasegvsManual')

  #collect the left Hippodeep dice results
  MvH_L_csv=paste(workingdir,subj,'/',subj,'_results/dice/',subj,'_left_manualvshippodeep.csv',sep='')
  MvH_L<-read.csv(paste(text=MvH_L_csv))
  MvH_L$Label.Name<-subj  ##add subject ID as the Label.Name
  MvH_L$Hem<-c('LEFT')
  MvH_L$Test<-c('HippodeepvsManual')

  #collect the right Hippodeep dice results
  MvH_R_csv=paste(workingdir,subj,'/',subj,'_results/dice/',subj,'_right_manualvshippodeep.csv',sep='')
  MvH_R<-read.csv(paste(text=MvH_R_csv))
  MvH_R$Label.Name<-subj  ##add subject ID as the Label.Name
  MvH_R$Hem<-c('RIGHT')
  MvH_R$Test<-c('HippodeepvsManual')

  #collect the left FS-Subfields-Sum dice results
  MvSF_L_csv=paste(workingdir,subj,'/',subj,'_results/dice/',subj,'_left_manualvsFSsubfields.csv',sep='')
  MvSF_L<-read.csv(paste(text=MvSF_L_csv))
  MvSF_L$Label.Name<-subj  ##add subject ID as the Label.Name
  MvSF_L$Hem<-c('LEFT')
  MvSF_L$Test<-c('FSsubfieldsvsManual')

  #collect the right FS-Subfields-Sum dice results
  MvSF_R_csv=paste(workingdir,subj,'/',subj,'_results/dice/',subj,'_right_manualvsFSsubfields.csv',sep='')
  MvSF_R<-read.csv(paste(text=MvSF_R_csv))
  MvSF_R$Label.Name<-subj  ##add subject ID as the Label.Name
  MvSF_R$Hem<-c('RIGHT')
  MvSF_R$Test<-c('FSsubfieldsvsManual')

  DICE<-rbind(DICE,MvF_L,MvF_R,MvH_L,MvH_R,MvSF_L,MvSF_R) ##add the results for this subject to the dataframe
}

#rename Label.Name to SubjID
colnames(DICE)[1]<-"SubjID"

##save dataframe as csv
output=paste(outputdir,"/Dice.csv",sep="")
write.csv(DICE,output)
