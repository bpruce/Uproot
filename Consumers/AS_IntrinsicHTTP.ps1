﻿$script = @"
Set objHTTP = CreateObject("Microsoft.XMLHTTP")
objHTTP.open "POST", "http://127.0.0.1/", False

objHTTP.setRequestHeader "User-Agent", "UprootIDS"

Dim outputString

outputString = outputString & "{""TargetEvent"":{"
outputString = outputString & """EventType"":""" & TargetEvent.Path_.Class & ""","
outputString = outputString & """TimeCreated"":""" & TargetEvent.Time_Created & ""","
outputString = outputString & """Server"":""" & TargetEvent.Path_.Server & ""","
outputString = outputString & """InstanceType"":""" & TargetEvent.TargetInstance.Path_.Class & ""","
outputString = outputString & """TargetInstance"":{"

For Each oProp in TargetEvent.TargetInstance.Properties_
     outputString = outputString & """" & oProp.Name & """:""" & oProp & ""","
Next

outputString = Left(outputString, Len(outputString) - 1)
outputString = outputString & "}"
outputString = outputString & "}}"

outputString = Replace(outputString, "\", "\\")
 
objHTTP.send outputString

Set objHTTP = Nothing
"@

$props = @{
    'Name' = 'AS_IntrinsicHTTP';
    'ScriptText' = $script;
}