#include <stdio.h>
#include "xunit.h"

bool XUnit_Assert_Int(int expected, int actual) {
    return (expected == actual);
}

bool XUnit_Assert_IntArray(int expected[], int actual[], int size) {
    for (int i = 0; i < size; i++) {
        if(expected[i] != actual[i]) {
            return false;
        }
    }
    
    return true;
}

bool XUnit_Assert_Char(char expected[], char actual[], int size) {
    for (int i = 0; i < size; i++) {
        if(expected[i] != actual[i]) {
            return false;
        }
    }
    
    return true;
}

bool XUnit_Assert_String(char expected[], char actual[]) {
    int idx = 0;
    while(expected[idx] != '\0') {
        if(expected[idx] != actual[idx]) {
            return false;
        }
        idx++;
    }
    
    return true;
}

void XUnit_Sample() {

    // Test exchange t1 and t2's value
    int t1 = 10;
    int t2 = 5;
    int tmp;
    SWAP(t1, t2, tmp);
    printf("Int: %s\n", XUnit(XUnit_Assert_Int(t1, 5))); // We expected t1 equ to 5

    int arrT1[] = { 0, 1, 2, 3, 4, 5 };
    int arrT2[] = { 0, 1, 2, 3, 4, 5 };
    printf("IntArray: %s\n", XUnit(XUnit_Assert_IntArray(arrT1, arrT2, 6)));

    char strT1[] = "Hello world!";
    char strT2[] = "Hello";
    printf("String: %s\n", XUnit(XUnit_Assert_String(strT1, strT2)));

}
