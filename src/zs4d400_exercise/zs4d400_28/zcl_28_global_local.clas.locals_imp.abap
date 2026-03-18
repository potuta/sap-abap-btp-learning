*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_28_global_local DEFINITION.

  PUBLIC SECTION.
    DATA carrier_id TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.
    CLASS-DATA conn_counter TYPE i.

    METHODS:
        set_attributes
            IMPORTING
                carrier_id TYPE /dmo/carrier_id OPTIONAL
                connection_id TYPE /dmo/connection_id,

        get_attributes
            EXPORTING
                carrier_id TYPE /dmo/carrier_id
                connection_id TYPE /dmo/connection_id.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_28_global_local IMPLEMENTATION.

    METHOD set_attributes.

        me->carrier_id = carrier_id.
        me->connection_id = connection_id.

    ENDMETHOD.


    METHOD get_attributes.

        carrier_id = me->carrier_id.
        connection_id = me->connection_id.

    ENDMETHOD.

ENDCLASS.
