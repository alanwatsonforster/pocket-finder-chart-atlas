for svg in "$@"
do
    pdf=$(basename $svg .svg).pdf
    echo $pdf
    rsvg-convert $svg --format=pdf --output=$(dirname $svg)/$pdf
done
