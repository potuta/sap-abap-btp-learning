CLASS zcl_cyl_hello_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cyl_hello_world IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA s TYPE string VALUE 'Hello World'.
    DATA i TYPE i VALUE 0.

    DO.
        out->write( |{ i }: { s }| ).
        i = i + 1.

        IF i > 10.
            EXIT.
        ENDIF.
    ENDDO.

    out->write( 'slkdafj' ).

    DO 10 TIMES.
        out->write( |{ i }: { s }| ).
    ENDDO.

  ENDMETHOD.
ENDCLASS.
