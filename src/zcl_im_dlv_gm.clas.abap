class ZCL_IM_DLV_GM definition
  public
  final
  create public .

public section.

  interfaces /SCWM/IF_EX_DLV_GM_PROCESS .
  interfaces IF_BADI_INTERFACE .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IM_DLV_GM IMPLEMENTATION.


  METHOD /scwm/if_ex_dlv_gm_process~check_document.

    BREAK-POINT ID zewmdevbook_1g2f.

    "Check if goods issue is being processed
    CHECK iv_gmcat = /scwm/if_docflow_c=>sc_gi.
    LOOP AT it_dlv_item
    ASSIGNING FIELD-SYMBOL(<item>).
      "Check if current item is completely packed
      DATA(ls_status) = VALUE #( <item>-status[
        status_type = /scdl/if_dl_status_c=>sc_t_packing ] OPTIONAL ).
      IF ls_status IS INITIAL
      OR ls_status-status_value NE /scdl/if_dl_status_c=>sc_v_finished.
        "Delivery &1 item &2 not fully packed. GM not allowed.
        MESSAGE e001(zewmdevbook_1g2f)
        WITH <item>-docno <item>-itemno INTO DATA(lv_msg).
        DATA(ls_symsg) = /scwm/cl_dm_message_no=>get_symsg_fields( ).
        "Issue message
        co_message->add_message(
          iv_msgcat = /scdl/cl_dm_message=>sc_mcat_bus
          iv_doccat = <item>-doccat
          iv_docid  = <item>-docid
          iv_itemid = <item>-itemid
          is_symsg  = ls_symsg ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  method /SCWM/IF_EX_DLV_GM_PROCESS~CHECK_DOCUMENT_CANCEL.
  endmethod.


  method /SCWM/IF_EX_DLV_GM_PROCESS~CHECK_GR_BEFORE_PROD.
  endmethod.


  method /SCWM/IF_EX_DLV_GM_PROCESS~CHECK_GR_TYPE.
  endmethod.
ENDCLASS.
