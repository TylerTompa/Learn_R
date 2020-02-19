# The class() function
##################################################
# You can check the class of a variable with the class() function

# R does not differentiate between integers and decinals;
# to R they are both just numeric
integer <- 4
class(integer)

decimal <- 4.5
class(decimal)

character <- "4"
class(character)

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

logical <- TRUE
class(logical)

##################################################

# Factors
##################################################
# Factors are a data type used to store repetitive categorical data
# You can create a factor with factor() function with the factor elements,
# or by converting an existing vector to a factor
grades <- c("B", "NI", "NI", "G", "NI", "B", "G", "NI", "G")
grades_factor <- factor(grades)
class(grades)
grades
# You can then use the summary() function for a summary of the levels that make up the factor
summary(grades_factor)

# You can use the levels function to see each distinct category, or "level," within a factor.
# WARNING: The order with which you assign levels is important.
# If you don't specify levels manually, R will automatically assign levels aphabetically
# So when assigning levels, they should be assigned alphabetically, not in their natural order.
# Compare the following assignments:
levels(grades_factor) <- c("Bad", "Needs Improvement", "Good")
summary(grades_factor)

levels(grades_factor) <- c("Bad", "Good", "Needs Improvement")
summary(grades_factor)
# In this example, R has assigned the level "Fast" to any element 

# In some cases, certain categories are "better" than others, as in this example.
# The "ordered" argument can be set to TRUE to specify this
grades <- c("Bad", "Needs Improvement", "Needs Improvement", "Good", "Needs Improvement", "Bad", "Good", "Needs Improvement", "Good")
grades_factor <- factor(grades, ordered=TRUE, levels=c("Bad", "Needs Improvement", "Good"))
summary(grades_factor)
levels(grades_factor)

##################################################

# Sequences
##################################################
# You can create sequences of numbers with the seq() function
# You can specify the starting and ending number with the from= and to= arguments
numbers <- seq(from = 1, to = 5)
numbers
numbers <- seq(1, 5)
numbers
numbers <- seq(from = 1, to = 10)
numbers
# Alternatively, you can use the syntax a:b,
# where a is the starting number, and b is the ending number
numbers <- seq(1:7)
numbers
# When using the syntax a:b, the seq() is not necessary
numbers <- 1:10
numbers
# The by= argument can be used to specify the step size
numbers <- seq(1,10, by=2)
numbers
numbers <- seq(1, 10, by=0.2)
numbers
# The length.out argument can be used to specify a definite length
numbers <- seq(1, 10, length.out=3)
numbers
numbers <- seq(1, 2, length.out=10)
numbers
# The along.with argument can be set to another vector,
# The resulting sequence will have the same length
# NOTE: The corresponding vector need not be the same data type
character_vector_of_length_7 <- c("this", "is", "not", "numeric", "this", "is", "character")
numeric_vector_of_length_7 <- seq(1, 5, along.with = character_vector_of_length_7)
numeric_vector_of_length_7
##################################################

# Repetitions
##################################################
# You can repeat any variable (including vectors, lists, or dataframes) with the rep() function,
# though possible with unintended side effects
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
# in order to meet the specified length
numbers <- c(1, 2, 3, 4, 5)
numbers_repeated <- rep(numbers, length.out = 20)
numbers_repeated
numbers_repeated <- rep(numbers, length.out = 13)
numbers_repeated

# If working with a vector or similar data type,
# You can use the each= argument to repeat each variable the specified number of times,
# before moving on to the next variable
numbers_repeated <- rep(numbers, each=2)
numbers_repeated
numbers_repeated <- rep(numbers, times=3, each=4)
numbers_repeated
##################################################


