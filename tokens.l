D   [0-9]
L   [a-zA-Z_]

%{
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <ctype.h>
#include <string>

using namespace std;

vector<string> sym;
vector<string> str;
vector<string> chr;

int getIDIndex(char* text);

int getStrIndex(char* text);

int getChrIndex(char* text);
%}

%%

#include([^\n])*                    {}
\/\*(\s|.)*?\*\/                    { yylval.sIndex = getStrIndex(yytext); return(COMMENT); }
\/\/([^\n])*                        { yylval.sIndex = getStrIndex(yytext); return(COMMENT); }
"for"                               { return(FOR); }
"break"			                    { return(BREAK); }
"continue"                          { return(CONTINUE); }
"while"			                    { return(WHILE); }

"if"			                    { return(IF); }
"else"			                    { return(ELSE); }

"int"			                    { yylval.iType = intType; return(INT); }
"char"			                    { yylval.iType = charType; return(CHAR); }
"double"                            { yylval.iType = doubleType; return(DOUBLE); }
"return"		                    { return(RETURN); }
"printf"                            { return(PRINTF); }
"gets"                              { return(GETS); }
"strlen"                            { return(STRLEN); }
"strcmp"                            { return(STRCMP); }
"isdigit"                           { return(ISDIGIT); }

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

[ \t\n\r\v\f ]		                {}

.			                        { cout << "Unknown character" << endl; }

%%


int getIDIndex(char* text) {
    string textStr(text);
    int i = 0;
    int length = (int)sym.size();
    for (; i < length; i++) {
        if (sym[i] == text) {
            return i;
        }
    }
    sym.push_back(text);
    return length;
}

int getStrIndex(char* text) {
    string textStr(text);
    int length = (int)str.size();
    str.push_back(text);
    return length;
}

int getChrIndex(char* text) {
    string textStr(text);
    int i = 0;
    int length = (int)chr.size();
    for (; i < length; i++) {
        if (chr[i] == text) {
            return i;
        }
    }
    chr.push_back(text);
    return length;
}

int yywrap() {
    return 1;
}