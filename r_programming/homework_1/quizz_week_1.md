# Coursera - R Programming

## Quizz 1

#### Question 11: In the dataset provided for this Quiz, what are the column names of the dataset?

    > names(x)
    [1] "Ozone"   "Solar.R" "Wind"    "Temp"    "Month"   "Day"

#### Question 12: Extract the first 2 rows of the data frame and print them to the console. What does the output look like?

    > head(x, 2)
      Ozone Solar.R Wind Temp Month Day
    1    41     190  7.4   67     5   1
    2    36     118  8.0   72     5   2

#### Question 13: How many observations (i.e. rows) are in this data frame?

    > nrow(x)
    [1] 153

#### Question 14: Extract the last 2 rows of the data frame and print them to the console. What does the output look like?

    > tail(x, 2)
        Ozone Solar.R Wind Temp Month Day
    152    18     131  8.0   76     9  29
    153    20     223 11.5   68     9  30

#### Question 15: What is the value of Ozone in the 47th row?

    > x[47, ]
       Ozone Solar.R Wind Temp Month Day
    47    21     191 14.9   77     6  16

#### Question 16: How many missing values are in the Ozone column of this data frame?

    > sum(is.na(x[["Ozone"]]))
    [1] 37

#### Question 17: What is the mean of the Ozone column in this dataset? Exclude missing values (coded as NA) from this calculation.

    > mean(x[["Ozone"]], na.rm=TRUE)
    [1] 42.12931

#### Question 18: Extract the subset of rows of the data frame where Ozone values are above 31 and Temp values are above 90. What is the mean of Solar.R in this subset?

    > y <- x[ which(x[["Ozone"]] > 31 & x[["Temp"]] > 90), ]
    > mean(y[["Solar.R"]], na.rm=TRUE)
    [1] 212.8

#### Question 19: What is the mean of "Temp" when "Month" is equal to 6?

    > y <- x[ which(x[["Month"]] == 6), ]
    > mean(y[["Temp"]], na.rm=TRUE)
    [1] 79.1

#### Question 20: What was the maximum ozone value in the month of May (i.e. Month = 5)?

    > y <- x[ which(x[["Month"]] == 5), ]
    > max(y[["Ozone"]], na.rm=TRUE)
    [1] 115