# Backlog:
# set Slack to not notify
# Parse a day of inputs: Item, length and use interactive to move to next day, log distraction, complete
# Set other notifications

Function Start-PomodoroTimer {
Param(
$Minutes = 25,
$seconds = 60 * $Minutes,
$Task = 'Empty Task',
$sb = {
    Start-Sleep -Seconds $using:seconds
    $log = ([datetime]::Now.ToString() + " : End Task")
    Add-Content -Path "C:\Users\nate.noonen\Documents\Work\pomodoroLog.txt" $log
    New-BurntToastNotification -Text 'Timer complete. Take a break and get back to it' -SnoozeandDismiss -Sound SMS

})
    $log = ([datetime]::Now.ToString() + " : Start " + $Task)
    Add-Content -Path "C:\Users\nate.noonen\Documents\Work\pomodoroLog.txt" $log
    Start-Job -Name 'Pomodoro Timer' -ScriptBlock $sb -Argumentlist $seconds
}

Function Start-PomodoroList 
{
    $title    = 'Continue'
    $choices  = '&Yes', '&No'
    Get-Content C:\Users\nate.noonen\Documents\Work\pomodoroTasks.txt | Set-Content C:\Users\nate.noonen\Documents\Work\tmpPomodoroTasks.txt
    foreach($line in Get-Content -Path C:\Users\nate.noonen\Documents\Work\pomodoroTasks.txt) 
    {
        (Get-Content C:\Users\nate.noonen\Documents\Work\tmpPomodoroTasks.txt | Where-Object { -not $_.Contains($line) }) | Set-Content C:\Users\nate.noonen\Documents\Work\tmpPomodoroTasks.txt
        $taskLine = $line.Split(",")
        $minutes = [int]$taskLine[1]
        $task = $taskLine[0]
        $sleep = $minutes * 60
        $question = "Would you like to start the task " + $task + " for " + $taskLine[1] +  " minutes?"

        $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
        if ($decision -eq 0) {
            Start-PomodoroTimer -Minutes $minutes -Task $task
            Start-Sleep -Seconds $sleep
        }
        else{
            Add-Content C:\Users\nate.noonen\Documents\Work\tmpPomodoroTasks.txt $line
        }
    }
    Get-Content C:\Users\nate.noonen\Documents\Work\tmpPomodoroTasks.txt | Set-Content C:\Users\nate.noonen\Documents\Work\pomodoroTasks.txt
    Remove-Item C:\Users\nate.noonen\Documents\Work\tmpPomodoroTasks.txt
}

Start-PomodoroList


# Setup:
# Install-Module -Name BurntToast