/*** figura.l ***/

%{
    /* Descripcion
    El analizador distingue si una figura geometrica
    es un triangulo, cuadrado o circulo 
    y calcula su perimetro y area
    */

    #include <stdio.h>
    #include <string.h>
    #include "token.h"

    #define PI 3.14159265358979323846

    float x1, y1, x2, y2, x3, y3, r;
    int cont = 0;
%}

digito [0-9]
numero {digito}+(\.{digito}+)?(E[+\-]?{digito}+)?

triangulo tri(a|á)ngulo[ ]\({numero}[ ]{numero}\)[ ]\({numero}[ ]{numero}\)[ ]\({numero}[ ]{numero}\)
cuadrado cuadrado[ ]\({numero}[ ]{numero}\)[ ]\({numero}[ ]{numero}\)
circulo c(i|í)rculo[ ]\({numero}[ ]{numero}\)[ ]{numero}

%%
{triangulo} {
    cont++;

    fprintf(yyout, "Figura reconocida -> %s\n", yytext); 
    
    if(sscanf(yytext, "triángulo (%f %f) (%f %f) (%f %f)", &x1, &y1, &x2, &y2, &x3, &y3) == 0) {
        sscanf(yytext, "triangulo (%f %f) (%f %f) (%f %f)", &x1, &y1, &x2, &y2, &x3, &y3);
    }

    float lado1 = calcDistancia(x1, y1, x2, y2);
    float lado2 = calcDistancia(x2, y2, x3, y3);
    float lado3 = calcDistancia(x3, y3, x1, y1);

    float perimetro = lado1 + lado2 + lado3;

    fprintf(yyout, "Perimetro: %f\n", perimetro);

    float area = areaTriangulo(x1, y1, x2, y2, x3, y3);

    fprintf(yyout, "Area: %f\n", area);
}

{cuadrado} {
    cont++;

    fprintf(yyout, "Figura reconocida -> %s\n", yytext);

    sscanf(yytext, "cuadrado (%f %f) (%f %f)", &x1, &y1, &x2, &y2);

    float lado = calcDistancia(x1, y1, x2, y2);

    float perimetro = 4.0*lado;

    fprintf(yyout, "Perimetro: %f\n", perimetro);

    float area = areaCuadrado(lado);

    fprintf(yyout, "Area: %f\n", area);
}

{circulo} {
    cont++;

    fprintf(yyout, "Figura reconocida -> %s\n", yytext);

    if(sscanf(yytext, "círculo (%f %f) %f", &x1, &y1, &r) == 0) {
        sscanf(yytext, "circulo (%f %f) %f", &x1, &y1, &r);
    }

    float perimetro = PI * (r*r);

    fprintf(yyout, "Perimetro: %f\n", perimetro);

    float area = areaCirculo(r);

    fprintf(yyout, "Area: %f\n", area);

}

\# { fprintf(yyout, "%d figuras reconocidas\n", cont); return 0; }

.* { fprintf(yyout, "Error: Figura no reconocida -> %s\n", yytext); }

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