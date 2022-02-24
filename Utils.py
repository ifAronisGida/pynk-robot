from random import randrange

def parse_price(price):
    price_string = price[1:]
    return price_string

def randomize_price(price):
    random_multiplicator = randrange(95,105)
    price_length = len(price)
    randomized_price = (random_multiplicator * float(price)) / 100
    randomized_price_string = str(randomized_price)
    return randomized_price_string[:price_length]

def average_price(current_price, random_price):
    price_length = len(current_price)
    average = (float(current_price) + float(random_price)) / 2
    average_string = str(average)
    return average_string[:price_length]