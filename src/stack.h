/* File stack.h */
#ifndef STACK_H
#define STACK_H

#include "../src/globalDef.hpp"

struct Stack {
    int top;
    int *data; // data[]
    int size;
};

bool Stack_IsEmpty(struct Stack *q);

bool Stack_Pop(struct Stack *q);

bool Stack_Push(struct Stack *q);

void Show_Stack(struct Stack *q);

// Test:
void Stack_ToString();

#endif /* stack.h */
