# 0x05-processes_and_signals

Processes are the basic unit of execution in an operating system. They are created when a program is started, and they continue to run until they are terminated.
Signals are messages that are sent to processes to notify them of events.

This directory contains a number of scripts that explore the functionality of processes and signals.


## Description of script functionality

**[0-what-is-my-pid](0-what-is-my-pid)**

Displays its own PID.

**[1-list_your_processes](1-list_your_processes)**

Displays a list of currently running processes.

**[2-show_your_bash_pid](2-show_your_bash_pid)**

Displays lines containing the bash word, thus allowing us to know its PID.

**[3-show_your_bash_pid_made_easy](3-show_your_bash_pid_made_easy)**

Displays the PID, along with the process name, of processes whose name contain the word bash.

**[4-to_infinity_and_beyond](4-to_infinity_and_beyond)**

Creates an infinite loop.

**[5-dont_stop_me_now](5-dont_stop_me_now)**

Terminates the infinite process using kill.

**[6-stop_me_if_you_can](6-stop_me_if_you_can)**

Terminates the infinite process using pkill.

**[7-highlander](7-highlander)**

Creates an infinite loop that cannot be stopped using the SIGTERM signal using the trap command.


**[8-beheaded_process](8-beheaded_process)**

Kills the process 7-highlander by sending the SIGKILL signal.

**[100-process_and_pid_file](100-process_and_pid_file)**

-   Creates the file /var/run/myscript.pid containing its PID
-   Displays To infinity and beyond indefinitely
-   Displays I hate the kill command when receiving a SIGTERM signal
-   Displays Y U no love me?! when receiving a SIGINT signal
-   Deletes the file /var/run/myscript.pid and terminates itself when receiving a SIGQUIT or SIGTERM signal

**[101-manage_my_process](101-manage_my_process)**

Programs that are detached from the terminal and running in the background are called daemons or processes, need to be managed. The general minimum set of instructions is: start, restart and stop. The most popular way of doing so on Unix system is to use the init scripts.
This Bash (init) script 101-manage_my_process that manages manage_my_process. 

`manage_my_process`:
- Indefinitely writes I am alive! to the file /tmp/my_process
- In between every I am alive! message, the program should pause for 2 seconds

     
- When passing the argument start:
    - Starts manage_my_process
    - Creates a file containing its PID in /var/run/my_process.pid
    - Displays manage_my_process started
- When passing the argument stop:
    - Stops manage_my_process
    - Deletes the file /var/run/my_process.pid
    - Displays manage_my_process stopped
- When passing the argument restart
    - Stops manage_my_process
    - Deletes the file /var/run/my_process.pid
    - Starts manage_my_process
    - Creates a file containing its PID in /var/run/my_process.pid
    - Displays manage_my_process restarted
    - Displays Usage: manage_my_process {start|stop|restart} if any other argument or no argument is passed

**[102-zombie.c](102-zombie.c)**

Creates 5 zombie processes in C using fork().
