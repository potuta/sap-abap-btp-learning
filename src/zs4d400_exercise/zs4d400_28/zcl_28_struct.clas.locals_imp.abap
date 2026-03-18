*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_28_struct DEFINITION.

  PUBLIC SECTION.


    METHODS:
        get_output
            IMPORTING
                i_carrier_id TYPE /dmo/carrier_id
                i_connection_id TYPE /dmo/connection_id
            RETURNING VALUE(r_output) TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_28_struct IMPLEMENTATION.

  METHOD get_output.

    DATA connection_full TYPE /DMO/I_Connection.

    SELECT SINGLE
     FROM /dmo/I_Connection
   FIELDS AirlineID, ConnectionID, DepartureAirport, DestinationAirport,
          DepartureTime, ArrivalTime, Distance, DistanceUnit
    WHERE AirlineId    = 'LH'
      AND ConnectionId = '0400'
     INTO @connection_full.

    APPEND |airport_from_id = {  connection_full-DepartureAirport }, airport_to_id: { connection_full-DestinationAirport } | TO r_output.

    "Local Structure
    TYPES:
        BEGIN OF st_conn,
            airport_from_id TYPE /dmo/airport_from_id,
            airport_to_id TYPE /dmo/airport_to_id,
            carrier_name TYPE /dmo/carrier_name,
        END OF st_conn.

    DATA conn TYPE st_conn.

    SELECT SINGLE
        FROM /dmo/i_connection
        FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
        WHERE AirlineID = @i_carrier_id AND ConnectionID = @i_connection_id
        INTO @conn.

    APPEND |airport_from_id = {  conn-airport_from_id }, airport_to_id: { conn-airport_to_id }, carrier_name: { conn-carrier_name }| TO r_output.

    "Nested Structure
    TYPES:
        BEGIN OF st_nested,
            airport_from_id TYPE /dmo/airport_from_id,
            airport_to_id TYPE /dmo/airport_to_id,
            message TYPE symsg,
            carrier_name TYPE /dmo/carrier_name,
        END OF st_nested.

    DATA conn_nested TYPE st_nested.
    conn_nested-message-msgty = 'E'.

    APPEND |airport_from_id = {  conn_nested-airport_from_id }, airport_to_id: { conn_nested-airport_to_id }, carrier_name: { conn_nested-carrier_name }, message-msgty: { conn_nested-message-msgty }| TO r_output.

  ENDMETHOD.

ENDCLASS.
