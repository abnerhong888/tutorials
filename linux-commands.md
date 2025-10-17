## linux-commands

# -- find
```bash
  # Find files by name
  find . -name "file.txt"

  # Find files with wildcard
  find . -name "*.c"

  # Find only directories
  find . -type d

  # Find only files
  find . -type f
```

# -- grep
```bash
  grep [options] PATTERN [file...]

  grep -Znr . -e "<pattern>"
  grep -Znr --include=\*.<ext1> . -e "<pattern>"
  grep -Znr --include=\*.{<ext1, ext2>} . -e "<pattern>"
```
| Option | Meaning                             |
| ------ | ----------------------------------- |
| `-i`   | Ignore case                         |
| `-r`   | Recursive search                    |
| `-w`   | Match whole word                    |
| `-v`   | Invert match                        |
| `-n`   | Show line number                    |
| `-E`   | Use extended regex                  |
| `-l`   | Show filenames that contain matches |
| `-c`   | Count matching lines                |


# -- tar
```bash
  # use gzip compress
  tar -cvzf <name>.tar.gz <folder or file>

  # use tar compress
  tar -cvf <name>.tar <folder or file>

  # extract file
  tar -xvf <file name> -C <directory>

  # list tar file content
  tar -tf <file name>

  # list tar file content first layer
  tar -tf archive.tar | cut -d/ -f1 | sort -u
```

# -- ar
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

# -- ld
```bash
  # Shows shared libraries used by a binary
  ldd <name>.so
```

# -- nm
```bash
  # nm command is used to list symbols
  nm <name>.a
  nm -s <name>.a
  nm a.out
```
|Symbol | Meaning                                        |Flag           |Description                          |
|:--|:--|:--|:--|
|T      |	Function (in .text section, global)            |-C             | Demangle C++ symbol names           |
|t      |	Function (local/private)                       |-g             | Show only external (global) symbols |
|B      |	Global uninitialized variable (.bss)           |-n             | Sort symbols by address             |
|D      |	Global initialized data (.data)                |-u             | Show only undefined symbols         |
|U      |	Undefined (symbol needed but not defined here) |--defined-only | Show only defined symbols           |
|R      |	Read-only data (.rodata)                       |
|W      |	Weak symbol                                    |


# -- du
```bash
  # show folder total size
  du -hs <folder>
```

# -- size
```bash
  size <.o, .so ...>
```

# -- objdump
```bash
  # dump all symbol and assembly
  objdump -Slz a.out > log.log
  objdump -SlzafphxgeGWtTrRs a.out > 1_ALL.log
```
| Flag   | Meaning                                                                     |
| ------ | --------------------------------------------------------------------------- |
| **-S** | Intermix **source code** with disassembly (if debugging info is available). |
| **-l** | Include **line numbers** (from debugging symbols).                          |
| **-z** | Don't skip zero section headers (show all).                                 |
| **-a** | Display **archive header information**.                                     |
| **-f** | Display **file header** information.                                        |
| **-p** | Display **private headers** (processor-specific info).                      |
| **-h** | Display **section headers**.                                                |
| **-x** | Display **all headers** (same as `-a -f -h -p -r -t`).                      |
| **-g** | Display **debugging information** (DWARF, etc).                             |
| **-e** | Display **debugging entries** (extended DWARF details).                     |
| **-G** | Display **symbol debugging information**.                                   |
| **-W** | Display **DWARF public names** and other DWARF info.                        |
| **-t** | Display **symbol table**.                                                   |
| **-T** | Display **dynamic symbol table** (for ELF binaries).                        |
| **-r** | Display **relocation entries**.                                             |
| **-R** | Display **dynamic relocations**.                                            |
| **-s** | Display **full contents of all sections** (hex + ASCII).                    |

# -- objcopy
```bash
  # redefine symbol in static library
  objcopy --redefine-sym <ori_symbol>=<new_symbol> file.a
```

# -- c++filt
```bash
  #demangle c++ function symbol
  c++filt <symbol> 
```

# -- profiling
```bash
  # program analysis tool
  valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./your_program
  valgrind --tool=callgrind ./your_program
  # gui show the tree
  kcachegrind callgrind.out.<pid>

  # performance analysis tool
  perf record ./your_program
  perf report perf.data
  
  perf stat ./your_program
```
# -- tee
```bash
  ./<program> | tee log.log --> visible in file: StdOut
  ./<program> |& tee log.log --> visible in file: StdOut, StdErr
  ./<program> |& tee log.log --> override file
  ./<program> |& tee -a log.log --> -a is append file
  # Fix tee not showing output, Line-buffered stdout
  stdbuf -oL ./<program> |& tee log.log
  # appear immediately
  stdbuf -o0 ./<program> |& tee log.log
```
# -- diff
```bash
  # -u: Shows a unified diff (easy to read)
  diff -u --color=always <file1> <file2>
  # -r: Recursively compare all subdirectories and files
  diff -ru --color=always <folder1> <folder2>
  # -q: Quiet — only shows which files differ
  diff -rq <folder1> <folder2>

  # meld is also a good app 
```

# -- watch
```bash
  watch -n 1 "ps aux | grep <name>"
```

# -- Linux can not delete， ”Device or resource busy”
```bash
  lsof |grep <filename>
  kill -9 <processid>
  ＃ java      32308    hadoop  201u      REG               0,23  1048576 57278542
  ＃ /public/hadoop/name/current/.nfs00000000036a004e00000009 (iboss01:/public)
```
