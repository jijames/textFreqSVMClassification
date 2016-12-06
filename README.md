## Text Frequency Classification
A basic text analysis project used for creating email classification demos. Premise is that the frequency of particular words in a document can be used to classify its type. For example: spam / not spam.

### Contents
* createDictionary.sh - creates a numbered dictionary from all the words in all text (txt) documents in a directory (and all sub-directories)
* text2libsvm.sh - takes the text from a single text (txt) document and converts it into libsvm format. Requires a dictionary to be created. You can specify labels when creating the libsvm output.

### Process
1) Point createDictionary.sh at a directory full of text documents to generate "dictionary.dat"
2) Give a single text document and the dictionary to text2libsvm.sh, and it will create "text.libsvm"
3) Once you have combined all text documents in train and test data, scale each file with `svm-scale -l 0 text.libsvm > text.scaled`
4) Train your classifier with svm-train
5) Predict with svm-predict
