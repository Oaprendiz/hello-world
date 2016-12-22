#include "error.ch"

/* NOTE: In CA-Cl*pper 5.2/5.3 the cMethod argument seems to be ignored. */

FUNCTION __eInstVar52( oVar, cMethod, xValue, cType, nSubCode, xMin, xMax )

   LOCAL oError
   LOCAL lError

   IF ValType( xValue ) == cType
      lError := .F.
      IF xMin != NIL
         lError := !( xValue >= xMin )
      ENDIF
      /* NOTE: In CA-Cl*pper 5.2, xMin validation result is
               ignored when xMax != NIL. Harbour is doing the same. */
      IF xMax != NIL
         lError := !( xValue <= xMax )
      ENDIF
   ELSE
      lError := .T.
   ENDIF

   IF lError
      oError := ErrorNew()
      oError:description := hb_langErrMsg( EG_ARG )
      oError:gencode := EG_ARG
      oError:severity := ES_ERROR
      oError:cansubstitute := .T.
      oError:subsystem := oVar:className
#ifdef HB_CLP_STRICT
      HB_SYMBOL_UNUSED( cMethod )
#else
      oError:operation := cMethod
#endif
      oError:subcode := nSubCode
      oError:args := { xValue }
      xValue := Eval( ErrorBlock(), oError )
      IF !( ValType( xValue ) == cType )
         __errInHandler()
      ENDIF
   ENDIF

   RETURN xValue