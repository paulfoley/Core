# run this from the logos dir to generate consistant thumbnails
mogrify -path ./thumbs -trim -resize 200x75 -background white -gravity center -extent 200x75 -border 15x15 -bordercolor white -format png ./originals/*
