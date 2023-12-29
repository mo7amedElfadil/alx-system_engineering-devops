# 0x02-shell_redirections
In this directory, we explore the use of shell redirections.
Shell redirections are a way to redirect the output of a command to a file, or to redirect the input of a command from a file.



## Description of script functionality
**[0-hello_world](0-hello_world)** - prints "Hello, World", followed by a new line to the standard output.

**[1-confused_smiley](1-confused_smiley)** - displays a confused smiley "(Ôo)

**[2-hellofile](2-hellofile)** - displays the content of the `/etc/passwd` file

**[3-twofiles](3-twofiles)** - displays the content of `/etc/passwd` and `/etc/hosts`

**[4-lastlines](4-lastlines)** - displays the last 10 lines of `/etc/passwd`

**[5-firstlines](5-firstlines)** - displays the first 10 lines of `/etc/passwd`

**[6-third_line](6-third_line)** - displays the third line of the file iacta

**[7-file](7-file)** - creates a file named exactly `\*\\'"Best School"\'\\*$\?\*\*\*\*\*:)` containing the text Best School

**[8-cwd_state](8-cwd_state)** - writes into the file `ls_cwd_content` the result of the command `ls -la`

**[9-duplicate_last_line](9-duplicate_last_line)** - duplicates the last line of the file `iacta`

**[10-no_more_js](10-no_more_js)** - deletes all the regular files (not the directories) with a `.js` extension that are present in the current directory and all its subfolders

**[11-directories](11-directories)** - counts the number of directories and sub-directories in the current directory

**[12-newest_files](12-newest_files)** - displays the 10 newest files in the current directory

**[13-unique](13-unique)** - takes a list of words as input and prints only words that appear exactly once

**[14-findthatword](14-findthatword)** - displays lines containing the pattern "root" from the file `/etc/passwd`

**[15-countthatword](15-countthatword)** - displays the number of lines that contain the pattern "bin" in the file `/etc/passwd`

**[16-whatsnext](16-whatsnext)** - displays lines containing the pattern "root" and 3 lines after them in the file `/etc/passwd`

**[17-hidethisword](17-hidethisword)** - displays all the lines in the file `/etc/passwd` that do not contain the pattern "bin"

**[18-letteronly](18-letteronly)** - displays all lines of the file `/etc/ssh/sshd_config` starting with a letter

**[19-AZ](19-AZ)** - replaces all characters `A` and `c` from input to `Z` and `e` respectively

**[20-hiago](20-hiago)** - removes all letters `c` and `C` from input

**[21-reverse](21-reverse)** - reverses its input

**[22-users_and_homes](22-users_and_homes)** - displays all users and their home directories, sorted by users

**[100-empty_casks](100-empty_casks)** - finds all empty files and directories in the current directory and all sub-directories

**[101-gifs](101-gifs)** - lists all the files with a `.gif` extension in the current directory and all its sub-directories

**[102-acrostic](102-acrostic)** - decodes acrostics that use the first letter of each line

**[103-the_biggest_fan](103-the_biggest_fan)** - parses web servers logs in TSV format as input and displays the 11 hosts or IP addresses which did the most requests

