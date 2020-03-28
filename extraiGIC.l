%{
#include <stdio.h>
#include <stdlib.h>

%}

%x gram 

%%

	BEGIN 0;
	
[ \t\n\r] ;

\%\% BEGIN gram;

<gram>\%\% BEGIN 0;

<gram>\{.+\} ;

.+ ;

