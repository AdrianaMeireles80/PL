# PL

## How to Compile ?
`extraiGIC.l`
flex extraiGIC.l

gcc -o extra.exe lex.yy.c -ll

./extra.exe f.y

`lengen.l`

flex lengen.l

gcc -o gen.exe lex.yy.c -ll

./gen.exe f.y

cat output.txt
