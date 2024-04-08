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

%x Q1

%%

!!.* { fprintf(yyout, "Comentario de una linea reconocido --> %s\n\n", yytext); }

"<<" {
    yymore();
    BEGIN(Q1);
}

<Q1>[^">>"] {
    yymore();
}

<Q1>">"|"<" {
    yymore();
}

<Q1>">>" {
    yymore();
    BEGIN(INITIAL);
    fprintf(yyout, "Comentario multilinea reconocido con exito:\n%s\n\n", yytext);
}

inicio|INICIO { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, INICIO); }

fin|FIN { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, FIN); }

leer|LEER { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, LEER); }

escribir|ESCRIBIR { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, ESCRIBIR); }

si|SI { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, SI); }

entonces|ENTONCES { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, ENTONCES); }

si_no|SI_NO { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, SI_NO); }

fin_si|FIN_SI { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, FIN_SI); }

mientras|MIENTRAS { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, MIENTRAS); }

hacer|HACER { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, HACER); }

fin_mientras|FIN_MIENTRAS { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, FIN_MIENTRAS); }

repetir|REPETIR { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, REPETIR); }

hasta_que|HASTA_QUE { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, HASTA_QUE); }

para|PARA { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, PARA); }

desde|DESDE { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, DESDE); }

hasta|HASTA { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, HASTA); }

paso|PASO { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, PASO); }

fin_para|FIN_PARA { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, FIN_PARA); }

":=" { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, ASIGNACION); }

"+=" { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, ASIGNACIONSUMA); }

"-=" { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, ASIGNACIONRESTA); }

"*=" { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, ASIGNACIONPRODUCTO); }

"/=" { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, ASIGNACIONDIVISION); }

"+"  { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, SUMA); }

"++" { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, INCREMENTO); }

"-"  { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, RESTA); }

"--" { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, DECREMENTO); }

"*"  { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, PRODUCTO); }

"/"  { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, DIVISION); }

"//" { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, DIVISION_ENTERA); }

"%"  { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, MODULO); }

"**" { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, POTENCIA); }

"||" { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, CONCATENACION); }

"<"  { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, MENOR_QUE); }

"<=" { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, MENOR_IGUAL_QUE); }

">"  { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, MAYOR_QUE); }

">=" { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, MAYOR_IGUAL_QUE); }

"==" { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, IGUAL); }

"!=" { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, DISTINTO); }

"#o" { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, DISYUNCION_LOGICA); }

"#y" { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, CONJUNCION_LOGICA); }

"#no" { fprintf(yyout, "Operador reconococido --> '%s' (%d)\n\n", yytext, NEGACION_LOGICA); }

";" { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, FIN_SENTENCIA); }

"(" { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, PARENTESIS_IZQ); }

")" { fprintf(yyout, "Token reconococido --> '%s' (%d)\n\n", yytext, PARENTESIS_DER); }

{identificador} { fprintf(yyout, "Identificador reconococido --> '%s'\n\n", yytext); }

{numero} { fprintf(yyout, "Numero reconococido --> '%s'\n\n", yytext); }

{cadena} {
    /* Se elimina la comilla final */
    yytext[yyleng-1] = '\0';

    /* Se elimina la comilla inicial */
    yytext++;

    /* Se actualiza el tamaño de la cadena */
    yyleng--;

    /* Se ha reconocido una cadena */
    fprintf(yyout, "Cadena reconocida --> %s\n\n", yytext);
}

" "|[\t\n\n\r\f\v] { /* Ignorar los espacios en blanco */ }

[^{identificador}] { fprintf(yyout, "Error: Identificador no reconocido --> '%s'\n\n", yytext); }

[^{numero}] { fprintf(yyout, "Error: Numero no reconocido --> '%s'\n\n", yytext); }

[^{cadena}] { fprintf(yyout, "Error: Cadena no reconocido --> '%s'\n\n", yytext); }

. { fprintf(yyout, "Error: Caracter no reconocido --> %s\n\n", yytext); }

%%

extern FILE *yyin, *yyout;

int main(int argc, char **argv) {
    if(argc > 3 || argc < 1) {
        fprintf(yyout, "Error: Numero invalido de parametros. ");
        return -1;
    }

    switch(argc) {
        case 2: yyin = fopen(argv[1], "r"); break;
        case 3: yyin = fopen(argv[1], "r");
                yyout = fopen(argv[2], "w");
    }

    yylex();

    fclose(yyin);
    fclose(yyout);

    return 0;
}