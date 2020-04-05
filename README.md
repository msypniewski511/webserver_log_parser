# Webserver Log Parser

The script takes a log file and returns:
1. List of webpages with most page views ordered from most pages views to less page views
1. List of webpages with most unique page views also ordered
1. (Improvement) List of invalid entries

# Requirements

### Ruby version
Ruby 2.6.3

### Required gems
* Sequel
* Sqlite3

Test enviroment:
* RSpec
* FactoryBot
* Simplecov

# How to run
The script can be simply run from terminal with following command:
```bash
ruby parser.rb filename
```
Alternatively you can make the script file as executable:

```bash
chmod +x parser.rb
```
And run using command:
```bash
./parser.rb filename
```

# Features

### Unit tests
Starting from tests, the script test coverage is 100%. The whole test suite existis in the `/spec` folder. To run test you need to run command:
```bash
rspec
```
Afterwards the coverage report will be automatically generated in the `/coverage` folder and can be viewed in the browser by opening `index.html` file.

### Functionality
The script reads and parses provided text file and prints output. Attached `webserver.log` file produces 2 reports:

#### List of webpages with most page views ordered from most pages views to less page views
```bash
/about/2 90
/contact 89
/index 82
/about 81
/help_page/1 80
/home 78
```
#### List of webpages with most unique page views also ordered
```bash
/contact 23
/help_page/1 23
/home 23
/index 23
/about/2 22
/about 21
```
#### (Improvement) List of invalid entries
Based on Sequel model validations, the script validates if each log line contains 2 arguments. Invalid lines are also printed with notification:

```bash
Error: 'visitor_identifier is not present' in line: '/contact'
```

### Efficiency
The nature of the logic included in the script shows it requires operations like grouping, counting and ordering. Database processing is usually significantly faster with these statements than Ruby and scales very well, whereas Ruby's processing slowdown is proportional to the increase of the size of data.
Implemented solution is based on in memory Sqlite database and Sequel, a lightweight database toolkit for Ruby. The querying logic exists in the model Visit.

### Readability
The code readability is very important. It makes it easy, logical and clearly visible. It's critical for any sotware applications in terms of maintenance. The script was implemented with following steps:

* The script adopt RuboCop Style Guide. Ruby Guide standards of indentation and formatting are followed
* All methods operate on the same level of abstraction(Single Level of Abstraction Principle)
* Methods and variables are maningful
* Comments are present where needed

# What to improve

The script is not perfect. Implemented in a short time can be easily improved. Belows are the steps can be taken to make it better

### Validation
Each line of the `webserver.log` contains two string arguments separated by whitespace. Implemented validation checks only if both strings are present. The first string is a path and can be validated using regular expressions. The second string is not obvious because it is a numerlical label IP address like, however in the `webserver.log` there was not even one valid IP. Validating it requires more information about the nature of this numerical label.
Validation can be also improved to cover these cases:
* More than two arguments in the line or more than one whitespace
* Arguments are swapped

### Command line tool
Implemented basic CLI can be improved with additional switches which allow to for instance select report type, display help information, modify output format etc. Cli class can be refactored to encapsulate all messages in the separate class or yml file.
