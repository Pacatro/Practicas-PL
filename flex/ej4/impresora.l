/*** impresora.l ***/

%{
    /*Descripcion
    Codificacion de un analizador lexico para simular
    el comportamiento de una impresora
    */

    #include <stdbool.h>
    #include <string.h>

    int cont_doc = 0;
    /*int total_docs = 0;*/

    bool es_bisiesto(int ano) {
        return (ano % 4 == 0 && ano % 100 != 0) || (ano % 400 == 0);
    }

    bool fecha_valida(int dia, int mes, int ano) {
        if (dia < 1 || dia > 31)
            return false;
        else if (mes < 1 || mes > 12)
            return false;
        else if (mes == 2 && dia == 29 && !es_bisiesto(ano))
            return false;

        return true;
    }

    bool hora_valida(int horas, int minutos) {
        if (horas < 0 || horas > 23)
            return false;
        else if (minutos < 0 || minutos > 59)
            return false;

        return true;
    }
%}

dia 0[1-9]|[1-2][0-9]|3[0-1]
mes 0[1-9]|1[0-2]
ano [0-9]{4}
horas 0[1-9]|1[0-9]|2[0-3]
minutos [0-5][0-9]
letra [a-zA-Z]

fecha {dia}\-{mes}\-{ano}
hora {horas}\:{minutos}
fichero .*\.{letra}{letra}*

formato {fecha}[ ]{hora}[ ]{fichero}

%x Q1 Q2

%%
{fecha} {
    int dia, mes, ano;
    sscanf(yytext, "%d-%d-%d", &dia, &mes, &ano);

    if (fecha_valida(dia, mes, ano)) {
        fprintf(yyout, "Fecha reconocida (Pasa a Q1)\n");
        BEGIN(Q1);
    } else {
        fprintf(yyout, "Fecha no valida: %s\n", yytext);
    }
}

<Q1>{hora} {
    int horas, minutos;
    sscanf(yytext, "%d:%d", &horas, &minutos);

    if (hora_valida(horas, minutos)) {
        fprintf(yyout, "Hora reconocida (Pasa a Q2)\n");
        BEGIN(Q2);
    } else {
        fprintf(yyout, "Hora no valida: %s\n", yytext);
    }
}

<Q2>{fichero}\n? {
    fprintf(yyout, "Fichero reconocido (Pasa a Q0)\n\n");
    cont_doc++;
    /*total_docs++;*/
    BEGIN(INITIAL);
}

[^0-9].*\n {
    fprintf(yyout, "Formato incorrecto: %s\n", yytext);
    /*total_docs++;*/
}

.|\n {}

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

    fprintf(yyout, "\nNumero de documentos enviados: %d\n", cont_doc);
    /*fprintf(yyout, "Numero total de documentos enviados: %d\n", total_docs);
    fprintf(yyout, "Numero medio de documentos enviados: %f\n", (float)cont_doc/total_docs);*/

    return 0;
}