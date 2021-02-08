## DESIGN DECISIONS ##

 - ## Palindrome ##
  - all strings are valid
  - checks for a palindrome made of numbers and letters ("a4a" is a palindrome)
  - ignores all symbols and white space ("a b$a" is a palindrome)

 - ## Factorization ##
  - Handles int and string inputs (for different kinds of tests)
  - Returns a list if input is an int
  - Joins the list into a string if input is a string

 - ## Arithmetic Expressions ##
  - Converts to postfix
  - evaluates with a postfix calculator
  - filters out all charachters that are not a number or a valid operation (+, -, /, *)
    - i.e.: "4 * ( 6 + 2 )" becomes "4 * 6 + 2" and evaluates to 26

