#ifndef TOKEN_H
#define TOKEN_H

/* Palabras reservadas */ 
#define INICIO 257
#define FIN 258
#define LEER 259
#define ESCRIBIR 260
#define SI 261
#define ENTONCES 262
#define SI_NO 263
#define FIN_SI 264
#define MIENTRAS 265
#define HACER 266
#define FIN_MIENTRAS 267
#define REPETIR 268
#define HASTA_QUE 269
#define PARA 270
#define DESDE 271
#define HASTA 272
#define PASO 273
#define FIN_PARA 273

/* Operador de asignacion */
#define ASIGNACION 274 /* := */
#define ASIGNACIONSUMA 275 /* += */
#define ASIGNACIONRESTA 276 /* -= */
#define ASIGNACIONPRODUCTO 277 /* *= */
#define ASIGNACIONDIVISION 278 /* /= */

/* Operadores aritmeticos */
#define SUMA 279 /* + */
#define INCREMENTO 280 /* ++ */
#define RESTA 281 /* - */
#define DECREMENTO 282 /* -- */
#define PRODUCTO 283 /* * */
#define DIVISION 284 /* / */
#define DIVISION_ENTERA 285 /* // */
#define MODULO 286 /* % */
#define POTENCIA 287 /* ** */

/* Operador alfanumerico */
#define CONCATENACION 288 /* || */

/* Operadores relacionales de numeros y cadenas */
#define MENOR_QUE 289 /* < */
#define MENOR_IGUAL_QUE 290 /* <= */
#define MAYOR_QUE 291 /* > */
#define MAYOR_IGUAL_QUE 292 /* >= */
#define IGUAL 293 /* == */
#define DISTINTO 294 /* <> */

/* Operadores logicos */
#define DISYUNCION_LOGICA 295 /* #o */
#define CONJUNCION_LOGICA 296 /* #y */
#define NEGACION_LOGICA 297 /* #no */

/*
Comentario de una linea --> !! Comentario
Comentario de varias lineas --> << Comentario 
                                de varias lineas >>
*/

/* Otros componentes lexicos */
#define FIN_SENTENCIA 298 /* ; */
#define PARENTESIS_IZQ 299 /* ( */
#define PARENTESIS_DER 300 /* ) */

#endif