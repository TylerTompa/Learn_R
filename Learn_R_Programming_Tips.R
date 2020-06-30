# rds
##################################################
# Large csv files can take a long time for R to read.
# As an alternative, you can save the file and read it as an R Binary File (rds)

# I will return to this later and study R Binary Files more closely.
# This script has more-or-less been started as a reminder to come back to this topic later.
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/readRDS
# - Tyler
random_numbers_1 <- sample(1:9, 5)
random_numbers_2 <- sample(1:9, 5)
random_numbers_3 <- sample(1:9, 5)
random_numbers_4 <- sample(1:9, 5)
random_numbers_5 <- sample(1:9, 5)
random_dataframe <- data.frame(random_numbers_1,
                               random_numbers_2,
                               random_numbers_3,
                               random_numbers_4,
                               random_numbers_5)

fil <- tempfile("random_dataframe", fileext = ".rds")
saveRDS(random_dataframe, fil)

dataframe_rds <- readRDS(fil)
dataframe_rds