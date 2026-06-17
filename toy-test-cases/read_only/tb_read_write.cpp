#include "read_write.h"

int main(){
  int test_array[N*2*2];

  for(int i  =0; i < (N*2); i++){
    test_array[i] = i;
    test_array[i+(N*2)] = 0;
  }

  int out = 0;

  read_write(test_array,test_array);
  read_only(test_array,test_array,out);

  for(int i  =0; i < (N*2); i++){
    if(test_array[i] != test_array[i+(N*2)]){
      printf("Read Write: Test failed at index %d\n",i);
      return 1;
    }
  }
  int ref = 0;
  for(int i = 0; i < N; i++){
    ref += test_array[i] * test_array[N+i];
  }
  if(ref != out){
    printf("Read only test failed: %d != %d\n",ref,out);
    return 1;
  }
  printf("Test passed\n");
  return 0;
}
