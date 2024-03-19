#!/bin/bash
[ ! -z $REVIEW_CONFIG_FILE ] || REVIEW_CONFIG_FILE=config-ebook.yml

# コマンド手打ちで作業したい時は以下の通り /book に pwd がマウントされます
# docker run -i -t -v $(pwd):/book vvakame/review:5.7 /bin/bash

docker run -t --rm -v $(pwd):/book vvakame/review:5.7 /bin/bash -ci "cd /book && ./setup.sh && REVIEW_CONFIG_FILE=config-ebook.yml npm run epub"
