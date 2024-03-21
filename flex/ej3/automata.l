/*** automata.l ***/

%{
    /* Descripcion
    Codificacion de un analizador léxico para simular 
    el funcionamiento de un coche
    */
%}

%x Q1 Q2

%%

"encender" { 
    BEGIN(Q1);
    fprintf(yyout, "Coche encendido\n");
}

<Q1>"acelerar" { 
    fprintf(yyout, "Acelerando... (Q1)\n");
    /* Se mantiene en Q1 */
}

<Q1>"frenar" { 
    fprintf(yyout, "Frenando... (Q1)\n");
    /* Se mantiene en Q1 */ 
}

<Q1>"apagar" {
    BEGIN(INITIAL);
    fprintf(yyout, "Coche apagado\n");
}

<Q1>"embragar" {
    fprintf(yyout, "Embragando... (Pasa a Q2)\n");
    BEGIN(Q2);
}

<Q2>"frenar" {
    fprintf(yyout, "Frenando... (Q2)\n");
    /* Se mantiene en Q2 */
}

<Q2>"cambiar" {
    fprintf(yyout, "Cambiando... (Pasa a Q1)\n");
    BEGIN(Q1);
}

.* { fprintf(yyout, "Orden no valida: %s\n", yytext); }

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

    return 0;
}