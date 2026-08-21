#include "kernel/types.h"
#include "user/user.h"

int
main(void)
{
  trace(1);

  getpid();

  trace(0);

  getpid();

  exit(0);
}
