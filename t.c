#include <stdio.h>

int fib(int);
void ask();
void bubble_sort(int n[], int c);
void qsort(int n[], int c);
typedef struct {
    int x;
    int y;
} Point;

typedef struct List{
    int a;
    struct List *l;
} List;

int main(int argc, char *argv[]) {
    List l2 = {20, NULL};
    List l1 = {10, &l2};

    printf("%d\n", (*l1.l).a);
}

#ifdef TEST
void test_sort(){
    int x[] = {1, 3, 2, 5, 2, 3, 6, 2, 4, 9, 1};
    int c = sizeof(x)/sizeof(x[0]);
    Point p = {10, 20};
    bubble_sort(x, c);
    printf("the sorted array: ");

    for(int i = 0; i < c; i++){
        printf("%d", x[i]);
    }
}
#endif

void ask() {
    int n;
    printf("input a number:");
    scanf("%d", &n);
    printf("result: %d", fib(n));
}

// fib
int fib(int a) {
    if(a < 2)
        return 1;
    else
        return fib(a -1) + fib(a - 2);
}

void bubble_sort(int n[], int c) {
    int tmp = 0;
    for (int j = 0; j < c; j++){
        for(int i = 0; i < c - j; i++){
            if(n[i] < n[i+1]) {
                tmp = n[i+1];
                n[i+1] = n[i];
                n[i] = tmp;
            }
        }
    }
}
