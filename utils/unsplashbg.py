#!/usr/bin/env python3
"""Performs automatic Unsplash queries for a desktop wallpaper slideshow"""

import time
import sys
import os
import random
import requests

IMAGE_WIDTH = 3840
IMAGE_HEIGHT = 1080
TEXT_ENABLED = False

UNSPLASH_API = "https://api.unsplash.com/search/photos"

REQUEST_HEADERS = {"Accept-Version": "v1"}
REQUEST_PAYLOAD = {"per_page": 10, "orientation": "landscape"}

CROP_PARAMS = f"&fm=jpg&q=90&fit=crop&w={IMAGE_WIDTH}&h={IMAGE_HEIGHT}"
TEXT_PARAMS = "&txt-color=FFFFFF&txt-size=18&txt-shad=5&txt-pad=60"


def fetch_images(api_key: str, query: str, page_num: int):
    """Make Unsplash API request for image search results"""

    # prepare payload
    page_headers = REQUEST_HEADERS
    page_headers["Authorization"] = f"Client-ID {api_key}"

    page_params = REQUEST_PAYLOAD
    page_params["page"] = page_num
    page_params["query"] = query

    # make request
    result = requests.get(UNSPLASH_API, headers=page_headers, params=page_params)

    # handle API error
    if result.status_code != 200:
        print("unsplash API error:")
        print(result.json)
        return 1

    # parse JSON
    json = result.json()
    images = []
    try:
        for image in json["results"]:
            url = image["urls"]["raw"] + CROP_PARAMS
            if TEXT_ENABLED:
                url += f"&txt={query.upper()} ({page_num})" + TEXT_PARAMS
            images.append(url)
    except IndexError:
        return 1

    return images


def display_image(url: str):
    """Download image by URL to /tmp/unsplash_bg.jpg and set as background"""

    # download
    image = requests.get(url, stream=True)
    if image.status_code != 200:
        print("unsplash image error")
        print(image)
        return 1

    # save to /tmp/unsplash_bg.jpg
    with open("/tmp/unsplash_bg.jpg", "wb") as image_file:
        for chunk in image:
            image_file.write(chunk)

    # use gsettings to set as new background
    os.system(
        "/usr/bin/gsettings set org.gnome.desktop.background picture-uri /tmp/unsplash_bg.jpg"
    )
    return 0


def main():
    """Main controlling logic, handles command arguments"""
    api_key = ""
    interval = 60
    queries = []
    if len(sys.argv) < 3:
        print(
            "usage: ./unsplash-background.py <unsplash-api-key> <second-interval> [keywords]+"
        )
        sys.exit(1)
    else:
        try:
            api_key = str(sys.argv[1])
            interval = int(sys.argv[2])
            queries = [str(q) for q in sys.argv[3:]]
        except ValueError:
            print(
                "usage: ./unsplash-background.py <unsplash-api-key> <second-interval> [keywords]+"
            )
            sys.exit(1)
    page_num = 0
    while True:
        page_num += 1
        page_num = page_num if page_num < 4 else 1
        images = []
        for query in queries:
            search = None
            while True:
                # repeat request every 15 secs until 200 if error
                search = fetch_images(api_key, query, page_num)
                if search == 1:
                    time.sleep(15)
                else:
                    break
            images += search
        random.seed()
        random.shuffle(images)
        for image in images:
            if display_image(image) == 0:
                time.sleep(interval)


if __name__ == "__main__":
    main()
