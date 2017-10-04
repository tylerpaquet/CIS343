#include <stdio.h>
#include <ctype.h>

int FillTable (int a[], int max);
void PrintReverseTable(int a[], int max);

int main()
{
    int max;
    printf("Enter the number of integers you want to store\n");
    scanf("%d", &max);
    int values[max];
    PrintReverseTable(values,  FillTable(values, max));
    return 0;
}

int FillTable (int a[], int max){
    int i, data;
    int arrayLength = 0;
    for(i = 0; i < max; i++){
        printf("Enter the next integer you want stored (enter a letter if you are done entering integers)\n");
        scanf("%d", &data);
        if(isalpha(getchar()))
        {
            break;
        }
        a[i] = data;
        arrayLength++;
    }
    printf("Length of the array is: %d\n", arrayLength);
    return arrayLength;
}

void PrintReverseTable(int a[], int max){
    int i;
    for(i = max; i >= 0 ; i--){
        printf("%d ", a[i]);
    }

}
