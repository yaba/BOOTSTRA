IF %MODE%==CLEAN GOTO :EOF

CALL RPN! _%IP%_2+
SET IP=%RESULT%

IF %MODE%==COUNT GOTO :EOF

CALL EMITBYTE 212
CALL EMITBYTE 10

:EOF
