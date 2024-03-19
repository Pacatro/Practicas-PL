/*** correo.l ***/

%{
    /* Descripcion
    El analizador distingue si una cadena 
    es un correo electronico o no    
    Ejemplo: usuario@entidad.ext
    */
%}

letra [a-zA-Z]
numero [0-9]
simbolo [\.\_{0,1}]

/* Empieza por una letra, sigue por varias letras o numeros o simbolos, 
/* pero que _ solo aparezca , termina con una letra o un numero */
usuario {letra}({letra}|{numero}|{simbolo})*({letra}|{numero})
/* Empiza por una letra y le siguen cero o mas letras */
entidad {letra}({letra})*
/* Empiza por una o tres letra */
ext {letra}{1,3}
email {usuario}\@{entidad}\.{ext}

%%

{email}    { printf("%s es un email valido\n", yytext); }

.          { printf("No es un email valido\n"); }

%%

int main() {
    yylex();
    return 0;
}