#!/bin/bash

tmp=$(mktemp)
csstmp=$(mktemp)
echo '// Do not modify. Generated by '$0 > $tmp
echo '/* Do not modify. Generated by '$0' */' > $csstmp
echo 'var GENERATED = {}' >> $tmp
echo 'GENERATED.themes = [' >> $tmp

for file in $(cd less && ls -tr *.less | sed 's/.less//'); do
  lessc less/$file.less css/$file.css --verbose || exit $?
  echo '"codesearch-theme '$file'",' >> $tmp
  echo "/* BEGIN css/$file.css  */" >> $csstmp
  cat css/$file.css >> $csstmp
  echo "/* END css/$file.css  */" >> $csstmp
done;
echo '"" // original native theme' >> $tmp
echo '];' >> $tmp
mv $tmp js/generated.js
mv $csstmp css/generated.css
exit 0
