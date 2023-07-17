#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <assert.h>
#include <lasxintrin.h>


extern __inline __attribute__((__gnu_inline__, __always_inline__, __artificial__))
__m256    __lasx_setr_s (float __A, float __B, float __C, float __D,float __E, float __F, float __G, float __H)
{
  return __extension__ (__m256){ __A, __B, __C, __D ,__E,  __F,  __G,  __H};
}

void read_data(int file_no, int size, float** array) {
    char input_path_1[30], input_path_2[30];
    sprintf(input_path_1, "input/A_%d.txt", size);
    sprintf(input_path_2, "input/B_%d.txt", size);
    FILE * fp = NULL;

    char *line;
    char buffer[10000];
    int i = 0, j = 0;

    if(file_no == 1) {
        fp = fopen(input_path_1, "r");
    } else if(file_no == 2) {
        fp = fopen(input_path_2, "r");
    } else{
        assert(0);
    }

    if(fp == NULL){
        assert(0);
    }

    while((line = fgets(buffer, sizeof(buffer), fp)) != NULL){
        char* word = strtok(line, ",");
        while (word != NULL){
            array[i][j++] = strtol(word, NULL, 10);
            word = strtok(NULL, ",");
        }
        i++;
        j = 0;
    }

    fclose(fp);
}

void print_matrix(float**m, int rows, int cols) {
    for (int i=0; i<rows; i++) {
        for (int j=0; j<cols; j++) {
            printf("%f ", m[i][j]);
        }
        printf("\n");
    }
}

void lasx_matrix_multiplication(float**matrix, float**matrix_1, float**matrix_2, int m, int n, int r) {
    float*tmp = (float*)malloc(8*sizeof(float));
    for (int i=0; i<8; i++) tmp[i] = 0.f;
    for (int i=0; i<m; i++) {
        for (int j=0; j<r; j++) {
		for (int k=0; k<n; k+=8) {
	            __lasx_xvst(__lasx_xvfmul_s(
			   (__m256)__lasx_xvld((float*)(matrix_1[i]+k), 0),
			   __lasx_setr_s(matrix_2[k][j], matrix_2[k+1][j], matrix_2[k+2][j], matrix_2[k+3][j],matrix_2[k+4][j], 
			   matrix_2[k+5][j], matrix_2[k+6][j], matrix_2[k+7][j])), tmp, 0);
		    matrix[i][j] += tmp[0] + tmp[1] + tmp[2] + tmp[3] + tmp[4] + tmp[5] + tmp[6] + tmp[7];
		}
        }
    }
}

int main(int argc, char* argv[]) {               
    if (argc != 2) assert(0);

    int size = atoi(argv[1]);
    int m = size, n = size, r = size;

    // allocate memory for 3 matrices
    float**matrix_1 = (float**)malloc(m*sizeof(float*));
    for (int i=0; i<m; i++) {
        matrix_1[i] = (float*)malloc(n*sizeof(float));
    }
    float**matrix_2 = (float**)malloc(n*sizeof(float*));
    for (int i=0; i<n; i++) {
        matrix_2[i] = (float*)malloc(r*sizeof(float));
    }
    float**matrix = (float**)malloc(m*sizeof(float*));
    for (int i=0; i<r; i++) {
        matrix[i] = (float*)malloc(r*sizeof(float));
    }

    // initialize matrices
    read_data(1, size, matrix_1);
    read_data(2, size, matrix_2);

    // matrix multiplication
    clock_t start_t, end_t, clock_dif; double clock_dif_sec;
    start_t = clock();

    for (int k=0; k<10; k++) {
        for (int i=0; i<m; i++) { 
            for (int j=0; j<r; j++) {
                matrix[i][j] = 0.f;
            }
        }
        lasx_matrix_multiplication(matrix, matrix_1, matrix_2, m, n, r);
    }

    end_t = clock(); 
    clock_dif = end_t - start_t;
    clock_dif_sec = (double) (clock_dif/1000000.0);
    double avg_cost = clock_dif_sec / 10;

    // write cost time to an output file
    char time_path[30];
    sprintf(time_path, "output/time/lasx_%d.txt", size);
    FILE* fp2 = fopen(time_path, "w+");
    fprintf(fp2, "%lf", avg_cost);
    fclose(fp2);

    // write matrix multiplication result to an output file
    char result_path[30];
    sprintf(result_path, "output/result/lasx_%d.txt", size);
    FILE* fp3 = fopen(result_path, "w+");
    for (int i=0; i<size; i++) {
        for (int j=0; j<size; j++) {
            if (j == size-1) fprintf(fp3, "%f\n", matrix[i][j]);
            else fprintf(fp3, "%f,", matrix[i][j]);
        }
    }
    fclose(fp3);
}

