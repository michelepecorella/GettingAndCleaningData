# GettingAndCleaningData
# Coursera's Assignament
In this repo there are:

  run_analysis.R: it is the script that generate the tidydata.txt as says the assignament's istruction.
  
  tidydata.txt: it is the tidy dataset generated by the script
  
  codebook.md: The information regarding the script.
  
# Some explanation of the script
I decide to not consider the folders "Inertial Signals" because I understood by the istruction that it's necessary only to consider this txt: "X_test", "subject_test", "y_test", "subject_train", "X_train", "y_train", "activity_labels", "features"
I read with care "README" and "features_info"

With the script run_analysis.R all the 5 point, that the script should make, are done but in a different order: before merge the test and train file I prefer to put in both file the activity names, the variable names and to add also a column for the subject. Then, I merge the files, extract only the measurements on the mean and standard deviation and create a new tidy dataset with the avarage of each variable, for each activity and each subject.

When I had to extract only the measurements on the mean and standard deviation I was undecided if to extract only the measurements that include mean() and std() at the end or does include also measurements with mean in an earlier part of the name as well, I decided at the end the latter.
The calcolous of the mean in point 5 is made from data that have the same subject, same variable and same activity at the same time.
