CLASS zcl_28_hello_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_28_hello_world IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA numbers TYPE TABLE OF i.

    APPEND 33334 TO numbers.
    APPEND 233 TO numbers.

    out->write( numbers ).
    out->write( numbers[ 2 ] ).

    LOOP AT numbers INTO DATA(num).
        out->write( |Index: { sy-tabix } Content: { num }| ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
