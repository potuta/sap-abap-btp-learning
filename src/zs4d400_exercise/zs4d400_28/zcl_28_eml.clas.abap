CLASS zcl_28_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_28_eml IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA(conn) = NEW lcl_28_eml(  ).
    out->write( conn->tbl1_get_out( i_agency_id = '070005' ) ).
*    out->write( conn->tbl1_get_out( i_country_code = 'US' ) ).

    out->write( conn->tbl1_update( i_agency_id = '070005' i_name = 'Hello world 28' ) ).
    out->write( conn->tbl1_get_out( i_agency_id = '070005' ) ).


    out->write( conn->tbl1_get_out( i_country_code = 'DE' ) ).

  ENDMETHOD.
ENDCLASS.
