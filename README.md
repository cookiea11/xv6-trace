# xv6 Trace System Call

## Overview

This project adds a `trace(int)` system call to xv6. Tracing can be enabled or disabled for the current process. When tracing is enabled, the kernel prints the process ID and the name of each system call executed by that process. A child process created with `fork()` inherits its parent's tracing state.

## System Call Interface Chart

| No. | System Call | User Function | Kernel Handler |
|---:|---|---|---|
| 1 | `fork` | `fork(void)` | `sys_fork()` |
| 2 | `exit` | `exit(int)` | `sys_exit()` |
| 3 | `wait` | `wait(int *)` | `sys_wait()` |
| 4 | `pipe` | `pipe(int *)` | `sys_pipe()` |
| 5 | `read` | `read(int, void *, int)` | `sys_read()` |
| 6 | `kill` | `kill(int)` | `sys_kill()` |
| 7 | `exec` | `exec(const char *, char **)` | `sys_exec()` |
| 8 | `fstat` | `fstat(int, struct stat *)` | `sys_fstat()` |
| 9 | `chdir` | `chdir(const char *)` | `sys_chdir()` |
| 10 | `dup` | `dup(int)` | `sys_dup()` |
| 11 | `getpid` | `getpid(void)` | `sys_getpid()` |
| 12 | `sbrk` | `sbrk(int)` / `sys_sbrk(int, int)` | `sys_sbrk()` |
| 13 | `pause` | `pause(int)` | `sys_pause()` |
| 14 | `uptime` | `uptime(void)` | `sys_uptime()` |
| 15 | `open` | `open(const char *, int)` | `sys_open()` |
| 16 | `write` | `write(int, const void *, int)` | `sys_write()` |
| 17 | `mknod` | `mknod(const char *, short, short)` | `sys_mknod()` |
| 18 | `unlink` | `unlink(const char *)` | `sys_unlink()` |
| 19 | `link` | `link(const char *, const char *)` | `sys_link()` |
| 20 | `mkdir` | `mkdir(const char *)` | `sys_mkdir()` |
| 21 | `close` | `close(int)` | `sys_close()` |
| 22 | `sync` | `sync(void)` | `sys_sync()` |
| 23 | `trace` | `trace(int)` | `sys_trace()` |

## Trace System Call Interface

The user-to-kernel path for the trace system call is:

```text
User program calls trace(int)
             |
             v
user/usys.pl generates the trace assembly stub
             |
             v
The stub places SYS_trace (23) in register a7
             |
             v
The stub executes ecall
             |
             v
kernel/syscall.c reads a7 and dispatches SYS_trace
             |
             v
sys_trace() updates the process tracing state
```

The interface is connected through the following files:

- `kernel/syscall.h` assigns `SYS_trace` the system-call number `23`.
- `user/user.h` declares the user function as `int trace(int);`.
- `user/usys.pl` contains `entry("trace");`, which generates the assembly stub.
- `kernel/syscall.c` maps `SYS_trace` to `sys_trace()` and maps the number to the name `trace`.
- `kernel/sysproc.c` implements `sys_trace()` and stores the tracing state in the current process.
- `kernel/proc.h` contains the per-process tracing field.
- `kernel/proc.c` copies the tracing state from a parent process to its child during `fork()`.

## Test Programs

The repository contains two test programs:

- `trace` enables tracing, calls `getpid()`, disables tracing, and calls `getpid()` again. Only calls made while tracing is enabled should be reported.
- `tracefork` enables tracing before calling `fork()`. It verifies that the child process inherits the parent's tracing setting.

Both programs are included in `UPROGS` in the Makefile.

## Building and Running

From the repository directory, run:

```bash
make clean
make qemu
```

At the xv6 shell, run:

```text
trace
tracefork
```

Exit QEMU by pressing `Ctrl-a`, followed by `x`.

## Team Contributions

> Replace the placeholders below with the correct names and responsibilities before submission.

| Team Member | Contribution |
|---|---|
| Siddhi Gulati | Implemented the kernel-side trace logic and per-process tracing state. |
| Rudranshi Airen | Manually charted, documented, and verified the complete system-call interface and the user-to-kernel path for `trace(int)`. |
| Dhruv Garg | Implemented or verified the user test programs, build integration, and execution results. |

## Video Walkthrough

The recording link and each member's speaking timestamps are provided in [`Video.md`](Video.md).