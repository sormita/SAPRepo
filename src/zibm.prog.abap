REPORT ZIBM.
*---------------------------------------------------------
*PRODUCT INFORMATION ON ORDERS
*---------------------------------------------------------
*Sales Document                 VBAK  VBELN
*Sales Organization             VBAK  VKORG
*Distribution Channel           VBAK  VTWEG
*PO Number                      VBAK  BSTNK
*Sales Document Item            VBAP  POSNR
*Material Number                VBAP  MATNR
*Pricing Reference Material     VBAP  PMATN
*Plant (Own or External)        VBAP  WERKS
*Storage Location               VBAP  LGORT
*Material price group           VBAP  KONDM
*Volume rebate group            VBAP  BONUS
*-------------------------------------------------------------
TYPES: BEGIN OF TY_VBAK,
        VBELN TYPE VBAK-VBELN,
        VKORG TYPE VBAK-VKORG,
        VTWEG TYPE VBAK-VTWEG,
        BSTNK TYPE VBAK-BSTNK,
    END OF TY_VBAK.
TYPES:  BEGIN OF TY_VBAP,
         VBELN TYPE VBAP-VBELN,
         POSNR TYPE VBAP-POSNR,
         MATNR TYPE VBAP-MATNR,
         PMATN TYPE VBAP-PMATN,
         WERKS TYPE VBAP-WERKS,
         LGORT TYPE VBAP-LGORT,
         KONDM TYPE VBAP-KONDM,
         BONUS TYPE VBAP-BONUS,
    END OF TY_VBAP.
TYPES: BEGIN OF TY_MAIN,
        VBELN TYPE VBAK-VBELN,
        VKORG TYPE VBAK-VKORG,
        VTWEG TYPE VBAK-VTWEG,
        BSTNK TYPE VBAK-BSTNK,
        POSNR TYPE VBAP-POSNR,
        MATNR TYPE VBAP-MATNR,
        PMATN TYPE VBAP-PMATN,
        WERKS TYPE VBAP-WERKS,
        LGORT TYPE VBAP-LGORT,
        KONDM TYPE VBAP-KONDM,
        BONUS TYPE VBAP-BONUS,
    END OF TY_MAIN.
DATA: ITAB_VBAK TYPE STANDARD TABLE OF TY_VBAK,
                                       WA_VBAK TYPE TY_VBAK,
      ITAB_VBAP TYPE STANDARD TABLE OF TY_VBAP,
                                       WA_VBAP TYPE TY_VBAP,
      ITAB_MAIN TYPE STANDARD TABLE OF TY_MAIN,
                                       WA_MAIN TYPE TY_MAIN.
PARAMETERS: ERDAT TYPE ERDAT,
            vkorg type vkorg,
            vtweg type vtweg.

          SELECT VBELN
                 VKORG
                 VTWEG
                 BSTNK
            FROM VBAK INTO TABLE ITAB_VBAK
      WHERE ERDAT = ERDAT and
            vkorg = vkorg and
            vtweg = vtweg and
            vbtyp = "C".

If Itab_vbak is not initial.
          SELECT  VBELN
                  POSNR
                  MATNR
                  PMATN
                  WERKS
                  LGORT
                  KONDM
                  BONUS
            FROM VBAP INTO TABLE ITAB_VBAP
            FOR ALL ENTRIES IN ITAB_VBAK
            WHERE VBELN = ITAB_VBAK-VBELN.
            ENDIF.
LOOP AT ITAB_VBAP INTO WA_VBAP.
     READ TABLE ITAB_VBAK INTO WA_VBAK WITH KEY VBELN = WA_VBAP-VBELN.
     If SY-SUBRC = 0.
       ENDIF.
       WRITE: /
        WA_VBAK-VBELN,
        WA_VBAK-VKORG,
        WA_VBAK-VTWEG,
        WA_VBAK-BSTNK,
        WA_VBAP-POSNR,
        WA_VBAP-MATNR,
        WA_VBAP-PMATN,
        WA_VBAP-WERKS,
        WA_VBAP-LGORT,
        WA_VBAP-KONDM,
        WA_VBAP-BONUS.
        ENDLOOP.
