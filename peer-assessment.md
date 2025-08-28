# Automate
## Running the entire analysis requires rendering one Quarto document
not yet- could not get quarto doc to render

## The analysis runs without errors
not yet- running into error in line 29, bisley_stream_head not found. I see it is specified in data_wrangling.R, but needs to be called from script.

## The analysis produces the expected output
not yet- it looks like the functions and code will run and produce the expected plot, just again can't see it yet. Error in gg plot, two geom_line() layers added

## Data import/cleaning is handled in its own script(s)

# Organize
## Raw data is contained in its own folder
Meets spec- raw data is in data folder

## Intermediate outputs are created and saved to a separate folder from raw data
Meets spec-clean data is in data folder

## At least one piece of functionality has been refactored into a function in its own file
Meets spec- moving average function is in separate script

# Document
## The repo has a README that explains where to find (1) data, (2) analysis script, (3) supporting code, and (4) outputs
Not yet- README is still being worked on

## The README includes a flowchart and text explaining how the analysis works
Not yet- README is still being worked on

## The code is appropriately commented
Meets spec- comments clearly state steps being taken during cleaning and analysis

## Variable and function names are descriptive and follow a consistent naming convention
Meets spec- variables and functions are appropriately named and consistent

#Scale
After cloning the repo on Workbench:

##  Running the environment initialization script installs all required packages
Not yet- does not have initialization script

## The analysis script runs without errors