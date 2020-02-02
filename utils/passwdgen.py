#!/usr/bin/env python3.7

import random

def NewPass():
    random.seed()
    charactersAllowed = list("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*-=_+ ")
    random.shuffle(charactersAllowed)
    passStr = ""
    for x in range(0,16):
        passStr += charactersAllowed[random.randint(0,len(charactersAllowed)-1)]
    return passStr

if __name__ == "__main__":
    print(f"\"{NewPass()}\"")
