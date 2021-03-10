old.dir <- getwd()
list.files()

#load packages 
library(tidyverse)
library(readxl)
#load excel files 
metadata <- read_excel("metadata_314s_28feb2020.xlsx", col_names = TRUE)
metadata_MDD <- read_excel("41380_2020_896_MOESM2_ESM.xlsx", col_names = TRUE)
#check if it worked 
head(metadata)
head(metadata_MDD)


#logistic vector with similar donor id's between files. 
compare <- metadata$Donor_id%in%metadata_MDD$`Donor id`
metadata_MDD_regions <- metadata[compare,]
#dataframe wtih 153 obs. 

#new vector for all the Controls and MDD donors from original dataset.
compare2 <- metadata$Diagnosis=="Healthy control" | metadata$Diagnosis=="Depression"
unique(metadata_MDD$Diagnosis)
unique(metadata$Diagnosis)

#how many donors (control or MDD) are included? how many TRUE's are in 'healthy. 
sum(compare2)

#create dataframe with only MDD or control data
metadata_MDD_regions2 <- metadata[compare2,]

#compare donor ids between new dataframe (compare2) (of MDD/controls from original dataframe, with sub-datafile
metadata_MDD_regions$Donor_id%in%metadata_MDD_regions2$Donor_id
sum(metadata_MDD_regions$Donor_id%in%metadata_MDD_regions2$Donor_id)
#140 donor id's are similar between the 2 datasets. 

#which donor id's are different? -> setdiff(). check both directions. 
setdiff(metadata_MDD_regions$Donor_id,metadata_MDD_regions2$Donor_id)
length(setdiff(metadata_MDD_regions$Donor_id,metadata_MDD_regions2$Donor_id))
# 4 donor id : 
setdiff(metadata_MDD_regions2$Donor_id,metadata_MDD_regions$Donor_id)
length(setdiff(metadata_MDD_regions2$Donor_id,metadata_MDD_regions$Donor_id))
# 5 donor ids 

#create vector for donor id's and combine them.  
diff_ids1 <-setdiff(metadata_MDD_regions2$Donor_id,metadata_MDD_regions$Donor_id)
diff_ids2 <-setdiff(metadata_MDD_regions$Donor_id,metadata_MDD_regions2$Donor_id)
#vector with the 22 different donor id's 
diff_ids <- c(diff_ids1,diff_ids2)

metadata_MDD_regions[diff_ids1,]

length(metadata_MDD_regions$Donor_id%in%metadata_MDD_regions2$Donor_id)

#shortcut for dataframe usage
attach(metadata_314s)

boxplot(as.numeric(FastQC_avg_sequence_length))
test <- as.numeric(FastQC_avg_sequence_length)
boxplot(test~Tissue)


