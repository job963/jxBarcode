[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign box=" "}]

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>

[{assign var="alertSound" value=$oViewConf->getModuleUrl('jxbarcode','out/admin/audio/alert.mp3') }]
[{assign var="questionSound" value=$oViewConf->getModuleUrl('jxbarcode','out/admin/audio/question.mp3') }]

[{assign var="cssFilePath" value=$oViewConf->getModulePath('jxbarcode','out/admin/src/oxprobs.css') }]
[{php}] 
    $sCssFilePath = $this->get_template_vars('cssFilePath');;
    $sCssTime = filemtime( $sCssFilePath );
    $this->assign('cssTime', $sCssTime);
[{/php}]
[{assign var="cssFileUrl" value=$oViewConf->getModuleUrl('jxbarcode','out/admin/src/jxbarcode.css') }]
[{assign var="cssFileUrl" value="$cssFileUrl?$cssTime" }]
<link href="[{$cssFileUrl}]" type="text/css" rel="stylesheet">

<script type="text/javascript">
  if(top)
  {
    top.sMenuItem    = "[{ oxmultilang ident="mxorders" }]";
    top.sMenuSubItem = "[{ oxmultilang ident="jxbc_packing" }]";
    top.sWorkArea    = "[{$_act}]";
    top.setTitle();
  }
</script>

<body onload="document.forms.jxbc.[{if $sInvoiceNo == ""}]jxInvoiceNo[{else}]jxGtin[{/if}].focus();">
<div class="center" style="height:100%;margin-left:10px;margin-right:10px;">
    <h3>[{ oxmultilang ident="JXBC_PACKING_TITLE" }]</h3>
    <div style="position:absolute;top:4px;right:8px;color:gray;font-size:0.9em;border:1px solid gray;border-radius:3px;">
        &nbsp;[{$sModuleId}]&nbsp;[{$sModuleVersion}]&nbsp;
    </div>
    
    [{include file="jxbc_messagebox.tpl" message=$message }]

    <p>
        <form name="transfer" id="transfer" action="[{ $shop->selflink }]" method="post">
            [{ $shop->hiddensid }]
            <input type="hidden" name="oxid" value="[{ $oxid }]">
            <input type="hidden" name="cl" value="article" size="40">
            <input type="hidden" name="updatelist" value="1">
        </form>
        
        <div style="position:relative;">
            <form name="jxbc" id="jxbc" action="[{ $shop->selflink }]" method="post">
                [{if $sInvoiceNo == ""}]
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <strong> [{ oxmultilang ident="JXBC_SCANDELIVERYNOTE" }]</strong>
                        </div>
                        <div class="panel-body">
                            [{ $shop->hiddensid }]
                            <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
                            <input type="hidden" name="cl" value="jxbc_packing">
                            <input type="hidden" name="fnc" value="">
                            <input type="hidden" name="oxid" value="[{ $oxid }]">

                            <div class="input-group" style="width:400px;">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-barcode "></span> [{ oxmultilang ident="JXBC_INVOICENO" }]
                                </span>
                                <input type="text" class="form-control" name="jxInvoiceNo" value="[{ $sInvoiceNo }]" autocomplete="off" />
                                <span class="input-group-btn">
                                    <button type="submit" class="btn btn-primary" [{*onclick="document.forms.jxbc.submit();"*}] [{ $readonly }]>
                                        <strong>[{ oxmultilang ident="JXBC_SEARCH" }]</strong>
                                    </button>
                                </span>
                            </div>
                        </form>
                        </div>
                    </div>
                [{elseif $message != "packing-done" }]
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <strong> [{ oxmultilang ident="JXBC_DELIVERYNOTENO" }] [{ $sInvoiceNo }] - [{ oxmultilang ident="JXBC_SCANARTICLE" }]</strong>
                        </div>
                        <div class="panel-body">
                        [{*<form name="jxbc" id="jxbc" action="[{ $shop->selflink }]" method="post">*}]
                            [{ $shop->hiddensid }]
                            <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
                            <input type="hidden" name="cl" value="jxbc_packing">
                            <input type="hidden" name="fnc" value="">
                            <input type="hidden" name="oxid" value="[{ $oxid }]">
                            <input type="hidden" name="jxInvoiceNo" value="[{ $sInvoiceNo }]">

                            <div class="input-group" style="width:400px;">
                                <span class="input-group-addon">
                                    <span class="glyphicon glyphicon-barcode "></span> [{ oxmultilang ident="JXBC_GTIN" }]
                                </span>
                                <input type="text" class="form-control" name="jxGtin" value="[{ $aproduct.oxgtin }]" autocomplete="off" />
                                <span class="input-group-btn">
                                    <button type="submit" class="btn btn-primary" [{*onclick="document.forms.jxbc.submit();"*}] [{ $readonly }]>
                                        <strong>[{ oxmultilang ident="JXBC_SEARCH" }]</strong>
                                    </button>
                                </span>
                            </div>
                        </div>
                    </div>
                [{/if}]

                <div class="panel panel-default">
                    <div class="panel-body">
                        <table class="table table-hover" width="95%" border="0">
                            <thead>
                                <tr>
                                    [{assign var="thStyle" value="color:gray;" }]
                                    <th style="[{$thStyle}]">[{ oxmultilang ident="GENERAL_ARTICLE_OXTHUMB" }]</th>
                                    <th style="[{$thStyle}]">[{ oxmultilang ident="ARTICLE_EXTEND_UNITQUANTITY" }]</th>
                                    <th style="[{$thStyle}]">[{ oxmultilang ident="GENERAL_ARTNUM" }]</th>
                                    <th style="[{$thStyle}]">[{ oxmultilang ident="GENERAL_ARTICLE_OXTITLE" }]</th>
                                    <th style="[{$thStyle}]">[{ oxmultilang ident="GENERAL_ARTICLE_OXEAN" }]</th>
                                    <th style="[{$thStyle}]">[{ oxmultilang ident="GENERAL_AJAX_SORT_OXSTOCK" }]</th>
                                    <th style="[{$thStyle}];text-align:right;">[{ oxmultilang ident="GENERAL_ARTICLE_OXPRICE" }]</th>
                                </tr>
                            </thead>
                            [{foreach name=outer item=Product from=$aPackingList}]
                                [{if $Product.pieces|intval < $Product.oxamount }]
                                    [{assign var="tcolor" value="#000000"}]
                                    [{assign var="imgopac" value="1.0"}]
                                [{elseif $Product.pieces|intval > $Product.oxamount }]
                                    [{assign var="tcolor" value="#c08c00"}]
                                    [{assign var="imgopac" value="1.0"}]
                                [{else}]
                                    [{assign var="tcolor" value="#888888"}]
                                    [{assign var="imgopac" value="0.65"}]
                                [{/if}]
                                <input type="hidden" name="jxbc_oxid[]" value="[{$Product.oxid}]">
                                <tr>
                                    <td align="center">
                                        <img src="[{if $Product.oxicon==""}][{ $pic1url}]/[{ $Product.oxpic1 }][{else}][{ $iconurl}]/[{ $Product.oxicon }][{/if}]" style="opacity:[{$imgopac}];" />
                                    </td>
                                    <td class="jxbcTitle" style="color:[{$tcolor}];">
                                        <input type="text" name="jxbc_pieces[]" value="[{ $Product.pieces }]" size="2" />
                                        /
                                        [{ $Product.oxamount }]
                                        [{if $Product.jxsendamount > 0 }]
                                            &nbsp;&nbsp;(<span style="color:gray;"><span class="glyphicon glyphicon-road" aria-hidden="true"></span> = [{ $Product.jxsendamount }]</span>)
                                        [{/if}]
                                    </td>
                                    <td class="jxbcTitle" style="color:[{$tcolor}];">[{ $Product.oxartnum }]</td>
                                    <td class="jxbcTitle" style="color:[{$tcolor}];">[{ $Product.oxtitle }][{if $Product.oxvarselect}], [{$Product.oxvarselect}][{/if}]</td>
                                    <td class="jxbcTitle" style="color:[{$tcolor}];">[{ $Product.oxgtin }]</td>
                                    <td class="jxbcTitle" style="color:[{$tcolor}];">[{if isset($aproduct.jxinvstock) }][{ $Product.jxinvstock }][{else}][{ $Product.oxstock }][{/if}]</td>
                                    <td class="jxbcTitle" align="right" style="color:[{$tcolor}]};">[{ $Product.oxprice|string_format:"%.2f"  }]</td>
                                </tr>
                            [{/foreach}]
                        </table>
                    </div>
                </div>
            
                <br />
                [{if $message == "packing-done" }]
                    [{ $shop->hiddensid }]
                    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
                    <input type="hidden" name="cl" value="jxbc_packing">
                    <input type="hidden" name="fnc" value="jxbcSaveFullDelivery">
                    <input type="hidden" name="jxInvoiceNo" value="[{ $sInvoiceNo }]">
                    <button type="submit" class="btn btn-success btn-lg" onclick="document.forms['jxbc'].elements['fnc'].value='jxbcSaveFullDelivery';" 
                        [{if $aProduct|@count > 1}]disabled="disabled"[{/if}]>
                        [{ oxmultilang ident="JXBC_PACKINGCHECKED" }]
                    </button>
                [{elseif $sInvoiceNo != "" }]
                    <button type="button" class="btn btn-warning btn-lg" 
                            onclick="document.forms['jxbc'].elements['fnc'].value='jxbcSavePartDelivery';document.forms.jxbc.submit();" 
                        [{if $aProduct|@count > 1}]disabled="disabled"[{/if}]>
                        [{ oxmultilang ident="JXBC_PARTDELIVERY" }]
                    </button>
                [{/if}]
            </form>
        </div>
    
    </p>

</div>
</body>
