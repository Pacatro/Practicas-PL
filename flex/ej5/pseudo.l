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
    fprintf(yyout, "Comentario de una linea reconocido");
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
    fprintf(yyout, "Comentario multilinea reconocido");
    BEGIN(INITIAL);
}

inicio {
    fprintf(yyout, "INICIO: %d\n", INICIO);
}

fin {
    fprintf(yyout, "FIN: %d\n", FIN);
}

leer {
    fprintf(yyout, "LEER: %d\n", LEER);
}

escribir {
    fprintf(yyout, "ESCRIBIR: %d\n", ESCRIBIR);
}

si {
    fprintf(yyout, "SI: %d\n", SI);
}

entonces {
    fprintf(yyout, "ENTONCES: %d\n", ENTONCES);
}

si_no {
    fprintf(yyout, "SI_NO: %d\n", SI_NO);
}

fin_si {
    fprintf(yyout, "FIN_SI: %d\n", FIN_SI);
}

mientras {
    fprintf(yyout, "MIENTRAS: %d\n", MIENTRAS);
}

hacer {
    fprintf(yyout, "HACER: %d\n", HACER);
}

fin_mientras {
    fprintf(yyout, "FIN_MIENTRAS: %d\n", FIN_MIENTRAS);
}

repetir {
    fprintf(yyout, "REPETIR: %d\n", REPETIR);
}

hasta_que {
    fprintf(yyout, "HASTA_QUE: %d\n", HASTA_QUE);
}

para {
    fprintf(yyout, "PARA: %d\n", PARA);
}

desde {
    fprintf(yyout, "DESDE: %d\n", DESDE);
}

hasta {
    fprintf(yyout, "HASTA: %d\n", HASTA);
}

paso {
    fprintf(yyout, "PASO: %d\n", PASO);
}

fin_para {
    fprintf(yyout, "FIN_PARA: %d\n", FIN_PARA);
}

":=" {
    fprintf(yyout, "ASIGNACION: %d\n", ASIGNACION);
}

"+=" {
    fprintf(yyout, "ASIGNACIONSUMA: %d\n", ASIGNACIONSUMA);
}

"-=" {
    fprintf(yyout, "ASIGNACIONRESTA: %d\n", ASIGNACIONRESTA);
}

"*=" {
    fprintf(yyout, "ASIGNACIONPRODUCTO: %d\n", ASIGNACIONPRODUCTO);
}

"/=" {
    fprintf(yyout, "ASIGNACIONDIVISION: %d\n", ASIGNACIONDIVISION);
}

"+"  {
    fprintf(yyout, "SUMA: %d\n", SUMA);
}

"++" {
    fprintf(yyout, "INCREMENTO: %d\n", INCREMENTO);
}

"-"  {
    fprintf(yyout, "RESTA: %d\n", RESTA);
}

"--" {
    fprintf(yyout, "DECREMENTO: %d\n", DECREMENTO);
}

"*"  {
    fprintf(yyout, "PRODUCTO: %d\n", PRODUCTO);
}

"/"  {
    fprintf(yyout, "DIVISION: %d\n", DIVISION);
}

"//" {
    fprintf(yyout, "DIVISION_ENTERA: %d\n", DIVISION_ENTERA);
}

"%"  {
    fprintf(yyout, "MODULO: %d\n", MODULO);
}

"**" {
    fprintf(yyout, "POTENCIA: %d\n", POTENCIA);
}

"||" {
    fprintf(yyout, "CONCATENACION: %d\n", CONCATENACION);
}

"<"  {
    fprintf(yyout, "MENOR_QUE: %d\n", MENOR_QUE);
}

"<=" {
    fprintf(yyout, "MENOR_IGUAL_QUE: %d\n", MENOR_IGUAL_QUE);
}

">"  {
    fprintf(yyout, "MAYOR_QUE: %d\n", MAYOR_QUE);
}

">=" {
    fprintf(yyout, "MAYOR_IGUAL_QUE: %d\n", MAYOR_IGUAL_QUE);
}

"==" {
    fprintf(yyout, "IGUAL: %d\n", IGUAL);
}

"!=" {
    fprintf(yyout, "DISTINTO: %d\n", DISTINTO);
}

"#o"  {
    fprintf(yyout, "DISYUNCION_LOGICA: %d\n", DISYUNCION_LOGICA);
}

"#y"  {
    fprintf(yyout, "CONJUNCION_LOGICA: %d\n", CONJUNCION_LOGICA);
}

"#no" {
    fprintf(yyout, "NEGACION_LOGICA: %d\n", NEGACION_LOGICA);
}

";" {
    fprintf(yyout, "FIN_SENTENCIA: %d\n", FIN_SENTENCIA);
}

"(" {
    fprintf(yyout, "PARENTESIS_IZQ: %d\n", PARENTESIS_IZQ);
}

")" {
    fprintf(yyout, "PARENTESIS_DER: %d\n", PARENTESIS_DER);
}

{identificador} {
    fprintf(yyout, "ID: %s\n", yytext);
}

{numero} {
    fprintf(yyout, "Numero: %s\n", yytext);
}

{cadena} {
    /* Se elimina la comilla final */
    yytext[yyleng-1] = '\0';

    /* Se elimina la comilla inicial */
    yytext++;

    /* Se actualiza el tamaño de la cadena */
    yyleng--;

    /* Se ha reconocido una cadena */
    fprintf(yyout, "\nCadena reconocida: %s\n", yytext);
}

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