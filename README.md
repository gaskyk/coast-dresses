# Web scrape and analyse data about dresses on the Coast website

## Overview

There are two parts to this project:
- Web scrape information about dresses, their colour, price and availability from the [Coast website](https://www.coast-stores.com/)
- Analyse the results

## How do I use the project?

### Requirements/Pre-requisites

- For web scraping (*Web scraping Coast website.py*): Python 3.4 with libraries bs4, urllib.request and pandas
- For analysing results (*Analyse Coast dresses.R*): RStudio (version 0.99.451) with libraries ggplot2 and reshape2

### Project Structure

First run *Web scraping Coast website.py* to extract the data from the website.

If desired, add this data to the bottom of *Coast_dresses_all.csv* with the month it was scraped included.

Finally, run *Analyse Coast dresses.R* to see patterns in the dresses on this website. For example:

- Lowest stock levels are in dress sizes 6 and 14-18
- Pink dresses were popular in February 2016

### Data

*Coast_dresses_all.csv* shows the data scraped so far
