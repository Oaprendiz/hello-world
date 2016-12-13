//
// Class LINE for GFX with overloading of arythmetical operations
//
// Written by Jorge Nunes <jorgenunes5+prog at gmail.com>
// www - http://harbour-project.org
//

#include "error.ch"
#include "hbclass.ch"

CREATE CLASS Line
DATA oPb
DATA oPe
METHOD New(xArg1, xArg2, xArg3, xArg4)
ENDCLASS 

METHOD new( xArg1, xArg2, xArg3, xArg4 ) CLASS Line
hb_default( @xArg1, 0 )
hb_default( @xArg2, 0 )
hb_default( @xArg3, 0 )
hb_default( @xArg4, 0 )
::oPb := Point():New(xArg1, xArg2)
::oPe := Point():New(xArg3, xArg4)
RETURN Self

