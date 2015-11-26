include ../forth16/forth16.fth

: fail   ." FAIL: " source type cr abort ;
: assert=   <> if fail then ;

only forth also forth16

65534 2 + 0 assert=
0 1 - 65535 assert=

variable x
42 x !
x @ 42 assert=

create y  2 allot
65535 ' y >body !
y @ 65535 assert=

: foo   refill ;
' foo execute fail

.( SUCCESS ) cr
bye
