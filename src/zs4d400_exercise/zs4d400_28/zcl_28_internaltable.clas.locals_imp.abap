*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_28_internaltable DEFINITION.

  PUBLIC SECTION.

    TYPES:
        BEGIN OF st_conn,
            carrier_id TYPE /dmo/carrier_id,
            connection_id TYPE /dmo/connection_id,
            airport_from_id TYPE /dmo/airport_from_id,
            airport_to_id TYPE /dmo/airport_to_id,
            carrier_name TYPE /dmo/carrier_name,
        END OF st_conn.

    DATA conn TYPE TABLE OF st_conn.
    DATA sorted_conn TYPE SORTED TABLE OF st_conn WITH NON-UNIQUE KEY carrier_id connection_id.

    METHODS:
        get_out_all_conn
            RETURNING VALUE(r_output) TYPE string_table,

        get_out_conn
            IMPORTING
                i_carrier_id TYPE /dmo/carrier_id OPTIONAL
                i_connection_id TYPE /dmo/connection_id OPTIONAL
                i_airport_from_id TYPE /dmo/airport_from_id OPTIONAL
                i_airport_to_id TYPE /dmo/airport_to_id OPTIONAL
                i_carrier_name TYPE /dmo/carrier_name OPTIONAL

            RETURNING VALUE(r_output) TYPE string_table,

        get_out
            IMPORTING
                i_airport_from_id TYPE /dmo/airport_from_id
                i_airport_to_id TYPE /dmo/airport_to_id

            RETURNING VALUE(r_output) TYPE string_table,

        get_out_sorted
            IMPORTING
                i_carrier_id TYPE /dmo/carrier_id
                i_connection_id TYPE /dmo/connection_id

            RETURNING VALUE(r_output) TYPE string_table,

       add_new_row
            IMPORTING
                i_carrier_id TYPE /dmo/carrier_id
                i_connection_id TYPE /dmo/connection_id
                i_airport_from_id TYPE /dmo/airport_from_id
                i_airport_to_id TYPE /dmo/airport_to_id
                i_carrier_name TYPE /dmo/carrier_name

            RETURNING VALUE(r_output) TYPE string_table,

       modify_conn
            IMPORTING
               i_connection_id TYPE /dmo/connection_id OPTIONAL
               i_index TYPE i OPTIONAL

            RETURNING VALUE(r_output) TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_28_internaltable IMPLEMENTATION.

    METHOD get_out.

        SELECT AirlineID, ConnectionID, DepartureAirport, DestinationAirport, \_Airline-Name "SELECT * FIELDS <fields> not working due to different versions of SQL
        FROM /dmo/i_connection
        INTO TABLE @conn
        UP TO 100 ROWS.

*        DATA(conn2) = conn[ airport_from_id = i_airport_from_id airport_to_id = i_airport_to_id  ].
*
*        APPEND | carrier_id: { conn2-carrier_id }, connection_id: { conn2-connection_id }, airport_from_id: { conn2-airport_from_id }, airport_to_id: { conn2-airport_to_id }, carrier_name: { conn2-carrier_name } | TO r_output.

        LOOP AT conn INTO DATA(c) WHERE airport_from_id = i_airport_from_id AND airport_to_id = i_airport_to_id.

            APPEND |carrier_id: { c-carrier_id }, | &&
                   |connection_id: { c-connection_id }, | &&
                   |airport_from_id: { c-airport_from_id }, | &&
                   |airport_to_id: { c-airport_to_id }, | &&
                   |carrier_name: { c-carrier_name } |
            TO r_output.

        ENDLOOP.

    ENDMETHOD.

    METHOD get_out_sorted.

        SELECT AirlineID, ConnectionID, DepartureAirport, DestinationAirport, \_Airline-Name "SELECT * FIELDS <fields> not working due to different versions of SQL
        FROM /dmo/i_connection
        INTO TABLE @sorted_conn
        UP TO 100 ROWS.

        APPEND |---------carrier_id: { i_carrier_id }-----------| TO r_output.
        LOOP AT sorted_conn INTO DATA(c) WHERE carrier_id = i_carrier_id.

            APPEND |carrier_id: { c-carrier_id }, | &&
                   |connection_id: { c-connection_id }, | &&
                   |airport_from_id: { c-airport_from_id }, | &&
                   |airport_to_id: { c-airport_to_id }, | &&
                   |carrier_name: { c-carrier_name }|
            TO r_output.

        ENDLOOP.

        APPEND |---------connection_id: { i_connection_id }-----------| TO r_output.
        LOOP AT sorted_conn INTO DATA(c2) WHERE connection_id = i_connection_id.

            APPEND |carrier_id: { c2-carrier_id }, | &&
                   |connection_id: { c2-connection_id }, | &&
                   |airport_from_id: { c2-airport_from_id }, | &&
                   |airport_to_id: { c2-airport_to_id }, | &&
                   |carrier_name: { c2-carrier_name }|
            TO r_output.

        ENDLOOP.


        APPEND |---------carrier_id: { i_carrier_id } && connection_id: { i_connection_id }-----------| TO r_output.
        LOOP AT sorted_conn INTO DATA(c3) WHERE connection_id = i_connection_id AND carrier_id = i_carrier_id.

            APPEND |carrier_id: { c3-carrier_id }, | &&
                   |connection_id: { c3-connection_id }, | &&
                   |airport_from_id: { c3-airport_from_id }, | &&
                   |airport_to_id: { c3-airport_to_id }, | &&
                   |carrier_name: { c3-carrier_name }|
            TO r_output.

        ENDLOOP.

    ENDMETHOD.

    METHOD get_out_all_conn.

        LOOP AT conn INTO DATA(c).

            APPEND |carrier_id: { c-carrier_id }, | &&
                   |connection_id: { c-connection_id }, | &&
                   |airport_from_id: { c-airport_from_id }, | &&
                   |airport_to_id: { c-airport_to_id }, | &&
                   |carrier_name: { c-carrier_name }|
            TO r_output.

        ENDLOOP.

    ENDMETHOD.

    METHOD get_out_conn.

       LOOP AT conn INTO DATA(c).

            CHECK i_carrier_id      IS INITIAL OR c-carrier_id      = i_carrier_id.
            CHECK i_connection_id   IS INITIAL OR c-connection_id   = i_connection_id.
            CHECK i_airport_from_id IS INITIAL OR c-airport_from_id = i_airport_from_id.
            CHECK i_airport_to_id   IS INITIAL OR c-airport_to_id   = i_airport_to_id.
            CHECK i_carrier_name    IS INITIAL OR c-carrier_name    = i_carrier_name.

            APPEND |carrier_id: { c-carrier_id }, | &&
                   |connection_id: { c-connection_id }, | &&
                   |airport_from_id: { c-airport_from_id }, | &&
                   |airport_to_id: { c-airport_to_id }, | &&
                   |carrier_name: { c-carrier_name }|
            TO r_output.

        ENDLOOP.

    ENDMETHOD.

    METHOD add_new_row.

        DATA new_row_conn LIKE LINE OF conn.

        new_row_conn = VALUE #(
                                carrier_id = i_carrier_id
                                connection_id = i_connection_id
                                airport_from_id = i_airport_from_id
                                airport_to_id = i_airport_to_id
                                carrier_name = i_carrier_name
                              ).

        APPEND new_row_conn TO conn.

*        APPEND VALUE #(
*                        carrier_id = i_carrier_id
*                        connection_id = i_connection_id
*                        airport_from_id = i_airport_from_id
*                        airport_to_id = i_airport_to_id
*                        carrier_name = i_carrier_name
*                      )
*        TO conn.

    ENDMETHOD.

    METHOD modify_conn.

*        DATA modify_row_conn LIKE LINE OF conn.
*
*        modify_row_conn = conn[ connection_id = i_connection_id ] .

        LOOP AT conn INTO DATA(c) WHERE connection_id IS NOT INITIAL AND connection_id = i_connection_id.

            c-airport_from_id = 'SSS'.

            MODIFY conn FROM c.

        ENDLOOP.

    ENDMETHOD.

ENDCLASS.
