%{
    /*Descripcion
    Codificacion de un analizador lexico para simular
    un pseudocodigo*/

    #include "token.h"
%}

letra [a-zA-Z]
digito [0-9]

identificador {letra}({letra}|{digito}|\_({letra}|{digito}))*
numero {digito}+(\.{digito}+)?(E[+\-]?{digito}+)?
cadena \'([^'\\]|\\.)*\'

%%

{identificador} {
    printf("FURULA ID");
}

{numero} {
    printf("FURULA NUMERO");
}

{cadena} {
    /* Se elimina la comilla final */
    yytext[yyleng-1] = '\0';

    /* Se elimina la comilla inicial */
    yytext++;

    /* Se actualiza el tamaño de la cadena */
    yyleng--;

    /* Se ha reconocido una cadena */
    printf("\n Cadena reconocida (sin comillas exteriores)\n --> %s\n",yytext);
}

.* {
    printf("NO FURULA");
}

%%

extern FILE *yyin, *yyout;

int main(int argc, char **argv) {
    if(argc > 3 || argc < 1) {
        printf("Error: Numero invalido de parametros.\n");
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