```c++
%% 常用 git
git status					%% 查看本地修改的文件
git diff					%% 本地修改的文件和远程分支的文件比较差异
git pull 					%% 拉取远程分支,更新到本地
git add .  					%% .表示提交所有修改的文件
git add name 				%% 表示提交某个文件, name表示名字
git commit -m "xxxxx" 		%% 描述你修改的文件,尽量简短明了
git push 					%% 提交本地文件到远程分支
git log 					%% 显示该分支提交的记录
git checkout xxx			%% 切换到某个分支.
git checkout -- .			%% . 代表所有, 把本地所有修改的文件,恢复
git checkout -- xxx			%% xxx 文件名字, 把本地修改过的文件,恢复

%% 不是很常用,但是也偶尔会用
git clone xxx							%% 拷贝某个远程项目库
git branch								%% 查看本地分支
git branch  -a							%% 查看所有分支
git branch xxx							%% 本地创建xxx分支
git checkout -b							%% 本地创建xxx分支,并切换到xxx分支
git push -f  							%% 本地强制跟新远程分支
git merge xxx 							%% 合并某个xxx分支
git stash    							%% 本地缓存修改
git stash pop  							%% 把本地更改的缓存恢复
git push origin --delete <branchName>  	%% 删除远程分支
git branch -D <branchName> 				%% 删除本地分支 

  
%% 一些常用的Linux命令
ls			%% 列出当前路径下的所有文件和文件夹(不包含隐藏文件)
ll -a   	%% 列出当前路径下的所有文件和文件夹(包含隐藏文件)
cd xxx 		%% 切换到某个xxx路径下
pwd			%% 打印出当前的目录路径
rm -rf xxx	%% 强制删除某个xxx文件,(注意使用这个命令之前,你要删除的文件,删除了,再也找不到这个文件)
```

