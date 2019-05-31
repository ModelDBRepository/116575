dim info$(10,10)
run "java -jar C:\snnap8_1\SNNAP8_1.jar"
nomainwin
WindowWidth=310
WindowHeight = 100
UpperLeftX = 10
UpperLeftY = 10
button #interface.normal, "Normal Saline ([Ion2+]=1.8)", [normal], UL, 10, 10
button #interface.high, "25 mM Divalent Cations ([Ion2+]=25)", [high], UL, 10, 40
open "C Cell Model Interface" for window_nf as #interface
print #interface, "trapclose [quit]"
wait

[quit]
  'ask if the user wants to quit
  confirm "Quit?"; answer$
  if answer$ <> "yes" then wait 'abort quitting
  'now close the window
  close #interface
  end

[normal]
gosub [destroy]
call cp "1.8mM_ADP.vdg","ADP.vdg"
call cp "1.8mM_Na.vdg","Na.vdg"
call cp "1.8mM_Ca.vdg","Ca.vdg"
call cp "1.8mM_divalents.sm","divalents.sm"
wait

[high]
gosub [destroy]
call cp "25mM_ADP.vdg","ADP.vdg"
call cp "25mM_Na.vdg","Na.vdg"
call cp "25mM_Ca.vdg","Ca.vdg"
call cp "25mM_divalents.sm","divalents.sm"
wait

[destroy]
call rm "divalents.sm"
call rm "ADP.vdg"
call rm "Na.vdg"
call rm "Ca.vdg"
return

sub rm f$
if fileExists(f$) then kill f$
end sub

sub cp in$,out$
  open in$ for input as #original
  open out$ for output as #copy
  print #copy, input$(#original, lof(#original));
  close #original
  close #copy
end sub

function fileExists(fullPath$)
    files pathOnly$(fullPath$), filenameOnly$(fullPath$), info$()
    fileExists = val(info$(0, 0)) > 0
end function

function pathOnly$(fullPath$)
    pathOnly$ = fullPath$
    while right$(pathOnly$, 1) <> "\" and pathOnly$ <> ""
        pathOnly$ = left$(pathOnly$, len(pathOnly$)-1)
    wend
end function

function filenameOnly$(fullPath$)
    pathLength = len(pathOnly$(fullPath$))
    filenameOnly$ = right$(fullPath$, len(fullPath$)-pathLength)
end function
