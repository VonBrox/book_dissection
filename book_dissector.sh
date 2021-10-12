##Book dissector: Rips apart a text file book to examine it on a word-by-word basis.
##Before running, Set the book's name, e.g.
##BOOK=[book_name] (without the .txt extension)
#
#
##Get rid of most punctuation and paragraphs and split the book into single words on each line. Output this to [book_name]_words.txt
#
cat $BOOK".txt" | tr -d '[:punct:]'| sed -e 's/“//' -e 's/”//' -e 's/—//' -e '/^[[:space:]]*$/d' -e 's/\s/\n/g' | sed  '/^$/d' > $BOOK"_words.txt"
#
##Make a file where the words are sorted alphabetically
#
sort $BOOK"_words.txt" > $BOOK"_words_alpha.txt"
#
##Make a file where unique words are sorted by frequency and have number of occurrences listed beside them
#
uniq -c $BOOK"_words_alpha.txt" | sort -n > $BOOK"_words_freq.txt"
#
##Make a file where unique words are sorted by length
#
uniq $BOOK"_words_alpha.txt" | awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2- > $BOOK"_words_length.txt"
#
##Make a file with the 200 most frequent words with length of at least 6 (adjust numbers as needed)
#
grep -w '\w\{6,\}' $BOOK"_words_freq.txt" | tail -n 200 | tac > $BOOK"_words_top200_over6.txt"
