
/* File string.h */
#ifndef STRING_H
#define STRING_H

#define bool int
#define true 1
#define false 0

int String_Size(char str[]);

int String_Length(char str[]);

bool String_Find(char str[], char word[], int *result);

int String_Count(char str[], char word[]);

char* String_ToChar(const char str[]);

char* String_ToString(const char str[]);

#endif /* string.h */