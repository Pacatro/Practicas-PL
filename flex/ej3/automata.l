/*** automata.l ***/

%{
    /* Descripcion
    Codificacion de un analizador léxico para simular 
    el funcionamiento de un coche
    */
%}

%x Q0 Q1 Q2

%%

%%

extern FILE *yyin, *yyout;

int main(int argc, char **argv) {
    if(argc > 3 || argc < 1) {
        fprintf(yyout, "Error: Numero invalido de parametros.\n");
        return -1;
    }

    switch(argc) {
        case 2: yyin = fopen(argv[1], "r"); break;
        case 3: yyin = fopen(argv[1], "r");
                yyout = fopen(argv[2], "w");
    }

    yylex();

    fprintf(yyout, "\n%d figuras reconocidas\n", cont);

    return 0;
}