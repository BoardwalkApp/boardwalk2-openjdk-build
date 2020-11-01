/* Copyright (C) 2001, 2004 Free Software Foundation, Inc.
   This file is part of the GNU C Library.
   The GNU C Library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Lesser General Public
   License as published by the Free Software Foundation; either
   version 2.1 of the License, or (at your option) any later version.
   The GNU C Library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Lesser General Public License for more details.
   You should have received a copy of the GNU Lesser General Public
   License along with the GNU C Library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
   02111-1307 USA.  */

#ifndef _SYS_PROCFS_H
#define _SYS_PROCFS_H   1

#define USE_LOCAL_PROCFS 1

/* This is somewhat modelled after the file of the same name on SVR4
   systems.  It provides a definition of the core file format for ELF
   used on Linux.  It doesn't have anything to do with the /proc file
   system, even though Linux has one.
   Anyway, the whole purpose of this file is for GDB and GDB only.
   Don't read too much into it.  Don't use it for anything other than
   GDB unless you know what you are doing.  */

#include <features.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/user.h>

#ifndef USE_LOCAL_PROCFS
# include <sys/procfs.h>
#else
# include <sys/cdefs.h>
# include <sys/ucontext.h>
#endif

__BEGIN_DECLS

#ifdef USE_LOCAL_PROCFS

#if defined(__arm__)
typedef struct user_fpregs fpregset_t;
#elif defined(__aarch64__)
/*
struct user_regs_struct {
  uint64_t regs[31];
  uint64_t sp;
  uint64_t pc;
  uint64_t pstate;
};
*/
struct user_fpsimd_struct {
  __uint128_t vregs[32];
  uint32_t fpsr;
  uint32_t fpcr;
};
typedef struct user_fpsimd_struct fpregset_t;
#elif defined(__i386__)
struct _libc_fpreg {
  unsigned short significand[4];
  unsigned short exponent;
};

struct _libc_fpstate {
  unsigned long cw;
  unsigned long sw;
  unsigned long tag;
  unsigned long ipoff;
  unsigned long cssel;
  unsigned long dataoff;
  unsigned long datasel;
  struct _libc_fpreg _st[8];
  unsigned long status;
};

typedef struct _libc_fpstate* fpregset_t;
#elif defined(__x86_64__)
struct _libc_fpxreg {
  unsigned short significand[4];
  unsigned short exponent;
  unsigned short padding[3];
};

struct _libc_xmmreg {
  uint32_t element[4];
};

struct _libc_fpstate {
  uint16_t cwd;
  uint16_t swd;
  uint16_t ftw;
  uint16_t fop;
  uint64_t rip;
  uint64_t rdp;
  uint32_t mxcsr;
  uint32_t mxcr_mask;
  struct _libc_fpxreg _st[8];
  struct _libc_xmmreg _xmm[16];
  uint32_t padding[24];
};

typedef struct _libc_fpstate* fpregset_t;
#endif

typedef unsigned long elf_greg_t;
typedef elf_greg_t elf_gregset_t[NGREG];

typedef fpregset_t elf_fpregset_t;

#if defined(__i386__)
typedef struct user_fpxregs_struct elf_fpxregset_t;
#endif

typedef elf_gregset_t prgregset_t;
typedef elf_fpregset_t prfpregset_t;

typedef pid_t lwpid_t;
typedef void* psaddr_t;

struct elf_siginfo {
  int si_signo;
  int si_code;
  int si_errno;
};

#endif // USE_LOCAL_PROCFS

/* And the whole bunch of them.  We could have used `struct
   user_regs_struct' directly in the typedef, but tradition says that
   the register set is an array, which does have some peculiar
   semantics, so leave it that way.  */
#define ELF_NGREG (sizeof (struct user_regs_struct) / sizeof(elf_greg_t))

#if !defined(__x86_64__) && !defined(__i386__)
/* Definitions to generate Intel SVR4-like core files.  These mostly
   have the same names as the SVR4 types with "elf_" tacked on the
   front to prevent clashes with Linux definitions, and the typedef
   forms have been avoided.  This is mostly like the SVR4 structure,
   but more Linuxy, with things that Linux does not support and which
   GDB doesn't really use excluded.  */
struct elf_prstatus
  {
    struct elf_siginfo pr_info;     /* Info associated with signal.  */
    short int pr_cursig;        /* Current signal.  */
    unsigned long int pr_sigpend;   /* Set of pending signals.  */
    unsigned long int pr_sighold;   /* Set of held signals.  */
    __pid_t pr_pid;
    __pid_t pr_ppid;
    __pid_t pr_pgrp;
    __pid_t pr_sid;
    struct timeval pr_utime;        /* User time.  */
    struct timeval pr_stime;        /* System time.  */
    struct timeval pr_cutime;       /* Cumulative user time.  */
    struct timeval pr_cstime;       /* Cumulative system time.  */
    elf_gregset_t pr_reg;       /* GP registers.  */
    int pr_fpvalid;         /* True if math copro being used.  */
  };

#define ELF_PRARGSZ     (80)    /* Number of chars for args.  */
struct elf_prpsinfo
  {
    char pr_state;          /* Numeric process state.  */
    char pr_sname;          /* Char for pr_state.  */
    char pr_zomb;           /* Zombie.  */
    char pr_nice;           /* Nice val.  */
    unsigned long int pr_flag;      /* Flags.  */
#if __WORDSIZE == 32
    unsigned short int pr_uid;
    unsigned short int pr_gid;
#else
    unsigned int pr_uid;
    unsigned int pr_gid;
#endif
    int pr_pid, pr_ppid, pr_pgrp, pr_sid;
    /* Lots missing */
    char pr_fname[16];          /* Filename of executable.  */
    char pr_psargs[ELF_PRARGSZ];    /* Initial part of arg list.  */
  };

/* The rest of this file provides the types for emulation of the
   Solaris <proc_service.h> interfaces that should be implemented by
   users of libthread_db.  */

/* Addresses.  */
typedef void *psaddr_t;

/* We don't have any differences between processes and threads,
   therefore have only one PID type.  */
typedef __pid_t lwpid_t;

/* Register sets.  Linux has different names.  */
typedef elf_gregset_t prgregset_t;
typedef elf_fpregset_t prfpregset_t;

#endif // !__x86_64__ && !__i386__

/* Process status and info.  In the end we do provide typedefs for them.  */
typedef struct elf_prstatus prstatus_t;
typedef struct elf_prpsinfo prpsinfo_t;

__END_DECLS

#endif	/* sys/procfs.h */
