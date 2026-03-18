CLASS zcl_28_struct DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_28_struct IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(conn) = NEW lcl_28_struct(  ).
    out->write( conn->get_output( i_carrier_id = 'LH' i_connection_id = '0400' ) ).

  ENDMETHOD.

ENDCLASS.
