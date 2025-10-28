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
  ld <name>.so
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
  objdump -Shxd a.out > 1_ALL.log
```
| Option(s)    | Long form / alias                | What it does                                                                                                                                      |
| ------------ | -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-a`         | `--archive-headers`              | If the input is an archive, show archive member headers. ([Massachusetts Institute of Technology][1])                                             |
| `-b bfdname` | `--target=bfdname`               | Force the object format (bfd backend) to `bfdname`. ([Massachusetts Institute of Technology][1])                                                  |
| `-C [style]` | `--demangle[=style]`             | Demangle (decode) C++ symbol names (e.g. turn `Foo::bar` from mangled). ([Sanfoundry][2])                                                         |
| `-d`         | `--disassemble`                  | Disassemble sections that are expected to contain code. ([Massachusetts Institute of Technology][1])                                              |
| `-D`         | `--disassemble-all`              | Disassemble *all* sections, even ones not marked as executable. ([Sanfoundry][2])                                                                 |
| `-e`         | —                                | Show extended debugging entries (DWARF). ([man7.org][3])                                                                                          |
| `-f`         | `--file-headers`                 | Print the file header (format, architecture, flags, start address). ([Linux Documentation][4])                                                    |
| `-g`         | `--debugging`                    | Display debugging information (DWARF, etc.). ([man7.org][3])                                                                                      |
| `-G`         | `--stabs`                        | Show STABS debugging symbol info (older debug format). ([Massachusetts Institute of Technology][1])                                               |
| `-h`         | `--section-headers`, `--headers` | List the section headers (.text, .data, etc.) with sizes, addresses. ([Linux Documentation][4])                                                   |
| `-H`         | `--help`                         | Display help / usage summary. ([Sanfoundry][2])                                                                                                   |
| `-i`         | `--info`                         | Show supported object formats / architectures. ([Sanfoundry][2])                                                                                  |
| `-j name`    | `--section=name`                 | Restrict operations to a specific section (e.g. `-j .text`). ([Sanfoundry][2])                                                                    |
| `-l`         | `--line-numbers`                 | Include source-file line numbers (when disassembling or showing relocations). ([Sanfoundry][2])                                                   |
| `-m arch`    | `--architecture=arch`            | Force a particular architecture for disassembly (if ambiguous). ([Sanfoundry][2])                                                                 |
| `-M options` | `--disassembler-options=options` | Pass architecture-specific options to disassembler (e.g. Intel vs AT&T syntax). ([Sanfoundry][2])                                                 |
| `-p`         | `--private-headers`              | Show object-format specific (private) header info (e.g. program headers in ELF). ([Sanfoundry][2])                                                |
| `-r`         | `--reloc`                        | Show relocation entries. ([Linux Documentation][4])                                                                                               |
| `-R`         | `--dynamic-reloc`                | Show dynamic relocation entries (for shared libraries). ([man7.org][3])                                                                           |
| `-s`         | `--full-contents`                | Dump full contents of sections (hex + ASCII) instead of skipping. ([Massachusetts Institute of Technology][1])                                    |
| `-S`         | `--source`                       | Intermix source code with disassembly (if debug info present). ([Linux Documentation][4])                                                         |
| `-t`         | `--syms`                         | List the symbol table. ([Sanfoundry][2])                                                                                                          |
| `-T`         | `--dynamic-syms`                 | List dynamic symbol table (for shared/dynamic objects). ([man7.org][3])                                                                           |
| `-w`         | `--wide`                         | Don’t wrap or truncate output; useful on wide terminals. ([man7.org][3])                                                                          |
| `-x`         | `--all-headers`                  | Show *all* header-related info: file headers, section headers, relocations, symbols, etc. It’s equivalent to `-a -f -h -p -r -t`. ([man7.org][3]) |
| `-z`         | `--disassemble-zeroes`           | Do *not* skip blocks of zero bytes when disassembling — treat zero bytes as instructions/data. ([man7.org][3])                                    |
| `-Z`         | `--decompress`                   | Decompress compressed sections before dumping their contents (used along with `-s`). ([man7.org][3])                                              |
| `-V`         | `--version`                      | Print version of objdump and exit. ([man7.org][3])                                                                                                |
| `@file`      | —                                | Read options from `file` (each whitespace-separated). ([man7.org][3])                                                                             |

[1]: https://web.mit.edu/gnu/doc/html/binutils_5.html?utm_source=chatgpt.com "The GNU Binary Utilities - objdump - MIT"
[2]: https://www.sanfoundry.com/objdump-command-usage-examples-in-linux/?utm_source=chatgpt.com "10+ objdump Command Examples in Linux - Sanfoundry"
[3]: https://www.man7.org/linux/man-pages/man1/objdump.1.html?utm_source=chatgpt.com "objdump(1) - Linux manual page - Michael Kerrisk"
[4]: https://linux.die.net/man/1/objdump?utm_source=chatgpt.com "objdump(1): info from object files - Linux man page"

# -- objcopy
```bash
  # redefine symbol in static library
  objcopy --redefine-sym <ori_symbol>=<new_symbol> file.a
```
```bash
# extract .a files
ar -x f1.a --output <folder>
ar -x f2.a --output <folder>
# merge all .o files
ld -r -o <folder>/libmerged.o <folder>/*.o
ar -rcs libtest.a lib/libmerged.o
# redefine symbol
objcopy --redefine-sym <ori_symbol>=<new_symbol> libtest.a
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
