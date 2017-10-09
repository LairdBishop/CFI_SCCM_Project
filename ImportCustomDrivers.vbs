' // ***************************************************************************
' // 
' // Copyright (c) Dell Inc.  All rights reserved.
' // 
' // Configuration Services Deployment Solution Accelerator
' //
' // File:      ImportCustomDrivers.vbs
' // 
' // Version:   1.0.0.0
' // Version:	1.0.0.1 - December 5, 2013 Tony Villarreal - add /forceunsigned
' // 
' // Purpose:   ConfigMgr Apply Drivers 
' // 
' // Author:    Greg Ramsey, Randy Deroeck, Tony Villarreal
' // 
' // ***************************************************************************

Const ForAppending = 8
Set WshShell = CreateObject("WScript.Shell") 
strSystemRoot = WshShell.ExpandEnvironmentStrings("%SystemRoot%")
Set objFSO = CreateObject("Scripting.FileSystemObject")

If Not objFSO.FolderExists(strSystemRoot & "\Temp\SMSTSLog\") Then
	objFSO.CreateFolder(strSystemRoot & "\Temp\SMSTSLog\")
End If

'Create Output Log
stroutputlog = strSystemRoot & "\temp\SMSTSLog\OSD_CustomDrivers.log"
Set objTextFile = objFSO.OpenTextFile(strOutputLog, ForAppending, True)


Log "ImportCustomDrivers - Start"
strComputer = "."
strScratchFolder = "Scratch"
strDriverFolder = "ExportedDrivers"
intReturnCode = 0
intFinalReturnCode = 0
Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set oShell = WScript.CreateObject("WScript.Shell")
Set colDisks = objWMIService.ExecQuery("Select * from Win32_LogicalDisk")

'enum each drive letter, and see if strDriverFolder exists in the root.
For Each objDisk In colDisks 
	'Check each drive letter to see if there is a 
	If objFSO.FolderExists(objDisk.DeviceID & "\" & strDriverFolder) Then
		'this will only run in a TS environment, so fail if we can't connect to sms.tsenvironment		
		Log vbTab & "Connecting to SMS.TSEnvironment"
		Set oTSEnv = CreateObject("Microsoft.SMS.TSEnvironment")
		If err.number <> 0 Then
			Log vbTAB & "Unable to connect to Microsoft.SMS.TSEnvironment"
			Log "ImportCustomDrivers - End"
                        objTextFile.Close
			WScript.quit(err.number)
		Else
			'prepare the command line, and launch the DISM command
			Log vbTAB & objDisk.DeviceID & "\" & strDriverFolder & " Exists, Importing drivers.."
			strCommand = CStr("Dism /image:" & oTSEnv("OSDTARGETSYSTEMDRIVE") & "\ /logpath:%windir%\temp\smstslog\DISMImportCustomDrivers.log /Add-Driver /ScratchDir:" & objDisk.DeviceID & "\" & strScratchFolder & " /driver:" & objDisk.DeviceID & "\" & strDriverFolder & " /recurse" & " /forceunsigned")
			Log vbTAB & "Preparing to run the following command: " & strCommand
			intReturnCode = oShell.Run(strCommand, 1, True)
			Log vbTAB & "Return Code = " & intReturnCode
			Log vbTAB & "Setting TS Variable OSDCustomDriversApplied = True"
			oTSEnv("OSDCustomDriversApplied") = "True"
		End If
	Else
		'no custom drivers exist
	End If
	' if more than one drive has the special folder, the DISM command will run more than once
	' if there are any failures, we are using this to capture if ANY of the exit code are <> 0
	' review the %windir%\temp\smstslog\DISMImportCustomDrivers.log for details
	If intReturnCode <> 0 Then intFinalReturnCode = intReturnCode
Next
Log "Final Return code = " & intFinalReturnCode
Log "ImportCustomDrivers - End"
objTextFile.Close
WScript.Quit(intFinalReturnCode)

'a simple logging subroutine
Sub Log(message)
	WScript.Echo message
	On Error Resume Next
	txtstatus.value = Trim(Replace((message & " " & Now()), vbTab, ""))
	On Error Goto 0
	message = Now() & "     " & message
	'
	' Log the given message
	'
	objTextFile.writeline(message)
End Sub
