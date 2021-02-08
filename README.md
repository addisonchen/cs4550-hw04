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
  - does not evaluate if any characters are not a number or + - / *
    - all symbols and letters will cause you to not get an answer
  - checks for valid order
    - must start and end with a number
    - numbers must follow operators, and operators must follow numbers
  - fails softly
    - says "invalid input... ", server does not break

