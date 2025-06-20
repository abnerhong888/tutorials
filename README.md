This is a tutorial for Git command  
Also for practicing markdown language :smile:
===

# 0. Git

Working directory -> Staged area -> .git directory  
----------------> Add files ------> commit ---->  

Head is means in current branch

# 1. Git Config Setting

    git config --global user.name "Your Name"
    git config --global user.email "Your Email"

Set vscode editor if you want to

    git config --global core.editor nvim or vim
    git config --global core.editor "code --wait"
    git config --global -e -> open editor to edit .gitconfig
    git config --global credential.helper store

Set vscode as a default diff tool

    git config --global diff.tool vscode
    git config --global difftool.vscode.cmd "code --wait --diff $LOCAL $REMOTE"
    **make sure command is right in .gitconfig**
    git config --global -e

Setting the end of line format, ex. windows is \r\n, mac is \n

    git config --global core.autocrlf <value>  -> <value> windows: true, macOS: input

Get more help

    git config --help -> more detail
    git config -h -> quick help

# 2. Inintial a repository

Type it in your working folder

    git init

# 3. File Add command

    git add . -> add all in current folder
    git add file1 file2
    git add *.txt -> all file with txt extension

Delete file 
    
    rm file1 
    git add file1 -> this operation will marked delete file
    
    or

    git rm file1 file2.txt *.txt -> if do this you don't need to add file to update
    
If you uncautiously add foler you don't want to, you can remove it in staging

    git rm --cached -r bin/ 

Move / Rename file

     mv file1.txt main.cpp
     git add file1.txt
     git main.cpp

     or 

     git mv file1.txt main.cpp
# 4. Commit

    git commit -m "your comment message"
    git commit -> without -m "message" it will open editor or use shell to type your change message
    git commit -a -> commit all modified file
    git commit -am "your message"

# 5. GitHub or XXX cloud server

    git push origin main -> push up all to online server
    git pull origin main -> pull down from online server

# 6. Git Ignore


Create ignore file

    echo "" > .gitignore
    git add .gitignore -> add this file to stage area

then you can edit .gitignore to ignore files or folders for git

    logs\
    main.log
    *.log

# 7. Git diff tool

    git difftool
    git difftool --staged

8. Git branch


    git branch <name> -> create new branch
    git checkout <branch name> -> switch between branch name

# . Others

    git status -> check status like you don't commit
    git status -s -> short status
    git ls-files -> list all files 

    git diff
    git diff --staged

    git log 
    git log --oneline --reverse

    git show HEAD~1 -> show head and step back 1
    git show HEAD~1:<filepath> -> <ID> is also work
    git show <ID>

    git checkout
    git checkout <ID>
    git checkout <branck name>

    git restore . -> undo all local changes
    git restore file.txt -> undo all modified file
    git restore --source=<ID> file.txt -> restore specific file with commited 
    git restore --source=HEAD~1 file.txt
    git restore --staged file.txt -> restroe staged file to working file

    git reset --hard <ID> -> delete commit by ID

    git clean -fd -> clean untracked files

# . MarkDown Practice


:warning: <span style="color:red">you can install chrome or edge extension for markdown</span>  
`and then you can see the changes immediately by autoreload function`  

Code section

```cpp
#include "stdio.h"
#include "stdlib.h"

int main(){
    printf("Hello World\n");
    return 0;
}
```

`short block`

CheckBox

- [ ] uncheck
- [x] check

Hyperlink

[連結名稱](https://google.com "游標顯示")  
[GOOGLE](https://google.com "google site")  

Eazy Hyperlink  
<https://google.com>

[Google][1]  
[Yahoo][2]  
[MSN][3]  


[1]: http://google.com/        "游標顯示"
[2]: http://search.yahoo.com/  "游標顯示"
[3]: http://search.msn.com/    "游標顯示"

Picture Link

![圖片名稱](連結 "游標顯示")

[![圖片](圖片網址)](連結網址)


> This is the first level of quoting.
>
>> This is nested blockquote.  
>> 1231321
>
> Back to the first level.
>> 123  
>> 456  
> 
> 789


<style>
r { color: Red }
o { color: Orange }
g { color: Green }
</style>

# TODOs:

- <r>TODO:</r> Important thing to do
- <o>TODO:</o> Less important thing to do
- <g>DONE:</g> Breath deeply and improve karma


\### 123 \###


| 欄位1 | 欄位2 | 欄位3 |
| :-- | --: |:--:|
| 置左  | 置右 | 置中 |
|1|2|3|
|10|23|32|
|1110|2---3|++|
