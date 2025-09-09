This is a tutorial for Git command  
Also for practicing markdown language 
===

# 0. Git

Working directory -> Staged area -> .git directory  
----------------> Add files ------> commit ---->  

Head is means in current branch

# 1. Git Config Setting
```bash
git config --global user.name "Your Name"
git config --global user.email "Your Email"
git config --list -> show all settings
```

Set vscode editor if you want to
```bash
git config --global core.editor nvim or vim
git config --global core.editor "code --wait --new-window"
git config --global -e -> open editor to edit .gitconfig
git config --global credential.helper store -> for recording your password
# unset example
git config --global --unset core.editor
```

Set vscode as a default diff tool
```bash
git config --global diff.tool vscode
git config --global difftool.vscode.cmd 'code --wait --diff --new-window $LOCAL $REMOTE'
**make sure command is right in .gitconfig**
git config --global -e
# how to use
git difftool <file>
git difftool commit1 commit2
```

Set git log format
```bash
git config --global alias.lg "log --oneline --decorate --graph --all --pretty=format:'%C(yellow)%h%Creset -%Cgreen(%ar)%Creset %C(blue)<%an>%Creset %C(auto)%d%Creset %s'"
#unset
git config --global --unset alias.lg
```

Setting the end of line format, ex. windows is \r\n, mac is \n
```bash
git config --global core.autocrlf <value>  -> <value> windows: true, macOS: input
```

Get more help
```bash
git config --help -> more detail
git config -h -> quick help
```

# 2. Inintial a repository

Type it in your working folder
```bash
git init
```

# 3. File Add command

```bash
git add . -> add all in current folder
git add file1 file2
git add *.txt -> all file with txt extension
```
Delete file 
```bash
rm file1 
git add file1 -> this operation will marked delete file

or

git rm file1 file2.txt *.txt -> if do this you don't need to add file to update
```    

If you uncautiously add foler you don't want to, you can remove it in staging

```bash
git rm --cached -r bin/ 
```

Move / Rename file
```bash
git mv file1.txt main.cpp
```
# 4. Commit

```bash
git commit -m "your comment message"
git commit -> without -m "message" it will open editor or use shell to type your change message
git commit -a -> commit all modified file
git commit -am "your message"
```

# 5. GitHub or XXX cloud server

```bash
git push origin main -> push up all to online server
git pull origin main -> pull down from online server
```

# 6. Git Ignore

Create ignore file
```bash
echo "" > .gitignore
git add .gitignore -> add this file to stage area
```

then you can edit .gitignore to ignore files or folders for git

```bash
logs\
main.log
*.log
```
# 7. Git diff tool

```bash
git difftool
git difftool --staged
```

# 8. Git branch

```bash
git branch <name> -> create new branch
git checkout <branch name> -> switch between branch name
git branch
git branch -vv
git branch -v -a
git push -u origin <branch name>
git branch -d <name>
```

# 9. Git Drop

```bash
# create new branch first
git branch test
git checkout test
# git log to watch git commit ID
git log
# use rebase command to drop
git rebase -i <commitID>

# it will open a new window with vi or editor you setted
# pick abc123 Commit message
# pick def456 Next commit
# --
# you can edit pick to drop
# drop abc123 Commit message
# pick def456 Next commit

```

# 10. Others

## -- git status
```bash
git status -> check status like you don't commit
git status -s -> short status
```

## -- git ls-files
```bash
git ls-files -> list all files 
```

## -- git diff
```bash
git diff
git diff --staged
```

## -- git log
```bash
git log 
git log --oneline --reverse
# git graph with local main and remote main
git log --oneline --graph --decorate --all --branches=main
gitk main origin/main
```

## -- git show
```bash
git show HEAD~1 -> show head and step back 1
git show HEAD~1:<filepath> -> <ID> is also work
git show <ID>
```
## -- git check
```bash
git checkout
git checkout <ID>
git checkout <branck name>
git checkout -b <branck name>
```
## -- git restore
```bash
git restore . -> undo all local changes
git restore file.txt -> undo all modified file
git restore --source=<ID> file.txt -> restore specific file with commited 
git restore --source=HEAD~1 file.txt
git restore --staged file.txt -> restroe staged file to working file
```
## -- git reset
```bash
#Just remove the last commit (keep the changes as uncommitted)
git reset --soft <ID>
#Remove the last commit and also discard changes
git reset --hard <ID> 
# if you wwant to restore the commit which deleted
git reflog
git reset --hard <ID> -> ID you want to restore
```
## -- git clean
```bash
git clean -fd -> clean untracked files
```
## -- git remote
```bash
git remote set-url origin <address>
```

## -- gitk
```bash
gitk <filename>
gitk origin/<branch name>
gitk main origin/main
```

## -- git rebase
this can make sure git history are all in the same line

fetch first and rebase
```bash
git fetch
git rebase <remote/branch>
```

or  

first make a branch  
and then you can do all you want to commit edit etcetera  
```bash 
git checkout -b <branch_name>
git commit ...
```

chekcout back to main or master
```bash
git checkout <main or master>
git pull # update to local main
```
chekcout back to branch for rebase newest main
```bash
git checkout <branch_name>
git rebase <main or master> # to make newest main to be branch's base 
```

chekcout back to main for rebase newest branch
```bash
git checkout <main or master>
git rebase <branch_name> # to make newest branch to be main's base 
```

now you can push to remote and also can delete branch
```bash
git push
git branch -d <branch_name>
```

## -- git sparse-checkout
This lets you only check out part of the repo locally while keeping everything tracked in Git.

Enable sparse checkout:
```bash
git sparse-checkout init --cone
```
Set what folders/files you want to keep:

```bash
git sparse-checkout set src/ README.md --skip-checks
```

Only src/ and README.md will be visible. Everything else is hidden (but still exists in Git history and remote).

If you want to show more later:
```bash
git sparse-checkout set src/ docs/ tools/ --skip-checks
```

To turn off sparse checkout and bring back all files:
```bash
git sparse-checkout disable
```
⚠️ This only works on Git 2.25+ (run git --version to check)


# 10. Step-by-Step: Use a Local Folder as a Git Remote

## 10.1. Create a bare repo (local "remote")

```bash
mkdir -p /path/to/remote-repo.git
cd /path/to/remote-repo.git
git init --bare
```
A bare repo has no working files — it's used just for pushing/pulling.

## 10.2. Set the local folder as remote in your project
Go to your working Git repo (your project):

```bash
cd /path/to/your/project
git remote add origin /path/to/remote-repo.git
```

You can now push and pull to this local "remote":
```bash
git pull origin main  # or master, or your branch name
git push origin main  # or master, or your branch name
```

You can even clone from it like this:
```bash
git clone /path/to/remote-repo.git
```
