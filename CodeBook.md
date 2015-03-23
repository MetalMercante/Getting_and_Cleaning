# CodeBook

The CodeBook describes the variables, data and transformations used  to tidy the data from the the accelerometers from the Samsung Galaxy S smartphone to create a dataset in LONG FORMAT.

##Assumptions

This code  utilizes two folders, one containing the datasets and another with the R code "run_analysis.R"

## R Packages

This code uses the dplyr and the reshape2 packages, most of the operations to create the tidy set are done using dplyr and the reshape2 package is mostly used for it's "melt" function


### Loading and preparing the Datasets

* Load all datasets into separate dataframes
* Load the labels file
* Create a vector of unique names
* Wrap the dataframes with the tbl_df() function

### Naming and binding the datasets

* Set each dataset(XTE and XTR) with the unique names
* Create a variable "Dataset" that identifies each observation to the dataset it belongs ("train", "test")
* Bind the train and test datasets

### Extracting the measurements on the mean and standard deviation for each measurement.

* dplyr chain command that selects only the variable names that contains "mean(" and "std("
* the ")" is important becayse we don't want to include variables like "angle(tBodyAccJerkMean),gravityMean)"

### Using the descriptive names
* bind the "Y" data (train and test)
* inner_join by "V1"
* bind the descriptive names with the main dataset

### Creating the tidy dataset

* use dplyr to group by Dataset and Y 
* summarize to get the mean of the variables
* melt into a long dataset

