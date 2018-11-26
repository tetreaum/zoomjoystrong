%{
    #include <stdio.h>
    #include "zjs.h"
    int yyerror(const char* s);
    int yylex();
%}

//void yyerror(const char *s);

%union {
    int intVal;
    float floatVal;
}

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token <intVal> INT
%token <floatVal> FLOAT
%%

program: expr_list END;

expr_list: expr
         | expr expr_list
         ;

expr: line
    | point
    | circle
    | rectangle
    | set_color
    ;

point: POINT INT INT END_STATEMENT {
    //Check to see if point is in range
    if($2 >= 0 && $2 <= WIDTH && $3 >=0 && $3 <= HEIGHT){
        point($2, $3);
    }
    else{
        printf("Point must be between (0, 0) and (%d, %d)", WIDTH, HEIGHT);
    }
};

line: LINE INT INT INT INT END_STATEMENT {
    //Check to see if line is in range 
    if($2 >= 0 && $2 <= WIDTH && $3 >=0 && $3 <= HEIGHT && $4 >= 0 && $4 <= WIDTH && $5 >= 0 && $5 <= HEIGHT){
        line($2, $3, $4, $5);
    }
    else{
        printf("Line must be between (0, 0) and (%d, %d)", WIDTH, HEIGHT);
    }
};

circle: CIRCLE INT INT INT END_STATEMENT {
    //Check to see if circle is in range
    if($2 >= 0 && $2 <= WIDTH && $3 >=0 && $3 <= HEIGHT && $4 >= 0){
        circle($2, $3, $4);
    }
    else{
        printf("Center of circle  must be between (0, 0) and (%d, %d), and the radius must be > than 0", WIDTH, HEIGHT);
    }
};

rectangle: RECTANGLE INT INT INT INT END_STATEMENT {
    //Check to see if rectangle is in range
    if($2 >= 0 && $2 <= WIDTH && $3 >=0 && $3 <= HEIGHT && $4 >= 0 && $4 <= WIDTH && $5 >= 0 && $5 <= HEIGHT){
        rectangle($2, $3, $4, $5);
    }
    else{
        printf("Top left edge and the width and height of rectangle must be between (0, 0) and (%d, %d)", WIDTH, HEIGHT);
    }
};

set_color: SET_COLOR INT INT INT END_STATEMENT {
   //Color values must be 0-255
   if($2 >= 0 && $2 <= 255 && $3 >= 0 && $3 <= 255 && $4 >= 0 && $4 <= 255){
        set_color($2, $3, $4);
   }
   else{
        printf("Color values must be between 0-255");
   }
};

%%

int run(int argc, char** argv){
    yyparse();
    return 0;
}

//http://www.gnu.org/software/bison/manual/html_node/Error-Reporting.html
int yyerror(const char* s){
    fprintf(stderr, "%s\n", s);
}
