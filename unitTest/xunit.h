// 單元測試方法(函數宣告)

/* File xunit.h */
#ifndef XUNIT_H
#define XUNIT_H

#include "../src/lib_c/globalDef.hpp"

#define XUnit(bool) ((bool == 1) ? "Pass" : "Fail")

bool XUnit_Assert_Int(int expected, int actual);

bool XUnit_Assert_IntArray(int expected[], int actual[], int size);

bool XUnit_Assert_Char(char expected[], char actual[], int size);

bool XUnit_Assert_String(char expected[], char actual[]);

void XUnit_Sample();

#endif /* xunit.h */
