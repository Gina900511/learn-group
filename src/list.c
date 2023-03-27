#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "list.h"

void List_Show(int arr[], int size, enum DirectionType dirType) {

    if(arr == NULL) {
        printf("[Warning]: Array is NULL");
        return;
    }

    switch (dirType) {

        case Vertical: {
            for (int i = 0; i < size; i++) {
                printf("Arr[%d] = %d\n", i, arr[i]);
            }
        } break;

        case Horizontal: {
            printf("Arr[]: ");
            for (int i = 0; i < size; i++) {
                printf("%d ", arr[i]);
            }
        } break;

        default: {
            printf("[Warning]: Unknown seqType: %d\n", dirType);
        } break;

    }

    puts("\n");
}

int* List_Create(int size, int initValue) {
    int *arr = (int*)malloc(sizeof(int) * size);
    List_Init(arr, size, initValue);
    return arr;
}

void List_Destroy(int *arr) {
    free(arr);
}

void List_Init(int arr[], int size, int defaultValue) {
    for (int i = 0; i < size; i++) {
        arr[i] = defaultValue;
    }
}

void List_Init_Increase(int arr[], int size, int startValue) {
    for (int i = 0, j = startValue; i < size; i++, j++) {
        arr[i] = j;
    }
}

void List_Init_Decrease(int arr[], int size, int startValue) {
    for (int i = 0, j = startValue; i < size; i++, j--) {
        arr[i] = j;
    }
}

void List_Init_Random(int arr[], int size, int min, int max) {
    srand(time(NULL));
    for (int i = 0; i < size; i++) {
        arr[i] = rand() % (max+1) + min;
    }
}

void List_Disrupted(int arr[], int size) {
    int tmp;
    srand(time(NULL));
    for (int i = 0; i < size; i++) { 
        int j = rand() % size;
        SWAP(arr[i], arr[j], tmp);
    }
}

void List_Invert(int arr[], int size) {
    int tmp;
    int count = (size % 2 == 0) ? size / 2 : (size / 2) + 1;
    for (int i = 0, j = size-1; i < count; i++, j--) {
        SWAP(arr[i], arr[j], tmp);
    }
}

int* List_Clone(int arr[], int size) {
    int *brr = List_Create(size, 0);
    if(brr == NULL) return NULL;

    for (int i = 0; i < size; i++) {
        brr[i] = arr[i];
    }
    return brr;
}

void List_Clear(int arr[], int size) {
    return List_Init(arr, size, 0);
}

// ==== Query ==========================

bool List_At(int arr[], int size, int idx, int *result_value) {

    // Check Argument
    if(idx < 0 || idx >= size) {
        *result_value = -1;
        printf("[Error]: Index >> Out of range!!!\n");
        printf("[Error-Info]: Exp >> Range( 0 ~ %d )\n", size-1);
        printf("[Error-Info]: Act >> idx: %d\n", idx);
        puts("\n");
        
        return false;
    }

    *result_value = arr[idx];
    return true;
}

int List_Find(int arr[], int size, int value) {

    for (int i = 0; i < size; i++) {
        if(value == arr[i]) {
            return i; // Found
        }
    }

    return -1; // Not found
}

int* List_Insert(int arr[], int *size, int idx, int value) {
    int newSize = *size + 1;
    int *brr = List_Create(newSize, 0);
    if (brr == NULL) return NULL;

    if(idx < 0 || idx >= *size) return NULL;

    for (int i = 0; i < idx; i++) {
        brr[i] = arr[i];
    }
    brr[idx] = value;
    for (int i = idx; i < *size; i++) {
        brr[i+1] = arr[i];
    }

    *size = newSize;
    return brr;
}

int* List_Append(int arr[], int *size, int value) {
    int newSize = *size + 1;
    int *brr = List_Create(newSize, 0);
    if (brr == NULL) return NULL;

    int i = 0;
    for (i = 0; i < *size; i++) {
        brr[i] = arr[i];
    }
    brr[i] = value;

    *size = newSize;
    return brr;
}

int* List_Remove_Value(int arr[], int *size, int value) {

    int idx = List_Find(arr, *size, value);
    if(idx == -1) return NULL;

    int newSize = *size - 1;
    int *brr = List_Remove_Index(arr, size, idx);
    if (brr == NULL) return NULL;

    return brr;
}

int* List_Remove_Index(int arr[], int *size, int idx) {

    if(idx < 0 || idx >= *size) return NULL;

    int newSize = *size - 1;
    int *brr = List_Create(newSize, 0);
    if (brr == NULL) return NULL;

    for (int i = 0, j = 0; i < *size; i++, j++) {
        if(i == idx) {
            j--;
            continue;
        }
        brr[j] = arr[i];
    }

    *size = newSize;
    return brr;
}

int* List_Join(int arr[], int a_size, int brr[], int b_size, int *result_size) {
    *result_size = a_size + b_size;
    int *crr = List_Create(*result_size, 0);
    if (crr == NULL) return NULL;

    int idx = 0;

    for (int i = 0; i < a_size; i++, idx++) {
        crr[idx] = arr[i];
    }
    for (int i = 0; i < b_size; i++, idx++) {
        crr[idx] = brr[i];
    }

    return crr;
}

// ==== Algorithm ======================

void List_Sort_BubbleSort(int arr[], int size, int seqType) {
    int tmp;
    for (int i = 0; i < size - 1; i++) {
        for (int j = 0; j < size - i - 1; j++) {
            switch (seqType) {

                case Increase: {
                    if(arr[j] >= arr[j+1]) 
                        SWAP(arr[j], arr[j+1], tmp);
                } break;

                case Decrease: {
                    if(arr[j] <= arr[j+1]) 
                        SWAP(arr[j], arr[j+1], tmp);
                } break;

                default: {
                    printf("[Warning]: Unknown seqType: %d\n", seqType);
                } break;

            }
        }
    }
}


// =====================================

bool At(int arr[], int size, int idx, int *result) {
    
    // Argument Checking
    if(idx < 0 || idx >= size) {
        printf("|> Error: Index out of range\n");
        *result = -1;
        return false;
    }
    
    *result = arr[idx];
    return true;
}

bool Find(int arr[], int size, int value, int *result) {

    //Argument Checking
    for( int i = 0; i < size ; i++){
        if(value == arr[i] ) {
            *result = i;
            return true;
        }
    }
    *result = -1 ;
    return false;
}

bool Remove(int arr[], int size, int idx) {
        // Argument Checking
    if(idx < 0 || idx >= size) {
        printf("|> Error: Index out of range\n");
        return false;
    }
    for (int j = idx ; j < size ; j++){
        arr[j]=arr[j+1];
    }
    return true;
}

bool Insert(int arr[], int size, int idx, int value) {
    // todo: 
    return false;
}

bool Append(int arr[], int size, int value) {
    // todo: 
    return false;
}

bool Invert(int arr[], int size) {
    // todo: 
    return false;
}

bool Join(int ori[], int ori_size, int join[], int join_size) {
    // todo: 
    return false;
}

bool Sort(int arr[], int size, int type) {
    // todo: 
    return false;
}
