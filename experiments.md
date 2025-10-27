# All Experiments

## EXP1: Array Operations

### array.h
```c
#ifndef ARRAY_H
#define ARRAY_H

#include <stdio.h>

typedef struct {
    int arr[100];
    int n;
} Array;

static void initArray(Array* a) {
    printf("Size & elems: ");
    scanf("%d", &a->n);
    for (int i = 0; i < a->n; i++) scanf("%d", &a->arr[i]);
}

static void displayArray(Array* a) {
    for (int i = 0; i < a->n; i++) printf("%d ", a->arr[i]);
    printf("\n");
}

static void swap(int* a, int* b) {
    int temp = *a; *a = *b; *b = temp;
}

#endif
```

### exp1.c
```c
#include "array.h"
#include <stdio.h>

void insert(Array* a, int x) {
    if (a->n >= 100) return;
    a->arr[a->n++] = x;
}

void delete(Array* a) {
    if (a->n <= 0) return;
    a->n--;
}

int main() {
    Array a;
    int ch, x;
    initArray(&a);

    do {
        printf("\n1.Ins 2.Del 3.Disp 4.Exit\n> ");
        scanf("%d", &ch);
        switch (ch) {
            case 1: printf("Elem: "); scanf("%d", &x); insert(&a, x); break;
            case 2: delete(&a); break;
            case 3: displayArray(&a); break;
        }
    } while (ch != 4);
    return 0;
}
```

## EXP2: Matrix Multiplication

### exp2.c
```c
#include <stdio.h>

typedef struct {
    int mat[2][2];
} Matrix;

void readMatrix(Matrix* m) {
    for (int i = 0; i < 2; i++)
        for (int j = 0; j < 2; j++)
            scanf("%d", &m->mat[i][j]);
}

void displayMatrix(Matrix* m) {
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) printf("%d\t", m->mat[i][j]);
        printf("\n");
    }
}

void multiply(Matrix* m1, Matrix* m2, Matrix* res) {
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            res->mat[i][j] = 0;
            for (int k = 0; k < 2; k++) {
                res->mat[i][j] += m1->mat[i][k] * m2->mat[k][j];
            }
        }
    }
}

int main() {
    Matrix m1, m2, res;
    printf("Matrix 1:\n"); readMatrix(&m1);
    printf("Matrix 2:\n"); readMatrix(&m2);
    
    multiply(&m1, &m2, &res);
    
    printf("Result:\n"); 
    displayMatrix(&res);
    
    return 0;
}
```

## EXP3: Stack

### exp3.c
```c
#include <stdio.h>

#define MAX 100
int stack[MAX], top = -1;

void push(int x) {
    if (top >= MAX - 1) printf("Overflow\n");
    else stack[++top] = x;
}

void pop() {
    if (top < 0) printf("Underflow\n");
    else printf("Popped %d\n", stack[top--]);
}

void display() {
    if (top < 0) { printf("Empty\n"); return; }
    for (int i = top; i >= 0; i--) printf("%d ", stack[i]);
    printf("\n");
}

int main() {
    int ch, x;
    do {
        printf("\n1.Push 2.Pop 3.Disp 4.Exit\n> ");
        scanf("%d", &ch);
        switch (ch) {
            case 1: printf("Val: "); scanf("%d", &x); push(x); break;
            case 2: pop(); break;
            case 3: display(); break;
        }
    } while (ch != 4);
    return 0;
}
```

## EXP4: Factorial

### exp4.c
```c
#include <stdio.h>

long long fact(int n) {
    return (n >= 1) ? n * fact(n - 1) : 1;
}

int main() {
    int n;
    printf("Enter num: ");
    scanf("%d", &n);
    if (n < 0) printf("No fact for neg nums\n");
    else printf("Fact of %d is %lld\n", n, fact(n));
    return 0;
}
```

## EXP5: Queue

### exp5.c
```c
#include <stdio.h>

#define MAX 50
int queue[MAX], rear = -1, front = -1;

void enq(int item) {
    if (rear == MAX - 1) { printf("Overflow\n"); return; }
    if (front == -1) front = 0;
    queue[++rear] = item;
}

void dequeue() {
    if (front == -1 || front > rear) { printf("Underflow\n"); return; }
    printf("Dequed %d\n", queue[front++]);
}

void display() {
    if (front == -1 || front > rear) { printf("Empty\n"); return; }
    for (int i = front; i <= rear; i++) printf("%d ", queue[i]);
    printf("\n");
}

int main() {
    int ch, x;
    do {
        printf("\n1.Enq 2.Deq 3.Disp 4.Exit\n> ");
        scanf("%d", &ch);
        switch (ch) {
            case 1: printf("Val: "); scanf("%d", &x); enq(x); break;
            case 2: dequeue(); break;
            case 3: display(); break;
        }
    } while (ch != 4);
    return 0;
}
```

## EXP6: Circular Queue

### exp6.c
```c
#include <stdio.h>

#define SIZE 5
int items[SIZE], front = -1, rear = -1;

int isFull() { return (front == 0 && rear == SIZE - 1) || (front == rear + 1); }
int isEmpty() { return front == -1; }

void enq(int element) {
    if (isFull()) { printf("Full\n"); return; }
    if (front == -1) front = 0;
    rear = (rear + 1) % SIZE;
    items[rear] = element;
}

int deQueue() {
    if (isEmpty()) { printf("Empty\n"); return -1; }
    int element = items[front];
    if (front == rear) front = rear = -1;
    else front = (front + 1) % SIZE;
    printf("Deleted %d\n", element);
    return element;
}

void display() {
    if (isEmpty()) { printf("Empty\n"); return; }
    int i;
    for (i = front; i != rear; i = (i + 1) % SIZE) printf("%d ", items[i]);
    printf("%d\n", items[i]);
}

int main() {
    int ch, x;
     do {
        printf("\n1.Enq 2.Deq 3.Disp 4.Exit\n> ");
        scanf("%d", &ch);
        switch (ch) {
            case 1: printf("Val: "); scanf("%d", &x); enq(x); break;
            case 2: deQueue(); break;
            case 3: display(); break;
        }
    } while (ch != 4);
    return 0;
}
```

## EXP7: Binary Search Tree

### exp7.c
```c
#include <stdio.h>
#include <stdlib.h>

struct node {
    int key;
    struct node *left, *right;
};

struct node* newNode(int item) {
    struct node* temp = (struct node*)malloc(sizeof(struct node));
    temp->key = item;
    temp->left = temp->right = NULL;
    return temp;
}

void inorder(struct node* root) {
    if (root != NULL) {
        inorder(root->left);
        printf("%d ", root->key);
        inorder(root->right);
    }
}

struct node* insert(struct node* node, int key) {
    if (node == NULL) return newNode(key);
    if (key < node->key) node->left = insert(node->left, key);
    else if (key > node->key) node->right = insert(node->right, key);
    return node;
}

int main() {
    struct node* root = NULL;
    int n, key;
    printf("Num of nodes & keys: ");
    scanf("%d", &n);
    for(int i=0; i<n; i++){
        scanf("%d", &key);
        root = insert(root, key);
    }
    printf("Inorder: ");
    inorder(root);
    printf("\n");
    return 0;
}
```

## EXP8: Binary Search

### exp8.c
```c
#include "array.h"
#include <stdio.h>

int binarySearch(Array* a, int x) {
    int l = 0, r = a->n - 1;
    while (l <= r) {
        int m = l + (r - l) / 2;
        if (a->arr[m] == x) return m;
        if (a->arr[m] < x) l = m + 1;
        else r = m - 1;
    }
    return -1;
}

int main(void) {
    Array a;
    int x;
    initArray(&a);
    
    printf("Elem to search: ");
    scanf("%d", &x);
    
    int result = binarySearch(&a, x);
    if (result == -1) printf("Not found\n");
    else printf("Found at index %d\n", result);
    return 0;
}
```

## EXP9: Bubble Sort

### exp9.c
```c
#include "array.h"
#include <stdio.h>

void bubbleSort(Array* a) {
    for (int i = 0; i < a->n - 1; i++)
        for (int j = 0; j < a->n - i - 1; j++)
            if (a->arr[j] > a->arr[j + 1])
                swap(&a->arr[j], &a->arr[j + 1]);
}

int main() {
    Array a;
    initArray(&a);
    bubbleSort(&a);
    printf("Sorted: ");
    displayArray(&a);
    return 0;
}
```

## EXP10: Insertion Sort

### exp10.c
```c
#include "array.h"
#include <stdio.h>

void insertionSort(Array* a) {
    int i, key, j;
    for (i = 1; i < a->n; i++) {
        key = a->arr[i];
        j = i - 1;
        while (j >= 0 && a->arr[j] > key) {
            a->arr[j + 1] = a->arr[j];
            j = j - 1;
        }
        a->arr[j + 1] = key;
    }
}

int main() {
    Array a;
    initArray(&a);
    insertionSort(&a);
    printf("Sorted: ");
    displayArray(&a);
    return 0;
}
```
