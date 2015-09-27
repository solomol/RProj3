
The script uses data.table and reshape 2 to process data.

First labels and features are read in. The grepl function searches for regular expressions- blocks of text contained in the features list.

Then data tables for training data are read, cbind is used to merge them.
Then same thing is done for the training data.

Rbind is used to mash data together together, since we are combining rows with the same features.

Melt is used to reorganize the data to a slim form for aggregation, and dcast is used the mean for each set ofchosen variables.