/* File globalDef.h */
#ifndef GLOBALDEF_H
#define GLOBALDEF_H

#define bool int
#define true 1
#define false 0
#define Boolean(bool) ((bool == 1) ? "true" : "false")

#define SWAP(x, y, t) ((t) = (x), (x) = (y), (y) = (t))


#endif /* globalDef.h */