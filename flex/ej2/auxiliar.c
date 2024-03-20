#include <math.h>

#define PI 3.14159265358979323846

#include "token.h"

float calcDistancia(float x1, float y1, float x2, float y2) {
    return sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
}

float areaTriangulo(float x1, float y1, float x2, float y2, float x3, float y3) {
    return fabs((x1*(y2-y3) + x2*(y3-y1) + x3*(y2-y1)) / 2.0);
}

float areaCuadrado(float lado) {
    return lado*lado;
}

float areaCirculo(float r) {
    return 2*PI*r;
}