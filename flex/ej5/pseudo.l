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

!!.* {
    /* fprintf(yyout, "Comentario de una linea reconocido "); */
}

"<<" {
    /* yymore(); */
    BEGIN(Q1);
}

<Q1>[^>>] {
    /* yymore(); */
}

<Q1>">>" {
    /* yymore(); */
    /* fprintf(yyout, "Comentario multilinea reconocido "); */
    BEGIN(INITIAL);
}

inicio {
    /* fprintf(yyout, "INICIO (%d) ", INICIO); */
}

fin {
    fprintf(yyout, "Analisis lexico finalizado con exito");
}

leer {
    /* fprintf(yyout, "LEER (%d) ", LEER); */
}

escribir {
    /* fprintf(yyout, "ESCRIBIR (%d) ", ESCRIBIR); */
}

si {
    /* fprintf(yyout, "SI (%d) ", SI); */
}

entonces {
    /* fprintf(yyout, "ENTONCES (%d) ", ENTONCES); */
}

si_no {
    /* fprintf(yyout, "SI_NO (%d) ", SI_NO); */
}

fin_si {
    /* fprintf(yyout, "FIN_SI (%d) ", FIN_SI); */
}

mientras {
    /* fprintf(yyout, "MIENTRAS (%d) ", MIENTRAS); */
}

hacer {
    /* fprintf(yyout, "HACER (%d) ", HACER); */
}

fin_mientras {
    /* fprintf(yyout, "FIN_MIENTRAS (%d) ", FIN_MIENTRAS); */
}

repetir {
    /* fprintf(yyout, "REPETIR (%d) ", REPETIR); */
}

hasta_que {
    /* fprintf(yyout, "HASTA_QUE (%d) ", HASTA_QUE); */
}

para {
    /* fprintf(yyout, "PARA (%d) ", PARA); */
}

desde {
    /* fprintf(yyout, "DESDE (%d) ", DESDE); */
}

hasta {
    /* fprintf(yyout, "HASTA (%d) ", HASTA); */
}

paso {
    /* fprintf(yyout, "PASO (%d) ", PASO); */
}

fin_para {
    /* fprintf(yyout, "FIN_PARA (%d) ", FIN_PARA); */
}

":=" {
    /* fprintf(yyout, "ASIGNACION (%d) ", ASIGNACION); */
}

"+=" {
    /* fprintf(yyout, "ASIGNACIONSUMA (%d) ", ASIGNACIONSUMA); */
}

"-=" {
    /* fprintf(yyout, "ASIGNACIONRESTA (%d) ", ASIGNACIONRESTA); */
}

"*=" {
    /* fprintf(yyout, "ASIGNACIONPRODUCTO (%d) ", ASIGNACIONPRODUCTO); */
}

"/=" {
    /* fprintf(yyout, "ASIGNACIONDIVISION (%d) ", ASIGNACIONDIVISION); */
}

"+"  {
    /* fprintf(yyout, "SUMA (%d) ", SUMA); */
}

"++" {
    /* fprintf(yyout, "INCREMENTO (%d) ", INCREMENTO); */
}

"-"  {
    /* fprintf(yyout, "RESTA (%d) ", RESTA); */
}

"--" {
    /* fprintf(yyout, "DECREMENTO (%d) ", DECREMENTO); */
}

"*"  {
    /* fprintf(yyout, "PRODUCTO (%d) ", PRODUCTO); */
}

"/"  {
    /* fprintf(yyout, "DIVISION (%d) ", DIVISION); */
}

"//" {
    /* fprintf(yyout, "DIVISION_ENTERA (%d) ", DIVISION_ENTERA); */
}

"%"  {
    /* fprintf(yyout, "MODULO (%d) ", MODULO); */
}

"**" {
    /* fprintf(yyout, "POTENCIA (%d) ", POTENCIA); */
}

"||" {
    /* fprintf(yyout, "CONCATENACION (%d) ", CONCATENACION); */
}

"<"  {
    /* fprintf(yyout, "MENOR_QUE (%d) ", MENOR_QUE); */
}

"<=" {
    /* fprintf(yyout, "MENOR_IGUAL_QUE (%d) ", MENOR_IGUAL_QUE); */
}

">"  {
    /* fprintf(yyout, "MAYOR_QUE (%d) ", MAYOR_QUE); */
}

">=" {
    /* fprintf(yyout, "MAYOR_IGUAL_QUE (%d) ", MAYOR_IGUAL_QUE); */
}

"==" {
    /* fprintf(yyout, "IGUAL (%d) ", IGUAL); */
}

"!=" {
    /* fprintf(yyout, "DISTINTO (%d) ", DISTINTO); */
}

"#o"  {
    /* fprintf(yyout, "DISYUNCION_LOGICA (%d) ", DISYUNCION_LOGICA); */
}

"#y"  {
    /* fprintf(yyout, "CONJUNCION_LOGICA (%d) ", CONJUNCION_LOGICA); */
}

"#no" {
    /* fprintf(yyout, "NEGACION_LOGICA (%d) ", NEGACION_LOGICA); */
}

";" {
    /* fprintf(yyout, "FIN_SENTENCIA (%d) ", FIN_SENTENCIA); */
}

"(" {
    /* fprintf(yyout, "PARENTESIS_IZQ (%d) ", PARENTESIS_IZQ); */
}

")" {
    /* fprintf(yyout, "PARENTESIS_DER (%d) ", PARENTESIS_DER); */
}

{identificador} {
    /* fprintf(yyout, "ID (%s) ", yytext); */
}

{numero} {
    /* fprintf(yyout, "Numero (%s) ", yytext); */
}

{cadena} {
    /* Se elimina la comilla final */
    yytext[yyleng-1] = '\0';

    /* Se elimina la comilla inicial */
    yytext++;

    /* Se actualiza el tamaño de la cadena */
    yyleng--;

    /* Se ha reconocido una cadena */
    /* fprintf(yyout, "Cadena reconocida: %s ", yytext); */
}

" " {
    /* Ignorar los espacios en blanco */
}

. {
    fprintf(yyout, "Error: Caracter no reconocido ('%s') en la linea %d\n", yytext, yylineno);
    return 0;
}

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

    return 0;
}