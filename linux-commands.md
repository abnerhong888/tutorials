## linux-commands

# grep
```bash
  grep -Znr . -e <pattern>
  grep -Znr --include=\*.<ext1> . -e <pattern>
  grep -Znr --include=\*.{<ext1, ext2>} . -e <pattern>
```
# tar
```bash
  # use gzip compress
  tar -cvzf <name>.tar.gz <folder or file>

  # use tar compress
  tar -cvf <name>.tar <folder or file>

  # extract file
  tar -xvf <file name> -C <directory>
```

# ar
```bash
  # list files in a
  ar -t <name>.a
  # extract .a file
  ar -x <file> --output <dir>
  # archive together 1
  ar -rcs <name.a> *.o

  # archive together 2, this can resolve Undefined symbol
  ld -r -o libmerged.o *.o
  ar -rcs <name.a> libmerged.o

```

# ld
```bash
  ld <name>.so
```

# nm
```bash
  # nm command is used to list symbols
  nm <name>.a
  nm -s <name>.a
  nm a.out
```
|Symbol |	Meaning |
|:--|:--|
|T |	Function (in .text section, global) |
|t |	Function (local/private) |
|B |	Global uninitialized variable (.bss) |
|D |	Global initialized data (.data) |
|U |	Undefined (symbol needed but not defined here) |
|R |	Read-only data (.rodata) |
|W |	Weak symbol |
  
|Flag|Description|
|:--|:--|
|-C | Demangle C++ symbol names |
|-g | Show only external (global) symbols |
|-n | Sort symbols by address |
|-u | Show only undefined symbols |
|--defined-only | Show only defined symbols |

# du
```bash
  # show folder total size
  du -hs <folder>
```

# code size
```bash
  size <.o, .so ...>
```

# obj dump
```bash
  # dump all symbol and assembly
  objdump -Slz a.out > log.log
  objdump -SlzafphxgeGWtTrRs a.out > 1_ALL.log
```

# obj copy
```bash
  # redefine symbol in static library
  objcopy --redefine-sym <ori_symbol>=<new_symbol> file.a
```

# c++filt
```bash
  #demangle c++ function symbol
  c++filt <symbol> 
```

# profiling
```bash
  # program analysis tool
  valgrind ...
  # performance analysis tool
  perf record ./your_program
  perf report perf.data
  
  perf stat ./your_program
```
# tee
```bash
  ./<program> | tee log.log --> visible in file: StdOut
  ./<program> |& tee log.log --> visible in file: StdOut, StdErr
  ./<program> |& tee log.log --> override file
  ./<program> |& tee -a log.log --> -a is append file
  # Fix tee not showing output, Line-buffered stdout
  stdbuf -oL ./<program> |& tee log.log
```
# diff
```bash
  # -u: Shows a unified diff (easy to read)
  diff -u <file1> <file2>
  # -r: Recursively compare all subdirectories and files
  diff -ru <folder1> <folder2>
  # -q: Quiet — only shows which files differ
  diff -rq <folder1> <folder2>

  # meld is also a good app 
```

# watch
```bash
  watch -n 1 "ps aux | grep <name>"
```

# Linux can not delete， ”Device or resource busy”
```bash
  lsof |grep <filename>
  kill -9 <processid>
  ＃ java      32308    hadoop  201u      REG               0,23  1048576 57278542
  ＃ /public/hadoop/name/current/.nfs00000000036a004e00000009 (iboss01:/public)
```
