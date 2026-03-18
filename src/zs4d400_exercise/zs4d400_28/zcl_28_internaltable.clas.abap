CLASS zcl_28_internaltable DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_28_internaltable IMPLEMENTATION.

    METHOD if_oo_adt_classrun~main.

        DATA(conn) = NEW lcl_28_internaltable( ).
        out->write( conn->get_out( i_airport_from_id = 'SFO' i_airport_to_id = 'SIN' ) ).
        out->write( '--------' ).
        out->write( conn->get_out_sorted( i_carrier_id = 'SQ' i_connection_id = '0001' ) ).
        out->write( '----Before Added new row:----' ).
        out->write( '----All:----' ).
        out->write( conn->get_out_all_conn( ) ).
        out->write( '----Specific:----' ).
        out->write( conn->get_out_conn( i_airport_from_id = 'SFO' i_airport_to_id = 'SIN' ) ).
        out->write( '----After Added new row:----' ).
        out->write( '----All:----' ).
        out->write( conn->add_new_row( i_carrier_id = 'SQ' i_connection_id = '0011' i_airport_from_id = 'SFO' i_airport_to_id = 'SIN' i_carrier_name = 'LMAO Airlines' ) ).
        out->write( conn->get_out_all_conn( ) ).
        out->write( '----Specific:----' ).
        out->write( conn->get_out_conn( i_airport_from_id = 'SFO' i_airport_to_id = 'SIN' ) ).


        out->write( '--------' ).
        out->write( conn->modify_conn( i_connection_id = '0011' ) ).
        out->write( conn->get_out_conn( i_connection_id = '0011' ) ).
        out->write( '--------' ).
    ENDMETHOD.

ENDCLASS.
