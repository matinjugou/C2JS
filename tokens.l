D			[0-9]
L			[a-zA-Z_]

%{
#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <string>

#include "node.hpp"
#include "parser.hpp"

using namespace std;

// print the matched text
#define ECHO fwrite(yytext, yyleng, 1, yyout);

// store matched identifier in sym vector, return the index in vector
int getIDIndex(char *);

// store matched string in str vector, return the index in vector
int getStrIndex(char *);

// store matched character in chr vector, return the index in vector
int getChrIndex(char *);

vector<string> sym;
vector<string> str;
vector<string> chr;
%}

%%

#include([^\n])*                    {  }
\/\*(\s|.)*?\*\/                    { yylval.sIndex = getStrIndex(yytext); return(COMMENT); }
\/\/([^\n])*                        { yylval.sIndex = getStrIndex(yytext); return(COMMENT); }
"break"			                    { return(BREAK); }
"continue"                          { return(CONTINUE); }
"char"			                    { yylval.iType = charType; return(CHAR); }
"else"			                    { return(ELSE); }
"if"			                    { return(IF); }
"int"			                    { yylval.iType = intType; return(INT); }
"double"                            { yylval.iType = doubleType; return(DOUBLE); }
"return"		                    { return(RETURN); }
"while"			                    { return(WHILE); }
"printf"                            { return(PRINTF); }
"gets"                              { return(GETS); }
"strlen"                            { return(STRLEN); }
"strcmp"                            { return(STRCMP); }
"isdigit"                           { return(ISDIGIT); }
"for"                               { return(FOR); }

{L}({L}|{D})*		                { yylval.sIndex = getIDIndex(yytext); return(IDENTIFIER); }
{D}+		                        { yylval.iValue = atoi(yytext); return(INTEGER); }
'(\\.|[^\\'])+'	                    { yylval.sIndex = getChrIndex(yytext); return(CHARACTER); }
\"(\\.|[^\\"])*\"	                { yylval.sIndex = getStrIndex(yytext); return(STRING); }

{D}*"."{D}+                         { yylval.dValue = atof(yytext); return(DOUBLE_NUM); }
{D}+"."{D}*                         { yylval.dValue = atof(yytext); return(DOUBLE_NUM); }

"&&"			                    { return(AND_OP); }
"||"			                    { return(OR_OP); }
"=="			                    { return(EQ_OP); }
"!="			                    { return(NE_OP); }
"++"			                    { return(INC_OP); }
"--"			                    { return(DEC_OP); }
">="                                { return(GE_OP); }
"<="			                    { return(LE_OP); }
";"			                        { return(';'); }
"{"		                            { return('{'); }
"}"		                            { return('}'); }
"="			                        { return('='); }
"("			                        { return('('); }
")"			                        { return(')'); }
"["		                            { return('['); }
"]"		                            { return(']'); }
"-"			                        { return('-'); }
"+"			                        { return('+'); }
"*"                                 { return('*'); }
"/"                                 { return('/'); }
"<"			                        { return('<'); }
">"			                        { return('>'); }
","                                 { return(','); }
"!"                                 { return('!'); }

[ \t\n\r\v\f]		                {  }

.			                        { cout << "Unknown character" << endl; }

%%

int getStrIndex(char* text) {
    string textStr(text);

    str.push_back(textStr);

    return (int)str.size() - 1;
}

int getIDIndex(char* text) {
    int i = 0;
    string textStr(text);

    int sym_size = (int)sym.size();

    while (i < sym_size) {
        if (sym[i] != textStr) {
            i++;
        } else {
            return i;
        }
    }

    sym.push_back(textStr);

    return i;
}

int getChrIndex(char* text) {
    int i = 0;
    string textStr(text);

    int chr_size = (int)chr.size();

    while (i < chr_size) {
        if (chr[i] != textStr) {
            i++;
        } else {
            return i;
        }
    }

    chr.push_back(textStr);

    return i;
}

int yywrap()
{
    return 1;
}
