#!/usr/bin/env python3

import random
import sys
import requests

WORDLIST = requests.get("https://www.mit.edu/~ecprice/wordlist.10000").text.split("\n")
random.seed()
random.shuffle(WORDLIST)

def password():
    random_words = []
    for x in range(0,4):
        while True:
            random.seed()
            random_word = WORDLIST[random.randint(0, len(WORDLIST))]
            if len(random_word) > 6:
                random_words.append(random_word)
                break
    return " ".join(random_words)

if __name__ == "__main__":
    count = 1
    if len(sys.argv) > 1:
        if any(
                help_arg in sys.argv[1:]
                for help_arg in ["--help", "-help", "-h", "-?", "help", "h", "?"]
        ):
            print("Usage: ./passwdgen.py [count=1]")
            sys.exit(0)
        try:
            count = int(sys.argv[1])
        except ValueError:
            print("Supplied argument must be int [count]")
            sys.exit(1)
    print("Wordlist passwords:")
    for i in range(count):
        print(password())
