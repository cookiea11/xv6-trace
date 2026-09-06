# DA-2: xv6 Process Lifecycle with GDB - Debugging Guide

## Environment Setup

**Repository:** DhruvGarghub/xv6-trace (RISC-V xv6)
**Branch:** siddhi-trace
**xv6 Version:** xv6-riscv (RISC-V 64-bit)
**Architecture:** RISC-V64
**Emulator:** QEMU (qemu-system-riscv64)

## Process States in This xv6 Version

From `kernel/proc.h`:
```c
enum procstate { UNUSED, USED, SLEEPING, RUNNABLE, RUNNING, ZOMBIE };
```

**Note:** This version uses `USED` instead of the traditional `EMBRYO` state.

## Build Commands

Clean and build xv6:
```bash
cd xv6-trace
make clean
make
```

**Build Verification:**
- Check that `kernel/kernel` exists
- Check that `CFLAGS` includes `-ggdb -gdwarf-2` (line 63 of Makefile)

## QEMU + GDB Launch

### Terminal 1: Start QEMU with GDB stub
```bash
make qemu-gdb
```

This will:
- Start QEMU with kernel paused (`-S` flag)
- Enable GDB stub on port `$(GDBPORT)` (typically around 26000-29999)
- Print "*** Now run 'gdb' in another window"

### Terminal 2: Connect with GDB
```bash
gdb
file kernel
target remote localhost:26000
```

**Note:** The actual port is printed by `make print-gdbport` or see the Makefile.

## GDB Commands for DA-2

### Boot Trace
```gdb
break main
continue
# Should break at kernel/main.c:11
backtrace
info registers
list

# Continue to userinit
break userinit
continue
# Should break at kernel/proc.c:220
```

### Process State Transitions
```gdb
break allocproc
break kfork
break exec  # kernel/exec.c
break kexit
break scheduler
break sched
break wakeup
break sleep
break swtch
```

### Inspect Process State
```gdb
# Print process table
print proc[0]
print proc[0].state
print proc[0].pid
print proc[0].name

# Print current process
print myproc()

# Print CPU state
print cpus[0]
print cpus[0].proc
print cpus[0].context
```

### Context Switch Inspection
At `swtch()` boundary:
```gdb
info registers
# Pay attention to: esp, eip (x86), or sp, pc (RISC-V)
# For RISC-V: look at ra, sp, s0-s11 in struct context
```

## Key Files to Inspect

1. **kernel/proc.h** - Process structure, states
2. **kernel/proc.c** - Process management, scheduling
3. **kernel/main.c** - Boot sequence
4. **kernel/swtch.S** - Context switch assembly
5. **kernel/exec.c** - Process execution
6. **kernel/trap.c** - Interrupt/trap handling

## Test Programs

- **user/trace.c** - DA-1 trace test
- **user/tracefork.c** - DA-1 fork tracing test
- **user/forktest.c** - Fork stress test
- **user/zombie.c** - Zombie process test

## Observations Needed

### 1. Boot Trace
- [ ] Break at `main()`
- [ ] Observe initialization sequence
- [ ] Break at `userinit()`
- [ ] Observe first user process creation

### 2. Process State Transitions
- [ ] UNUSED → USED (in allocproc)
- [ ] USED → RUNNABLE (in userinit)
- [ ] RUNNABLE → RUNNING (in scheduler)
- [ ] RUNNING → SLEEPING (in sleep)
- [ ] SLEEPING → RUNNABLE (in wakeup)
- [ ] RUNNING → ZOMBIE (in kexit)
- [ ] ZOMBIE → UNUSED (in kwait after freeproc)

### 3. Scheduler & Context Switch
- [ ] Observe scheduler() round-robin
- [ ] Observe swtch() register state
- [ ] Observe multiple context switches

### 4. Process Table & CPU State
- [ ] ptable contents
- [ ] cpus[0].proc changes
- [ ] Context switching

---

**Status:** Setup verified, ready for manual GDB debugging sessions.
