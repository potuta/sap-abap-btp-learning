CLASS LHC_ZR_28FLIGHT DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR Zr28flight
        RESULT result,
      CheckSemanticKey FOR VALIDATE ON SAVE
            IMPORTING keys FOR Zr28flight~CheckSemanticKey,
      GetCities FOR DETERMINE ON SAVE
            IMPORTING keys FOR Zr28flight~GetCities.
ENDCLASS.

CLASS LHC_ZR_28FLIGHT IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD CheckSemanticKey.

    DATA read_keys TYPE TABLE FOR READ IMPORT zr_28flight.
    DATA result TYPE TABLE FOR READ RESULT zr_28flight.

    "implicit mapping CORRESPONDING, can use VALUE for explicit mapping
    read_keys = CORRESPONDING #( keys ).

    READ ENTITIES OF zr_28flight IN LOCAL MODE
    ENTITY zr28flight
    ALL FIELDS "FIELDS ( CarrierID ConnectionID ) is also valid to get only specific fields
    WITH read_keys "can also do CORRESPONDING #( keys ) directly
    RESULT result.

*    DATA c TYPE LINE OF result.

    "check for potential duplicating fields in database and draft database. Time complexity = O(N)
    LOOP AT result INTO DATA(c).

        SELECT uuid FROM z28flight
*        FIELDS uuid
        WHERE carrier_id = @c-CarrierID
        AND connection_id = @c-ConnectionID
        AND uuid <> @c-uuid

        UNION

        SELECT uuid FROM z28flight_d
*        FIELDS uuid
        WHERE carrierid = @c-CarrierID
        AND connectionid = @c-ConnectionID
        AND uuid <> @c-uuid

        INTO TABLE @DATA(check_result).

        IF check_result IS NOT INITIAL.

            "manual reported-* filling for older versions of RAP S/4HANA ≤ 2021
            DATA(message) = me->new_message(
                                id = 'ZS4D400'
                                number = '001'
                                severity = ms-error
                                v1 = c-CarrierID
                                v2 = c-ConnectionID ).

            DATA reported_record LIKE LINE OF reported-zr28flight.
            reported_record-%tky = c-%tky.
            reported_record-%msg = message.
            reported_record-%element-carrierid = if_abap_behv=>mk-on.
            reported_record-%element-connectionid = if_abap_behv=>mk-on.
            APPEND reported_record TO reported-zr28flight.

            DATA failed_record LIKE LINE OF failed-zr28flight.
            failed_record-%tky = c-%tky.
            APPEND failed_record TO failed-zr28flight.

            "target apparantly works for new versions of RAP S/4HANA 2022+
*            DATA(message2) = me->new_message(
*                                  id       = 'ZS4D400'
*                                  number   = '002'
*                                  severity = ms-error
*                                  target   = VALUE #(
*                                    ( %element-CarrierID    = if_abap_behv=>mk-on )
*                                    ( %element-ConnectionID = if_abap_behv=>mk-on )
*                                  )
*                                ).

        ENDIF.
    ENDLOOP.

    "faster database lookup. Time complexity = O(1) constant lookup
*    DATA check_result1 TYPE TABLE OF z28flight-uuid.
*    DATA check_result2 TYPE TABLE OF z28flight_d-uuid.
*
*    IF result IS NOT INITIAL.
*      SELECT uuid
*        FROM z28flight
*        FOR ALL ENTRIES IN @result
*        WHERE carrier_id    = @result-CarrierID
*          AND connection_id = @result-ConnectionID
*          AND uuid          <> @result-uuid
*        INTO TABLE @check_result1.
*
*      SELECT uuid
*        FROM z28flight_d
*        FOR ALL ENTRIES IN @result
*        WHERE carrierid     = @result-CarrierID
*          AND connectionid  = @result-ConnectionID
*          AND uuid          <> @result-uuid
*        INTO TABLE @check_result2.
*
*      " Combine tables (remove duplicates if needed)
*      DATA check_result3 TYPE SORTED TABLE OF z28flight-uuid WITH UNIQUE KEY table_line.
*
*      APPEND LINES OF check_result1 TO check_result3.
*      APPEND LINES OF check_result2 TO check_result3.
*
*    ENDIF.
*
*
*    IF check_result3 IS NOT INITIAL.
*        DATA(message2) = me->new_message(
*                            id = 'ZS4D400'
*                            number = '002'
*                            severity = ms-error
*                            v1 = result[ 1 ]-CarrierID
*                            v2 = result[ 1 ]-ConnectionID ).
*    ENDIF.


  ENDMETHOD.

  METHOD GetCities.

    DATA result TYPE TABLE FOR READ RESULT zr_28flight.

    READ ENTITIES OF zr_28flight IN LOCAL MODE
    ENTITY zr28flight
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT result.

    LOOP AT result INTO DATA(c).

        SELECT SINGLE
        FROM /dmo/i_airport
        FIELDS City, CountryCode
        WHERE AirportID = @c-AirportFromID
        INTO ( @c-CityFrom, @c-CountryFrom ).

        SELECT SINGLE
        FROM /dmo/i_airport
        FIELDS City, CountryCode
        WHERE AirportID = @c-AirportToID
        INTO @DATA(tempTo).

        c-CityTo = tempTo-City.
        c-CountryTo = tempTo-CountryCode.

        MODIFY result FROM c.

    ENDLOOP.

    DATA update TYPE TABLE FOR UPDATE zr_28flight.
    update = CORRESPONDING #( result ).

    MODIFY ENTITIES OF zr_28flight IN LOCAL MODE
    ENTITY zr28flight
    UPDATE FIELDS ( CityFrom CountryFrom CityTo CountryTo )
    WITH update
    REPORTED DATA(reported_records).

    reported-zr28flight = CORRESPONDING #( reported_records-zr28flight ).

  ENDMETHOD.

ENDCLASS.
