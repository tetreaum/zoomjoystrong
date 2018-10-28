%{
	#include <stdio.h>
	int lineNum = 0;
%}

%option noyywrap

%%

end		{printf("END\n"); lineNum++;}
;		{printf("END_STATEMENT\n"); lineNum++;}
point		{printf("POINT\n"); lineNum++;}
line		{printf("LINE\n"); lineNum++;}
circle		{printf("CIRCLE\n"); lineNum++;}
rectangle	{printf("RECTANGLE\n"); lineNum++;}
setcolor	{printf("SET_COLOR\n"); lineNum++;}
[0-9]+		{printf("INTEGER\n"); lineNum++;}
[0-9]+\.[0-9]+	{printf("FLOATING_POINT\n"); lineNum++;}
[ \t\n]		; //Ignore these chars
.		{printf("Error on line %d: Token not found\n", lineNum); lineNum++;}

%%

int main(int argc, char** argv){
	yylex();
	return 0;
}
