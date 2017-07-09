# my_emacs.d
The configuration of emacs.d

This configuration is my EMACS configuration. The original configuration comes 
from [binchen](https://github.com/redguardtoo/emacs.d)'s configuration. I've 
changed something and add some additional packages to it.

**Note:** How to update files and folders remotely. [Here is one useful introduction to do it](https://stackoverflow.com/questions/8775850/how-do-i-add-files-and-folders-into-github-repos). 
* For the newest repository, we should download it or **clone** it correctly. For example, we might see the error like: *fatal: Not a git repository (or any of the parent directories): .git*. Remermber to do **git init** in the repository so that you may see *fatal: You are on a branch yet to be born*.
* 

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
*GNU Emacs 25.2.1 (x86_64-apple-darwin13.4.0, NS appkit-1265.21 Version 10.9.5 (Build 13F1911)) of 2017-04-21*
```