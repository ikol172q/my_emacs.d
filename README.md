# my_emacs.d
The configuration of emacs.d

This configuration is my EMACS configuration. The original configuration comes 
from [binchen](https://github.com/redguardtoo/emacs.d)'s configuration. I've 
changed something and add some additional packages to it.

## Emacs version

It seems that Mac has install one inner Emacs. It has the version info as follows:
```
GNU Emacs 22.1.1
Copyright (C) 2007 Free Software Foundation, Inc.
GNU Emacs comes with ABSOLUTELY NO WARRANTY.
You may redistribute copies of Emacs
under the terms of the GNU General Public License.
For more information about these matters, see the file named COPYING.
```

Using **M-x emacs-version** to check the installed Emacs which gives the info as follows:
```
GNU Emacs 25.2.1 (x86_64-apple-darwin13.4.0, NS appkit-1265.21 Version 10.9.5 (Build 13F1911)) of 2017-04-21
```

## Added packages
* ipyhton
* markdown-model
* speedbar
* magit
  * Basic operation: Here's [one useful resource](https://emacs.stackexchange.com/questions/21597/using-magit-for-the-most-basic-add-commit-push)
  

**Note:** How to update files and folders remotely. [Here is one useful introduction to do it](https://stackoverflow.com/questions/8775850/how-do-i-add-files-and-folders-into-github-repos). 
* For the newest repository, we should download it or **clone** it correctly. For example, we might see the error like: *fatal: Not a git repository (or any of the parent directories): .git*. Remermber to do **git init** in the repository. (you may see *fatal: You are on a branch yet to be born*, but it doesn't matter)
* Synchronize repository
  * Adding files or folders: You can use **git add \<folder>\*** or **git add \<file\>**. If you have multiple files to add, you can use **git add \***
  * Running **git status** to check the info of the current repository
  * Running **git commit \<...\>** to make commits to the repository (e.g., **git commit - m 'Added README'**, or **git commit --all** etc)
  * Running **git push \<...\>** to push local repository contents to upate (e.g., **git push -u origin master**)