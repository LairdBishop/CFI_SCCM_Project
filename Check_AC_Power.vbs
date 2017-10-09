strComputer="."
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set colItems = objWMIService.ExecQuery( "Select * from Win32_Battery")
if colItems.count = 1 Then
For Each objItem in colItems
If objItem.BatteryStatus = 1 then
MsgBox vbcrlf & vbcrlf & vbcrlf & vbcrlf & _
"System is running from battery. Please connect this system to a power source before pressing
OK." ,vbcritical, "Bitlocker Partition Creation Requirement - Power check for notebook."
End If
Next
End If