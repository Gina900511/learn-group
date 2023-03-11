#include <stdio.h>
#include "Array_Func.h"

void Show_Array_RL(int arr[], int size) {
    for (int i=size; i>1; i--){
        printf ("%d " , arr[i]);
    }
};

void Show_Array_LR(int arr[], int size) {
    for(int i=0 ; i<size ; i++){
        printf("%d ", arr[i]);
    }
};