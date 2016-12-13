//
// Class POINT for GFX with overloading of arythmetical operations
//
// Written by Jorge Nunes <jorgenunes5+prog at gmail.com>
// www - http://harbour-project.org
//

#include "error.ch"
#include "hbclass.ch"

CREATE CLASS Point
DATA x
DATA y
METHOD New(x, y)
METHOD Plus( xArg ) OPERATOR "+"
METHOD Multiple( xArg ) OPERATOR "*"
METHOD Minus( xArg ) OPERATOR "-"
METHOD Divide( xArg ) OPERATOR "/"
METHOD Array( xArg ) OPERATOR "[]"
METHOD toString( )
METHOD Distance( xArg1, xArg2, xArg3, xArg4 )
METHOD DistanceCalc( aArg )
ENDCLASS 

METHOD new( x, y ) CLASS Point
hb_default( @x, 0 )
hb_default( @y, 0 )
::x := x
::y := y
RETURN Self

METHOD Plus( xArg ) CLASS Point
IF IsPoint( xArg )
   ::x += xArg:x
   ::y += xArg:Y
ELSEIF HB_ISNUMERIC( xArg )
   ::x += xArg
   ::y += xArg
ELSEIF HB_ISARRAY( xArg )
   IF len(xArg) == 2
      IF HB_ISNUMERIC( xArg[1] ) .and. HB_ISNUMERIC( xArg[2] )
         ::x += xArg[1]
         ::y += xArg[2]
      ELSE
         Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
      ENDIF
   ELSE
      Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
   ENDIF
ELSE
   Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
ENDIF
RETURN Self

METHOD Multiple( xArg ) CLASS Point
IF IsPoint( xArg )
   ::x *= xArg:x
   ::y *= xArg:Y
ELSEIF HB_ISNUMERIC( xArg )
   ::x *= xArg
   ::y *= xArg
ELSEIF HB_ISARRAY( xArg )
   IF len(xArg) == 2
      IF HB_ISNUMERIC( xArg[1] ) .and. HB_ISNUMERIC( xArg[2] )
         ::x *= xArg[1]
         ::y *= xArg[2]
      ELSE
         Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
      ENDIF
   ELSE
      Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
   ENDIF
ELSE
   Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
ENDIF
RETURN Self

METHOD Minus( xArg ) CLASS Point
IF IsPoint( xArg )
   ::x -= xArg:x
   ::y -= xArg:Y
ELSEIF HB_ISNUMERIC( xArg )
   ::x -= xArg
   ::y -= xArg
ELSEIF HB_ISARRAY( xArg )
   IF len(xArg) == 2
      IF HB_ISNUMERIC( xArg[1] ) .and. HB_ISNUMERIC( xArg[2] )
         ::x -= xArg[1]
         ::y -= xArg[2]
      ELSE
         Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
      ENDIF
   ELSE
      Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
   ENDIF
ELSE
   Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
ENDIF
RETURN Self

METHOD Divide( xArg ) CLASS Point
xArg := ::normalize( xArg )
IF IsPoint( xArg )
   ::x /= xArg:x
   ::y /= xArg:Y
ELSEIF HB_ISNUMERIC( xArg )
   ::x /= xArg
   ::y /= xArg
ELSEIF HB_ISARRAY( xArg )
   IF len(xArg) == 2
      IF HB_ISNUMERIC( xArg[1] ) .and. HB_ISNUMERIC( xArg[2] )
         ::x /= xArg[1]
         ::y /= xArg[2]
      ELSE
         Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
      ENDIF
   ELSE
      Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
   ENDIF
ELSE
   Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
ENDIF
RETURN Self

METHOD Array( nPos, xArg ) CLASS Point
if xArg == nil
   IF nPos == 1
      RETURN ::x
   ELSEIF nPos == 2
      RETURN ::y
   ELSE
      Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
   ENDIF
ELSE
   IF IsPoint( xArg )
      IF nPos == 1
         ::x := xArg:x
      ELSEIF nPos == 2
         ::y := xArg:y
      ELSE
         Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
      ENDIF
   ELSEIF HB_ISNUMERIC( xArg )
      IF nPos == 1
         ::x := xArg
      ELSEIF nPos == 2
         ::y := xArg
      ELSE
         Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
      ENDIF
   ELSE
      Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
   ENDIF
ENDIF
RETURN Self

METHOD toString( nLen, nDec ) CLASS Point
LOCAL cStr := "Point("
IF nLen == NIL
   cStr += Str( ::x )
   cStr += ", "
   cStr += Str( ::y )
ELSEIF nDec == NIL
   cStr += Str( ::x, nLen )
   cStr += ", "
   cStr += Str( ::y, nLen )
ELSE
   cStr += Str( ::x, nLen, nDec )
   cStr += ", "
   cStr += Str( ::y, nLen, nDec )
ENDIF
RETURN cStr + ")"

METHOD DistanceCalc( aArg ) CLASS Point
LOCAL x1, x2, y1, y2, px, py, nDot, nProj, nLen
x1 := aArg[1]
y1 := aArg[2]
x2 := aArg[3]
y2 := aArg[4]
px := ::x
py := ::y
x2 := x2 - x1
y2 := y2 - y1
px := px - x1
py := py - y1
nDot := px * x2 + py * y2
IF nDot <= 0.0
   nProj := 0
ELSE
   px := x2 - px
   py := y2 - py
   nDot := px * x2 + py * y2
   IF nDot <= 0.0
      nProj := 0
   ELSE
      nDot := nDot ^ 2 / (x2 ^ 2 + y2 ^ 2)
   ENDIF
ENDIF
nLen := px ^ 2 + py ^ 2 - nProj
IF nLen < 0
   nLen := 0
ENDIF
nDist := Sqrt( nLen )
RETURN nDist

METHOD Distance(  xArg1, xArg2, xArg3, xArg4 ) CLASS Point
LOCAL nDist := 0
IF HB_ISOBJECT( xArg ) .AND. xArg:className() = "LINE"
   nDist := ::DistanceCalc( xArg:oPb:x, xArg:oPb:y, xArg:oPe:x, xArg:oPe:y )
ELSEIF HB_ISARRAY( xArg ) .and. len(xArg) == 4
   IF HB_ISNUMERIC( xArg[1] ) .and. HB_ISNUMERIC( xArg[2] .and. HB_ISNUMERIC( xArg[3] ) .and. HB_ISNUMERIC( xArg[4] )
      nDist := ::DistanceCalc( xArg )
   ELSE
      Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
   ENDIF
ELSEIF HB_ISNUMERIC( xArg1 ) .and. HB_ISNUMERIC( xArg2 .and. HB_ISNUMERIC( xArg3 ) .and. HB_ISNUMERIC( xArg4 )
   nDist := ::DistanceCalc( {xArg1, xArg2, xArg3, xArg4} )
ELSE
   IF IsPoint( xArg )
      nDist := Sqrt( (::x - xArg:x)^2 + (::y - xArg:y)^2 )
   ELSEIF HB_ISARRAY( xArg )
      IF len(xArg) == 2
         IF HB_ISNUMERIC( xArg[1] ) .and. HB_ISNUMERIC( xArg[2] )
            nDist := Sqrt( (::x - xArg[1])^2 + (::y - xArg[2])^2 )
         ELSE
            Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
         ENDIF
      ELSE
         Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
      ENDIF
   ELSE
      Eval( ErrorBlock(), GenError( xArg, "POINT" ) )
   ENDIF
ENDIF
RETURN nDist

