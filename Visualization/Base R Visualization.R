library(MASS)
library(dplyr)

# Arguably, the most straightforward visualization in R is produced with the plot() function;
# this creates a simple array of visualization,
# to illustrate the relationship between each variable in a dataset

# Consider the whiteside dataset form the MASS library,
# a record of gas consumption, temperature, and whether cavity-wall insulation was installed at the time.
glimpse(whiteside)
plot(whiteside)
# The caveat to this function is that in datasets with more columns, the plot becomes harder to read.
plot(mtcars)
