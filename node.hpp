#pragma once

#include <fstream>
#include <iostream>
#include <vector>
#include <string>

using namespace std;

typedef enum { typeTyp, typeInt, typeDbl, typeChr, typeStr, typeId, typeOpr, typeEps,
                typeSta, typeLis, typeFun, typePar, typePrs, typePro } nodeEnum;

typedef enum { charType, intType, doubleType } typeEnum;

class nodeType
{
public:
    nodeEnum type;
};

class typNodeType : public nodeType
{
public:
    typeEnum value;                 
};

class intNodeType : public nodeType
{
public:
    int value;                      
};

class dblNodeType : public nodeType
{
public:
    double value;                      
};

class chrNodeType : public nodeType
{
public:
    int i;                           
};

class strNodeType : public nodeType
{
public:
    int i;                          
};

class idNodeType : public nodeType
{
public:
    int i;                          
};

class oprNodeType : public nodeType
{
public:
    int oper;                       
    int nops;                       
    vector<nodeType*> op;           
};

class epsNodeType : public nodeType
{
public:
    int neps;                       
    vector<nodeType*> ep;           
};

class staNodeType : public nodeType
{
public:
    int mark;                       
    int npts;                       
    vector<nodeType*> pt;           
};

class lisNodeType : public nodeType {
public:
    int nsts;                       
    vector<nodeType*> st;           
};

class funNodeType : public nodeType {
public:
    int npts;                       
    vector<nodeType*> pt;           
};

class proNodeType : public nodeType {
public:
    int nfns;                       
    vector<nodeType*> fn;           
};

class parNodeType : public nodeType {
public:
    int npts;                       
    vector<nodeType*> pt;           
};

class prsNodeType : public nodeType {
public:
    int npas;                      
    vector<nodeType*> pa;          
};

extern vector<string> sym;

extern vector<string> str;

extern vector<string> chr;

extern FILE *out_graph;

extern FILE *generated_code;

extern FILE *yyin;