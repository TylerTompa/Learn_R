# You can delete variables on R using the remove() or the rm() function.
variable1 <- 1
variable1
rm(variable1)

# You can delete multiple variables at once buy including each one within the rm() function.
# The following will delete variable1 and variable2, but not variable3.
variable1 <- 1
variable2 <- c(1,2)
variable3 <- c(1,2,3)
rm(variable1, variable2)

# Lastly, you can also delete all variables at once with the ccommand: rm(list = ls())
variable1 <- 1
variable2 <- c(1,2)
variable3 <- c(1,2,3)
rm(list = ls() )
# WARNING: YOU SHOULD ONLY RUN THIS COMMAND IN THE CONSOLE.  IF THIS IS INCLUDED IN SCRIPTS OR MARKDOWN FILES,
# IT CAN POTENTIALLY CAUSE UNINTENDED EFFECTS.

# The class() function
##################################################
# You can check the class of a variable with the class() function.

# R does not differentiate between integers and decinals;
# to R they are both just numeric.
integer <- 4
class(integer)

decimal <- 4.5
class(decimal)

character <- "4"
class(character)

# Update 2020-07-01
# By typing "L" after a integer, you can tell R to store the variable as specifically an integer.
numeric_by_default <- 10
specifically_an_integer <- 10L
class(numeric_by_default)
class(specifically_an_integer)

# R recognizes a vector of a certain class as that class itself.
# Instead of a vector of numerics, R just sees numeric.
vector_of_numbers <- c(1, 2, 3)
class(vector_of_numbers)
vector_of_characters <- c("1", "2", "3")
class(vector_of_characters)

# Similarly, R only sees a list as a list, not as a list of a certain class.
list_of_numbers <- list(1, 2, 3, 4, 5)
class(list_of_numbers)
list_of_characters <- list("1", "2", "3", "4", "5")
class(list_of_characters)
list_of_mixed_classes <- list(1, c("1", "2", "3"), "4", FALSE)
class(list_of_mixed_classes)

# Booleans are called "logical" in R.
logical <- TRUE
class(logical)

##################################################

# Vectors
##################################################
# When using vectors, you can "name" each element using the names() function after defining the vector.
profits <- c(98, 94, 96,
             97, 100, 103,
             102, 102, 104,
             105, 100, 103)
names(profits) <- c("January", "February", "March",
                   "April", "May", "June",
                   "July", "August", "September",
                   "October", "November", "December")
# You can then reference an element by both index and name.
profits[7]
profits["July"]

# Alternatively, you can name each element as you're defining the vector.
rm(profits)
profits <- c("January" = 98, "February" = 94, "March" = 96,
             "April" = 97, "May" = 100, "June" = 103,
             "July" = 102, "August" = 102, "September" = 104,
             "October" = 105, "November" = 100, "December" = 103)
profits[7]
profits["July"]

# Consider your daily revenue in a given week, and your daily costs in the same week
daily_revenue <- c(98, 95, 92, 94, 93)
daily_costs <- c(24, 20, 22, 22, 23)
# Now define a vector of day names.
days_vector <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")

# Then you do something completely unnecesary-but nonetheless awesome-like this.
names(daily_revenue) <- days_vector -> names(daily_costs)
daily_revenue["Tuesday"] - daily_costs["Tuesday"]

# Logical operations are performed element-wise with vectors, returning a list of logical variables.
daily_costs > 22
# Meaning that a logical operation can be used to select which elements we want.
# Under the hood, you are forming a vector of logical variables,
# then passing that vector into your vector of interest.
daily_costs[daily_costs > 22]
daily_costs[daily_costs > 22 & daily_costs < 24]
c(daily_revenue - daily_costs)[c(daily_revenue - daily_costs) > 70]
##################################################

# Factors
##################################################
# Factors are a data type used to store repetitive categorical data.
# You can create a factor with factor() function with the factor elements,
# or by converting an existing vector to a factor.
speeds <- c("S", "A", "A", "F", "A", "S", "F", "A", "F")
speeds_factor <- factor(speeds)
class(speeds_factor)

# You can then use the summary() function for a summary of the levels that make up the factor
summary(speeds_factor)

# You can use the levels function to see each distinct category, or "level," within a factor.
# WARNING: THE ORDER WITH WHICH YOU ASSIGN LEVELS IS IMPORTANT.
# R automatically puts categories in alphabetical order when defining a factor.
# Then R assigns each category a level in the order you define each level.
# In our example, we have "S" (Slow), "A" (Average), and "F" (Fast).
# R automatically orders the categories: A, F, S.
# Therefore, we must define the levels with the same order: "Average," then "Fast," then "Slow."
# Compare the following assignments:
levels(speeds_factor) <- c("Slow", "Average", "Fast")
summary(speeds_factor)

levels(speeds_factor) <- c("Average", "Fast", "Slow")
summary(speeds_factor)

# In some cases, certain categories are "better" than others, as in this example.
# The "ordered" argument can be set to TRUE to specify this.
grades <- c("Bad", "Needs Improvement", "Needs Improvement", "Good", "Needs Improvement", "Bad", "Good", "Needs Improvement", "Good")
grades_factor <- factor(grades)
summary(grades_factor)

grades_factor <- factor(grades, ordered=TRUE, levels=c("Bad", "Needs Improvement", "Good"))
summary(grades_factor)
levels(grades_factor)

# If you give the categories in a factor a defined order, you can perform logical operations.
# The third element of grades_factor is "Needs Improvement," and the fourth element is "Good."
# Because we gave each level an order, "Needs Improvement" is seen as less than "Good."
grades_factor[3] > grades_factor[4]
# Likewise, the third element "Needs Improvement" is seen as more than the sixth element "Bad."
grades_factor[3] > grades[6]

##################################################

# Dataframes
##################################################
# Define vectors of different classes
days <- c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")
revenues <- c(0, 98, 0, 92, 94, 93, 0)
costs <- c(0, 24, 0, 22, 22, 23, 0)
type_of_day <- c("Weekend", "Workday", "Holiday", "Workday", "Workday", "Workday", "Weekend")

# Unlike matrices, the columns in dataframs can contain different datatypes
company <- data.frame(days, revenues, costs, type_of_day)
company

# You can use existing columns to creaate new columns
company$profits <- company$revenues - company$costs
company$workday <- with(company, ifelse(type_of_day == "Workday", TRUE, FALSE))
company

# The defaul R function to get a summary of a dataframe is str()
str(company)
# Within the dplyr library is an alternative function - glimpse
library(dplyr)
glimpse(company)

# We can use conditional statements to select a subset from dataframes
company$workday == TRUE & company$profits > 70
company[company$workday == TRUE & company$profits > 70, ]
# The same result can be achived using the subset() function
subset(company, workday==TRUE & profits>70)

##################################################

# Sequences
##################################################
# You can create sequences of numbers with the seq() function.
# You can specify the starting and ending number with the from= and to= arguments.
numbers <- seq(from = 1, to = 5)
numbers
numbers <- seq(1, 5)
numbers
numbers <- seq(from = 1, to = 10)
numbers
# Alternatively, you can use the syntax a:b,
# where a is the starting number, and b is the ending number.
numbers <- seq(1:7)
numbers
# When using the syntax a:b, the seq() is not necessary.
numbers <- 1:10
numbers
# The by= argument can be used to specify the step size.
numbers <- seq(1,10, by=2)
numbers
numbers <- seq(1, 10, by=0.2)
numbers
# The length.out argument can be used to specify a definite length.
numbers <- seq(1, 10, length.out=3)
numbers
numbers <- seq(1, 2, length.out=10)
numbers
# The along.with argument can be set to another vector,
# The resulting sequence will have the same length.
# NOTE: The corresponding vector need not be the same data type.
character_vector_of_length_7 <- c("this", "is", "not", "numeric", "this", "is", "character")
numeric_vector_of_length_7 <- seq(1, 5, along.with = character_vector_of_length_7)
numeric_vector_of_length_7
##################################################

# Repetitions
##################################################
# You can repeat any variable (including vectors, lists, or dataframes) with the rep() function,
# though possible with unintended side effects.
vector_of_fives <- rep(5, times=3)
vector_of_fives
vector_of_fives <- rep(5, 4)
vector_of_fives

list_of_things <- list(1:3, TRUE, FALSE, 4.5, 7)
list_of_things_repeated <- rep(list_of_things, 3)
list_of_things_repeated

dataframe_of_data <- data.frame(matrix(1:9, ncol=3, byrow=TRUE))
dataframe_of_data_repeated <- rep(dataframe_of_data, times = 2)
dataframe_of_data_repeated

# The length.out function can be used to specify the exact length;
# If repeating a vector or similar variable type,
# this may leave off a number of variables,
# in order to meet the specified length.
numbers <- c(1, 2, 3, 4, 5)
numbers_repeated <- rep(numbers, length.out = 20)
numbers_repeated
numbers_repeated <- rep(numbers, length.out = 13)
numbers_repeated

# If working with a vector or similar data type,
# You can use the each= argument to repeat each variable the specified number of times,
# before moving on to the next variable.
numbers_repeated <- rep(numbers, each=2)
numbers_repeated
numbers_repeated <- rep(numbers, times=3, each=4)
numbers_repeated
##################################################