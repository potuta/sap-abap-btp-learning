*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_28_database DEFINITION.

  PUBLIC SECTION.
    DATA airport_from_id TYPE /dmo/airport_from_id.
    DATA airport_to_id TYPE /dmo/airport_to_id.
    DATA airports TYPE TABLE OF /dmo/airport_from_id.

    DATA carrier_name TYPE /dmo/carrier_name.
    DATA connection_full TYPE TABLE OF /dmo/i_connection.

    METHODS:
        single_field
            RETURNING VALUE(r_output) TYPE string_table,

        cds_view
            IMPORTING
                i_carrier_id TYPE /dmo/carrier_id
                i_connection_id TYPE /dmo/connection_id
            RETURNING VALUE(r_output) TYPE string_table.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_28_database IMPLEMENTATION.

  METHOD single_field.

    SELECT SINGLE
        FROM /dmo/connection
        FIELDS airport_from_id
        WHERE carrier_id = 'LH'
        INTO @airport_from_id.

    SELECT SINGLE
        FROM /dmo/connection
        FIELDS airport_from_id, airport_to_id
        WHERE carrier_id = 'LH' AND connection_id = '0400'
        INTO ( @airport_from_id, @airport_to_id ).

    APPEND |Flight LH 400 departs from { airport_from_id }| TO r_output.
    APPEND |Flight LH 400 flies from {  airport_from_id } to { airport_to_id  }| TO r_output.

    SELECT SINGLE
        FROM /dmo/connection
        FIELDS airport_from_id
        WHERE carrier_id = 'XX' AND connection_id = '1234'
        INTO @airport_from_id.

    IF sy-subrc = 0.

        APPEND |--------| TO r_output.
        APPEND |Example 3:| TO r_output.
        APPEND |Flight XX 1234 departs from {  airport_from_id }.| TO r_output.

    ELSE.

        APPEND |--------| TO r_output.
        APPEND |Example 3:| TO r_output.
        APPEND |There is no flight XX 1234, but still airport_from_id = {  airport_from_id }!| TO r_output.

    ENDIF.


  ENDMETHOD.

  METHOD cds_view.

    "SELECT SINGLE INTO VARIABLES
    SELECT SINGLE
        FROM /dmo/i_connection
        FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
        WHERE AirlineID = @i_carrier_id AND ConnectionID = @i_connection_id
        INTO ( @airport_from_id, @airport_to_id, @carrier_name ).

    APPEND |airport_from_id = {  airport_from_id }, airport_to_id: { airport_to_id }, carrier_name: { carrier_name }| TO r_output.

    "SELECT SINGLE INTO CDS STRUCT
    SELECT SINGLE
        FROM /dmo/i_connection
        FIELDS AirlineID, ConnectionID, DepartureAirport, DestinationAirport, DepartureTime, ArrivalTime, Distance, DistanceUnit, \_Airline-Name AS carrier_name
        WHERE AirlineID = @i_carrier_id AND ConnectionID = @i_connection_id
        INTO @DATA(connection_single_full).

    APPEND |airport_from_id = { connection_single_full-AirlineID }, airport_to_id: { connection_single_full-DestinationAirport }, carrier_name: { connection_single_full-carrier_name }| TO r_output.

    "SELECT ALL INTO TABLE OF CDS
    SELECT *
        FROM /dmo/i_connection
        INTO TABLE @connection_full
        UP TO 100 ROWS.

    LOOP AT connection_full INTO DATA(c).
        APPEND |airport_from_id = { c-AirlineID }| TO r_output.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
