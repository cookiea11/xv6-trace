#include "kernel/types.h"
#include "user/user.h"

int
main(void)
{
  int pid;

  trace(1);

  pid = fork();

  if (pid == 0) {
    getpid();
    exit(0);
  }

  wait(0);

  trace(0);

  exit(0);
}
