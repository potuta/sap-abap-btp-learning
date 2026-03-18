CLASS zcl_28_iterate DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_28_iterate IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    CONSTANTS max_count TYPE i VALUE 20.

    DATA numbers TYPE TABLE OF i.

    DO max_count TIMES.

        CASE sy-index. "built-in iteration counter
            WHEN 1.
                APPEND 0 TO numbers.
            WHEN 2.
                APPEND 1 TO numbers.
            WHEN OTHERS.
                APPEND numbers[ sy-index - 2 ] + numbers[ sy-index - 1 ] TO numbers.
        ENDCASE.

    ENDDO.

    DATA output TYPE TABLE OF string.
    DATA(counter) = 0.
    LOOP AT numbers INTO DATA(number).

        counter = counter + 1.

        APPEND |{ sy-tabix WIDTH = 4 ALIGN = LEFT }: { number WIDTH = 10 ALIGN = RIGHT }| TO output. "can use built-in index counter sy-tabix

    ENDLOOP.

    out->write( data = output name = |The first { max_count } Fibonacci Numbers| ).

  ENDMETHOD.

ENDCLASS.
