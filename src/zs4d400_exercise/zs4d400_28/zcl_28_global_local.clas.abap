CLASS zcl_28_global_local DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_28_global_local IMPLEMENTATION.
    METHOD if_oo_adt_classrun~main.

        "2 ways to declare instance object
        DATA conn TYPE REF TO lcl_28_global_local.
        conn = NEW #(  ).

        DATA(conn2) = NEW lcl_28_global_local( ).

        "list of classes
        DATA conns TYPE TABLE OF REF TO lcl_28_global_local.

        "-> selector for instances, => selector for statics
        conn->carrier_id = 'LH'.
        conn->connection_id = '0400'.

        lcl_28_global_local=>conn_counter = 1234.

        conn2->carrier_id = 'FF'.
        conn2->connection_id = '4444'.

        APPEND conn TO conns.
        APPEND conn2 TO conns.

        DATA output TYPE TABLE OF string.
        LOOP AT conns INTO DATA(c).
            APPEND
                |index: { sy-tabix }, carrier_id: { c->carrier_id }, connection_id:{ c->connection_id }, conn_counter: { lcl_28_global_local=>conn_counter } |
            TO output.
        ENDLOOP.

        out->write( output ).

        "Set and Get methods
        conn->set_attributes( EXPORTING carrier_id = 'III' connection_id = '0500' ).
        conn2->set_attributes( EXPORTING carrier_id = 'POP' connection_id = '999' ).

        DATA conn2_e_carrier_id TYPE /dmo/carrier_id.
        DATA conn2_e_connection_id TYPE /dmo/connection_id.

        conn2->get_attributes( IMPORTING carrier_id = conn2_e_carrier_id connection_id = conn2_e_connection_id ).

        LOOP AT conns INTO DATA(cn).
            APPEND
                |index: { sy-tabix }, carrier_id: { cn->carrier_id }, connection_id:{ cn->connection_id }, conn_counter: { lcl_28_global_local=>conn_counter } |
            TO output.
        ENDLOOP.

        out->write( '------------' ).
        out->write( output ).
        out->write( '------------' ).
        out->write( |{ conn2_e_carrier_id }, { conn2_e_connection_id }| ).

    ENDMETHOD.
ENDCLASS.
