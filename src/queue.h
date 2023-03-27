/* File queue.h */
#ifndef QUEUE_H
#define QUEUE_H

#include "../src/globalDef.hpp"

struct Queue {
    int top;
    int *data; // data[]
    int size;
};

bool Queue_IsEmpty(struct Queue *q);

bool Queue_Pop(struct Queue *q);

bool Queue_Push(struct Queue *q);

void Show_Queue(struct Queue *q);

// Test:
void Queue_ToString();

#endif /* queue.h */