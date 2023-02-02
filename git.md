
## git
Installation.
`$ sudo apt-get install git`
`$ git --version`

`$ git config --global user.name "You Zhou"`
`$ git config --global user.email zhouyou.xy@gmail.com`

Caching your GitHub password in Git
```
# set git to use the credential memory cache
$ git config --global credential.helper cache
# set the cache to timeout after 10 hour (setting is in seconds)
$ git config --global credential.helper 'cache --timeout 36000'
```
For Windows, run `git config --global credential.helper wincred`


Connect to github via either ssh or httpps.
### register a new pc to github via ssh
#### Generating a new SSH key
1.  Open Terminal.
2.  Paste the text below, substituting in your GitHub email address.
	`$ ssh-keygen -t rsa -b 4096 -C "zhouyou.xy@gmail.com"`
	This creates a new ssh key, using the provided email as a label.
    `Generating public/private rsa key pair.`
    
3.  When you're prompted to "Enter a file in which to save the key," press Enter. This accepts the default file location.
    `Enter a file in which to save the key (/home/_you_/.ssh/id_rsa): [Press enter]`
    
4.  At the prompt, type a secure passphrase. For more information, see ["Working with SSH key passphrases"](https://help.github.com/articles/working-with-ssh-key-passphrases).
    
    Enter passphrase (empty for no passphrase): _[Type a passphrase]_
    Enter same passphrase again: _[Type passphrase again]_

#### Adding your SSH key to the ssh-agent
Before adding a new SSH key to the ssh-agent to manage your keys, you should have [checked for existing SSH keys](https://help.github.com/articles/checking-for-existing-ssh-keys) and [generated a new SSH key](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#generating-a-new-ssh-key).

1.  Start the ssh-agent in the background.
    `$ eval "$(ssh-agent -s)"`
    `Agent pid 59566`
    
2.  Add your SSH private key to the ssh-agent. If you created your key with a different name, or if you are adding an existing key that has a different name, replace _id_rsa_ in the command with the name of your private key file.
    `$ ssh-add ~/.ssh/id_rsa`
    
3.  [Add the SSH key to your GitHub account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account).


$ git status

$ git checkout .

$ git clean -f # remove untracked files
$ git clean -fd # remove untracked directories

$ git reset --hard

$ git diff
$ git diff --staged

$ git commit --patch

$ git log --oneline --decorate

$ git commit --amend  # Reword the last commit message
```git
	# This can be useful to include files you forgot to track, or include modifications to the files you just commited. To do so, you can add the changes and then perform the amend:
	$ git add README.md config/routes.rb
	$ git rm notes.txt
	$ git commit --amend
```

### git branch names
**Dos and Don’ts in Branch Names**
Branch names must conform to a few simple rules.
-   You can use the forward slash (/) to create a hierarchical name scheme. However, the name cannot end with a slash.
-   The name cannot start with a minus sign (-).
-   No slash-separated component can begin with a dot (.). A branch name such as  _feature/.new_  is invalid.
-   The name cannot contain two consecutive dots (..) anywhere.
-   Further, the name cannot contain:
    -   Any space or other whitespace character
    -   A character that has special meaning to Git, including the tilde (~), caret (^), colon (:), question mark (?), asterisk (*), and open bracket ([).
    -   An ASCII control character, which is any byte with a value lower than \040 octal, or the DEL character (\177 octal)

These branch name rules are enforced by the `git check-ref-format`  plumbing command, and they are designed to ensure that each branch name is both easily typed and usable as a filename within the .git directory and scripts.

#### recommended branch naming conventions [stackoverflow ref](https://stackoverflow.com/questions/273695/git-branch-naming-best-practices)
1.  Use grouping tokens (words) at the beginning of your branch names.
2.  Define and use short lead tokens to differentiate branches in a way that is meaningful to your workflow.
3.  Use slashes to separate parts of your branch names.
4.  Do not use bare numbers as leading parts.
5.  Avoid long descriptive names for long-lived branches.

#### a few well-defined group names
* release/
* feature/
* fix/
* refactor/
* test/

##### With group structure in place, you can use git's pattern matching options:
```bash
$ git branch --list "test/*"
test/foo
test/frabnotz

$ git branch --list "*/foo"
new/foo
test/foo
ver/foo
```

##### tab expansion/command completion with slashs
```bash
$ git checkout new<TAB>
Menu:  new/frabnotz   new/foo   new/bar

$ git checkout foo<TAB>
Menu:  new/foo   test/foo   ver/foo
```