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

