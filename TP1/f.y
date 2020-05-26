....
%union ....
%token ID MKLISTA NULA
%type ....
%%
lista : MKLISTA '(' ids ')' { ... ação semântica em C }
| NULA
;
ids : ID ',' ids { ignorar as constantes char (ex: '!') das ações semânticas }

| ID 'a'{batatas}'b' { if ( ... == 'a') { ... } else { ...} }
;
%%
... codigo C...
