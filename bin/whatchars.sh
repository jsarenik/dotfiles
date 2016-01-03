# Lists characters contained in a file
export LC_ALL=C
sed 's/./&\n/g' $1 | sort -u | sed -e :a -e '$!N; s/\n//; ta'
