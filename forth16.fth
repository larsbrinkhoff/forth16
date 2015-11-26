require search.fth
only forth definitions  decimal

vocabulary forth16

1024 constant #data
create data  #data allot
variable dp  0 dp !

: mask   65535 and ;
: ?addr   dup -65536 and abort" Not a 16-bit address!" ;
: >host   ?addr data + ;
: mask:   >in @ >r : r> >in !  ' compile, postpone mask postpone ; ;

: h:   : ;
: h;   postpone ; ; immediate

also forth16 definitions

mask: +  mask: -  mask: *  mask: /

: here   dp @ ;
: allot   dp +! ;

: execute   >host @ execute ;
: does   does> @ execute ;
: :   create here dup ,  1 cells allot  does  :noname ;
h: ;   postpone ; swap >host ! ; immediate

h: create   create here ,  does> @ h;
h: variable   create 2 allot h;
h: does>   postpone does> postpone @ h; compile-only

h: '   ' >body @ h;
h: [']   ' postpone literal h; compile-only
h: >body h;

h: c@   >host c@ h;
h: c!   >host c! h;

\ Little endian versions.
h: @   dup c@  swap 1+ c@ 8 lshift + h;
h: !   2dup c!  swap 8 rshift swap  1+ c! h;

h: c,   here c!  1 allot h;
h: ,   here !  2 allot h;

only forth definitions
