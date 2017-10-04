/*
 * Author:      Tyler Paquet
 * Assignment:  Programming Project Two in C
 * Due Date:    Monday, October 10, 2016
 */

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void processFile(int argc, char* argv[]);
int countLines(char argv[]);
char * checkForErrors(char line[], int fileLines);

int main(int argc, char* argv[])
{
    processFile(argc, argv);
}

void processFile(int argc, char* argv[])
{
    /* Author:
     * Purpose:
     * Inputs:
     * Outputs:
     * Error Handling:
     */

    FILE *fin, *fout;
    char line[100];
    char * pline = line;
    int fileLines;

    if(argc != 3)
    {
        printf("Must enter an input file and output file\n");
        exit(1);
    }

    fin = fopen(argv[1], "r");
    fout = fopen(argv[2], "w");

    fileLines = countLines(argv[1]);

    while(fgets(line, sizeof(line), fin))
    {
        fprintf(fout, "%s\n", line);
        fprintf(fout, "%s\n\n:", checkForErrors(pline, fileLines));
    }

    fclose(fin);
    fclose(fout);
}

int countLines(char argv[])
{
    /* Author:
     * Purpose:
     * Inputs:
     * Outputs:
     * Error Handling:
     */

    FILE *fin;
    char ch;
    int fileLines = 0;
    fin = fopen(argv, "r");

    while(!feof(fin))
    {
        ch = fgetc(fin);
        if(ch == '\n')
        {
            fileLines++;
        }
    }

    return fileLines;
}

char * checkForErrors(char line[], int fileLines)
{
    /* Author:
     * Purpose:
     * Inputs:
     * Outputs:
     * Error Handling:
     */

    if(line[0] != '*' && line[0] != ' ' && isalpha(line[0]) == 0) //checks for nonvalid char in col 1
    {
        return "Nonvalid character in column 1";
    }

    if(line[7] != ' ' || line[8] != ' ')  //check for spaces in column 8 and 9
    {
        return "Non-blank characters in columns 8 or 9";
    }

    if(line[9] == 'D')  //check for legal Opcode
    {
        char opCode[6];
        strncpy(opCode, line + 9, 6);

        if(strcmp(opCode, "DFHMDI") == 0 && strcmp(opCode, "DFHMDF") == 0 && strcmp(opCode, "DFHMSD") == 0)
        {
            return "Illegal Op-code";
        }

    }

   if(line[9] == 'E' && line[10] == 'N' && line[11] == 'D') //checks for END
   {
       int i;
       for(i = 12; line[i] != '\n'; i++)
       {
           if(line[i] != ' ')
           {
               return "Last line not just END in place of op code";
           }
       }
   }

    if(line[9] == ' ')
    {
        if(line[15] == ' ')
        {
            return "Operand in wrong column";
        }
    }

    if(line[0] != '*' && line[9] != 'D')
    {
        int count = 0;
        int i;

        for(i = 15; line[i] != '='; i++)
        {
            count++;
            if(count > 7)
            {
                return "Label too long";
            }
        }
    }

    return "There is no erros on this line";
}

