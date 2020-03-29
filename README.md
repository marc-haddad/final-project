# Final-Project
  
### Team Members: 

Omar Haddad, Nithin Sunil, Sedra Kurdi, Myles Bridges

# Crashing into Machine Learning

### Predicting Vehicle Accident Blame 
Predicting the probability of the driver being at fault in a car crash given driver, weather, and road conditions.

### Questions:
1. How do we use machine learning algorithms to model our data?
2. What are the most predictive variables of a driver being at fault?
2. How predictive is the model? 

### Dataset Used: 
 https://data.world/montgomery-county-of-maryland/0ca5b758-c60a-40c7-bfb5-fda26ceee4c8

### Breakdown of Tasks:

1. Get dataset from sources.
2. Cleaned data.
3. Breakdown and analyze the dataset.
4. Predicting Crash Outcomes with ML

## Data Cleaning
###### Technology Used:
R with Regex, Tidyverse, Readr, and Stringr
<img src="Images/Picture1.png">

###### Renamed Columns:
<img src="Images/Picture2.png">

###### Drop columns with too many "NA" values:
<img src="Images/Picture3.png">

###### Remove obscure car makes:
<img src="Images/Picture4.png">

###### Create helper functions:
<img src="Images/Picture5.png">
<img src="Images/Picture43.png">

###### Define patterns to search for with Regex:

#### Beautiful Regex:
<img src="Images/Picture6.png">

###### "Checker" function at work:
<img src="Images/Picture7.png">
<img src="Images/Picture8.png">

###### String replacement:
<img src="Images/Picture9.png">

###### Before Cleaning:
<img src="Images/Picture10.png">
<img src="Images/Picture11.png">

###### After Cleaning:
<img src="Images/Picture12.png">
<img src="Images/Picture13.png">

## Exploratory Data Analysis

###### Most Common Accidents:
<img src="Images/Picture14.png">

###### Avg. Speed Limit vs. Injury Severity:
<img src="Images/Picture15.png">

###### Most common car makes:
<img src="Images/Picture16.png">

###### Time Analysis:
<img src="Images/Picture17.png">
<img src="Images/Picture18.png">

###### Fatal & Serious Injuries per Vehicle Make
<img src="Images/Picture19.png">

###### Vehicle Damage by Speed Limit
<img src="Images/Picture20.png">

## Predicting Crash Outcomes

### First Model: Linear SVC Model

#### Predicting Crash Outcomes: Driver at Fault?

###### Import Dependencies & Data:
<img src="Images/Picture21.png">
<img src="Images/Picture22.png">

###### Simplify Columns:
<img src="Images/Picture23.png">
<img src="Images/Picture24.png">
<img src="Images/Picture25.png">

###### Define X:
<img src="Images/Picture26.png">
<img src="Images/Picture27.png">
<img src="Images/Picture28.png">

###### Define Y
<img src="Images/Picture29.png">

###### Train/Test Split:
<img src="Images/Picture30.png">

##### Modeling and Metrics:

###### Precision-Recall Curve:
<img src="Images/Picture31.png">

###### Train Model:
<img src="Images/Picture32.png">

###### Model Metrics:
<img src="Images/Picture33.png">

###### Accuracy, Precision, Balanced Accuracy, & MSE:
<img src="Images/Picture34.png">
<img src="Images/Picture35.png">
<img src="Images/Picture38.png">

###### Confusion Matrix:
<img src="Images/Picture36.png">
<img src="Images/Picture37.png">

### Second Algorithm

###### Reasoning:
Utilized Logistic regression because "driver_at_fault" is **Categorical**

###### Approach:
1.) Created Dummy Variables for each categorical feature
2.) Balanced data using **Synthetic Minority Oversampling** in order to have
    equal amounts of "at fault" and "not at fault"
3.) Used **Recursive Feature Elimination** for variable selection
4.) Fit features into Logistic Regression Model

###### Feature and Model Breakdown:
<img src="Images/Picture39.png">

###### Accuracy:
<img src="Images/Picture40.png">

###### Precision, Recall, and F1 Score:
<img src="Images/Picture41.png">

###### ROC Curve:
<img src="Images/Picture42.png">
