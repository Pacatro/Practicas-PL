/*** correo.l ***/

%{
    /* Descripcion
    El analizador distingue si una cadena 
    es un correo electronico o no    
    Ejemplo: usuario@entidad.ext
    */
    int cont = 0;
%}

letra [a-zA-Z]
numero [0-9]
simbolo [\.\_?]

usuario {letra}({letra}|{numero}|{simbolo})*({letra}|{numero})
entidad {letra}{letra}*
ext {letra}{1,3}

correo {usuario}@{entidad}.{ext}

%%

{correo}    { cont++; printf("%s es un correo valido\n", yytext); }

.*          { printf("%s no es un correo valido\n", yytext); }

%%

extern FILE *yyin, *yyout;

int main(int argc, char **argv) {
    if(argc > 3 || argc < 2) {
        printf("Error: Numero invalido de paramtros.\n");
        return -1;
    }

    switch(argc) {
        case 2: yyin = fopen(argv[1], "r"); break;
        case 3: yyin = fopen(argv[1], "r");
                yyout = fopen(argv[2], "w");
    }

    yylex();

    printf("\nNumero de correos validos: %d\n", cont);

    return 0;
}