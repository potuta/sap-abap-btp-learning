*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_28_eml DEFINITION.

  PUBLIC SECTION.
    DATA:
        tbl1_input_keys TYPE TABLE FOR READ IMPORT /dmo/i_agencytp,
        tbl1_result_tab TYPE TABLE FOR READ RESULT /dmo/i_agencytp,
        tbl1_update_tab TYPE TABLE FOR UPDATE /dmo/i_agencytp.

    METHODS:
        tbl1_get_out
            IMPORTING
                i_agency_id TYPE /dmo/agency_id OPTIONAL
                i_country_code TYPE land1 OPTIONAL
            RETURNING VALUE(r_output) TYPE string_table,

        tbl1_update
            IMPORTING
                i_agency_id TYPE /dmo/agency_id
                i_name TYPE /dmo/agency_name OPTIONAL
                i_country_code TYPE land1 OPTIONAL
            RETURNING VALUE(r_output) TYPE string_table.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_28_eml IMPLEMENTATION.

    METHOD tbl1_get_out.

        IF i_agency_id IS NOT INITIAL.
            tbl1_input_keys = VALUE #( ( agencyID = i_agency_id ) ).
        ELSE.
            SELECT *
            FROM /dmo/i_agencytp
            WHERE countrycode = @i_country_code
            INTO TABLE @DATA(lt_ids).

            "inline loop
            tbl1_input_keys = VALUE #(
                FOR ls_id in lt_ids
                ( agencyid = ls_id-AgencyID )
            ).

            "loop at
*            LOOP AT lt_ids INTO DATA(c).
*
*                APPEND VALUE #( agencyid = c-AgencyID ) TO tbl1_input_keys.
*
*            ENDLOOP.
        ENDIF.

        READ ENTITIES OF /dmo/i_agencytp
            ENTITY /dmo/agency
            ALL FIELDS
            WITH tbl1_input_keys
            RESULT tbl1_result_tab.

        LOOP AT tbl1_result_tab INTO DATA(c).

            APPEND
                |agency_id: { c-AgencyID }, | &&
                |name: { c-name }, | &&
                |country_code: { c-CountryCode }, |
            TO r_output.

        ENDLOOP.


    ENDMETHOD.

    METHOD tbl1_update.

        "key fields such as agencyid are mandatory, non-key fields are optional

       IF i_name IS NOT INITIAL.
            tbl1_update_tab = VALUE #( ( agencyid = i_agency_id name = i_name ) ).

            MODIFY ENTITIES OF /dmo/i_agencytp
            ENTITY /dmo/agency
            UPDATE FIELDS ( name )
            WITH tbl1_update_tab.

       ELSE.
            SELECT *
            FROM /dmo/i_agencytp
            WHERE countrycode = @i_country_code
            INTO TABLE @DATA(lt_ids).

            "inline loop
            tbl1_update_tab = VALUE #(
                FOR ls_id IN lt_ids
                ( agencyid = ls_id-AgencyID countrycode = i_country_code )
            ).

            MODIFY ENTITIES OF /dmo/i_agencytp
            ENTITY /dmo/agency
            UPDATE FIELDS ( countrycode )
            WITH tbl1_update_tab.

       ENDIF.

    ENDMETHOD.

ENDCLASS.
