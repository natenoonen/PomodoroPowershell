# PomodoroPowershell
Pomodoro technique implemented in Powershell

#Usage
Start-PomodoroList

#Workflow
Parses the task list in order.  If you say yes, starts a timer and ends with a Burnt Toast notification.
If you say no, skips the task and adds to your backlog.

#Task List
A comma separated list of tasks.  Currently hardcoded.  Looks like this:
Lift,10
Clean Office,10

#Prerequisites
Install-Module -Name BurntToast

