#!/usr/bin/env bash

set -euo pipefail

# Download rendered HTML from Wikisource
curl 'https://ws-export.wmcloud.org/?lang=en&page=Democracy+and+Social+Ethics&format=htmlz&fonts=&credits=false&images=false' >wikisource_export.zip
# Extract HTML file from download
unzip -p wikisource_export.zip index.html >wikisource.html
# Remove links from Wikisource HTML to reduce diff
sed -z -E -i 's/<a [^>]+>//g' wikisource.html
sed -z -E -i 's/<\/a>//g' wikisource.html
# Convert HTML files to Markdown
pandoc src/epub/text/body.xhtml --to gfm --out pg.md
pandoc wikisource.html --to gfm --out wikisource.md
# Remove residual HTML tags from Markdown
sed -z -E -i 's/<[^>]+>//g' pg.md wikisource.md
# Remove Markdown heading styling from Project Gutenberg
sed -E -i 's/^[#]+ //g' pg.md
# Auto-format Markdown to use a consistent style
prettier --write --prose-wrap never pg.md wikisource.md
