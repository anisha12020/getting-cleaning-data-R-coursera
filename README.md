---
title: "README"
author: "Anisha"
date: ""28/02/2021"
output: html_document
---

The script "run_analysis.R" takes the training and testing data from the Human Activity Recognition Using Smartphones Dataset and combines them to create a tidy data set of average values of certain features, "tidydata.txt". A full explanation of the tidy data set is available in the codebook "codebook.txt".

The script first reads the testing and training data into separate lists and then combines into one list. We also read in the names of the features and assign them to the appropriate list elements. Then we pick the relavant features and combine them into a data frame. After that we merge the activity names to make them more descriptive than simple numbers, and then we fiddle with variable names to make them more descriptive. Finally, we summarize for each subject activity combination the average of the features in the dataframe, and we write this new dataframe into a text file for submission.

References:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

