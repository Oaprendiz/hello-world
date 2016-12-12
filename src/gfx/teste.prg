#include "error.ch"
#include "hbclass.ch"

PROCEDURE Main()
SetMode( 40, 100 )
altd()
a := Point():New()
b := Point():New(10,15)

? a, b
? a + b
a := b
? a[1]
? a[2]
a[1] := 5
a[2] := 5
? a[1]
? a[2]
? a:toString()
? a:toString(3)
? a:toString(5,2)

a := {0}
? a - b
inkey(0)
return
