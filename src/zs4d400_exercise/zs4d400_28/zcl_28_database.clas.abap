CLASS zcl_28_database DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_28_database IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(conn) = NEW lcl_28_database( ).
    out->write( conn->single_field( ) ).

    out->write( '---------' ).

    DATA(conn2) = NEW lcl_28_database( ).
    out->write( conn2->cds_view( i_carrier_id = 'LH' i_connection_id = '0400'  ) ).

  ENDMETHOD.

ENDCLASS.
