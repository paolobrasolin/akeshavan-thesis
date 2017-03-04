#!/usr/bin/env bash

# Assuming this script is in the external/ folder, we check into it
#   so we can execute it from anywhere.
external_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $external_dir

# Remove trailing slash form the article folder.
article_name=${1%/}

# Locally build the article.
cd "$article_name/"
../authorea-scripts/local_build.py --no-build --flatten
cd $external_dir

# Move the output and clean up.
cp "$1/authorea_build/authorea_paper.tex" "$article_name.tex"
rm -rf "$1/authorea_build/"
