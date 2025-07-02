## linux-commands

# grep
```bash
  grep -Znr . -e <pattern>
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
  nm <name>.a
  nm -s <name>.a
```

# du
```bash
  du -hs <folder>
```

# code size
```bash
  size <.o, .so ...>
```

# obj dump
```bash
  objdump -Slz a.out
```

# obj copy
```bash
  # redefine symbol in static library
  objcopy --redefine-sym calloc=callocflake file.a
```

# profiling
```bash
  valgrind ...
  perf ...
```

# Linux不能删除， ”Device or resource busy”
```bash
  lsof |grep <filename>
  kill -9 <processid>
  ＃ java      32308    hadoop  201u      REG               0,23  1048576 57278542
  ＃ /public/hadoop/name/current/.nfs00000000036a004e00000009 (iboss01:/public)
```
