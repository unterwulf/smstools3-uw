m4_defun([SMSD_SUMMARY],
[AS_ECHO_N([" * $1"])
AS_IF([$2], [AS_ECHO([$3])], [AS_ECHO([$4])])dnl
])# SMSD_SUMMARY
