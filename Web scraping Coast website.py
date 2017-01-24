__author__ = 'Karen Gask'

# Use beautiful soup to look at web scraping dresses on Coast website
# Karen Gask
# 14/01/16

# Import packages
from bs4 import BeautifulSoup
from urllib.request import urlopen
import pandas as pd

# Print name, colour, price and stock availability of dress
# Input is a url
def print_price_sizes(url):
    r = urlopen(url).read()
    soup = BeautifulSoup(r)

    # Name
    name_tag = soup.find_all("h1")
    name = name_tag[0].get_text().title()

    # Colour
    colour_tag = soup.find_all("li", class_="selected")
    colour = colour_tag[0].find("span").get_text()
    print(name, "in", colour)

    # Price
    price_tag = soup.find_all("p", class_="product-price")
    price = price_tag[0].get_text().strip()[1:]
    print("Price:",price)

    # Sizes in stock
    in_stock = soup.find_all("li", class_="in-stock")
    size_in_stock = [i.find("span").get_text() for i in in_stock]
    size_in_stock = [''.join(c for c in s if c not in '\n') for s in size_in_stock]
    print("Sizes in stock:",size_in_stock)

    # Low stock
    low_stock = soup.find_all("li", class_="low-stock")
    size_low_stock = [i.find("span").get_text() for i in low_stock]
    size_low_stock = [''.join(c for c in s if c not in '\n') for s in size_low_stock]
    print("Sizes low in stock:",size_low_stock)

    # Sizes not in stock
    not_in_stock = soup.find_all("li", class_="no-stock")
    size_not_in_stock = [i.find("a").get_text() for i in not_in_stock]
    print("Sizes not in stock:",size_not_in_stock)

print_price_sizes('http://www.coast-stores.com/p/orsay-floral-midi-dress/1744098')

# Obtain url links of all dresses on website
r = urlopen('http://www.coast-stores.com/c/clothing/all-dresses').read()
soup = BeautifulSoup(r)
dress_url = soup.find_all("a","title")
links = [link["href"] for link in dress_url]

# Create dictionary of name, colour, price and stock availability of dress
# Input is a url
def price_sizes_to_dict(url):

    r = urlopen(url).read()
    soup = BeautifulSoup(r)

    # Name
    name_tag = soup.find_all("h1")
    name = name_tag[0].get_text().title()

    # Colour
    colour_tag = soup.find_all("li", class_="selected")
    colour = colour_tag[0].find("span").get_text()

    # Price
    price_tag = soup.find_all("p", class_="product-price")
    price = price_tag[0].get_text().strip()[1:]

    my_dict = {
        "Name": name,
        "Colour": colour,
        "Price": price
        }

    # Sizes in stock
    in_stock = soup.find_all("li", class_="in-stock")
    size_in_stock = [i.find("span").get_text() for i in in_stock]
    size_in_stock = [''.join(c for c in s if c not in '\n') for s in size_in_stock]

    # Low stock
    low_stock = soup.find_all("li", class_="low-stock")
    size_low_stock = [i.find("span").get_text() for i in low_stock]
    size_low_stock = [''.join(c for c in s if c not in '\n') for s in size_low_stock]

    # Sizes not in stock
    not_in_stock = soup.find_all("li", class_="no-stock")
    size_not_in_stock = [i.find("a").get_text() for i in not_in_stock]

    # Sizes
    strsize = 'size'
    sizes = ['6', '8', '10', '12', '14', '16', '18']
    for size in sizes:
        if size in size_in_stock:
            sizenow = 'in stock'
        elif size in size_low_stock:
            sizenow = 'low stock'
        else:
            sizenow = 'not in stock'
        my_dict[strsize+str(size)] = sizenow

    return my_dict

# Loop through links on Coast website to create dictionary for each dress
mydf = pd.DataFrame()
for link in links:
    dict = price_sizes_to_dict(link)
    df_kaz = pd.Series(dict)
    mydf = mydf.append(df_kaz, ignore_index=True)

# Save dataframe to csv
mydf.to_csv("C:/Users/ONS-BIG-DATA/Documents/Web scraping/Coast_dresses_Jan2017.csv", encoding='utf-8')