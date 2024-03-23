/*** impresora.l ***/

%{
    /*Descripcion
    Codificacion de un analizador lexico para simular
    el comportamiento de una impresora
    */
%}

digito [0-9]
letra [a-zA-Z]
fichero .*\.{letra}{letra}*

fecha {digito}{digito}\-{digito}{digito}\-{digito}{digito}{digito}{digito}[ ]{digito}{digito}\:{digito}{digito}[ ]{fichero}

%%
{fecha} { printf("Es una fecha\n"); }
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