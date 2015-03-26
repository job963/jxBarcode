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
    top.sMenuItem    = "[{ oxmultilang ident="mxmanageprod" }]";
    top.sMenuSubItem = "[{ oxmultilang ident="jxbc_receipt" }]";
    top.sWorkArea    = "[{$_act}]";
    top.setTitle();
  }
</script>

<body onload="document.forms.jxbc.oxgtin.focus();" >
<div class="center" style="height:100%;margin-left:10px;margin-right:10px;">
    <h3>[{ oxmultilang ident="JXBC_RECEIPT_TITLE" }]</h3>
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
    
        <div style="position:relative; top:-10px;">
            <br />
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>[{ oxmultilang ident="JXBC_SCANARTICLE" }]</strong>
                </div>
                <div class="panel-body">
                    <form name="jxbc" id="jxbc" action="[{ $shop->selflink }]" method="post">
                        [{ $shop->hiddensid }]
                        <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
                        <input type="hidden" name="cl" value="jxbc_receipt">
                        <input type="hidden" name="fnc" value="">
                        <input type="hidden" name="oxid" value="[{ $oxid }]">

                        <div class="input-group" style="width:400px;">
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-barcode "></span> [{ oxmultilang ident="JXBC_GTIN" }]
                            </span>
                            <input type="text" class="form-control" name="oxgtin" value="[{ $aproduct.oxgtin }]" autocomplete="off" />
                            <span class="input-group-btn">
                                <button type="submit" class="btn btn-primary" onclick="
                                             var sCode = document.forms['jxbc'].elements['oxgtin'].value;
                                             if (document.forms['jxbc'].elements['oxgtin'].value == '011223344550') {
                                                 document.forms['jxbc'].elements['oxgtin'].value='';
                                                 document.forms['jxbc'].elements['fnc'].value='jxbcSaveReceipt';
                                             } else {
                                                 document.forms['jxbc'].elements['fnc'].value='';
                                                 document.forms.jxbc.submit();
                                             }" [{ $readonly }]>
                                    <strong>[{ oxmultilang ident="JXBC_SEARCH" }]</strong>
                                </button>
                            </span>
                        </div>
                </div>
            </div>
                
            [{if $aProduct|@count > 1}]
                <!-- Modal Popup -->
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog [{*modal-lg*}]" style="max-height:90%; overflow-y:auto;">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">
                                    <b>[{ oxmultilang ident="JXBC_MULTIPLEFOUND" }]</b>
                                </h4>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="jxbc_prevgtin" value="[{$sprevgtin}]" />
                                [{assign var="i" value=1}]
                                [{assign var="lblStyle" value="font-size:1.4em; height:100%; padding-top:18px; vertical-align:middle;"}]
                                <table width="95%" style="font-size:1.5em;">
                                    [{foreach name=founds item=Product from=$aProduct}]
                                    <tr>
                                        <td>    
                                            <input type="radio" name="jxbc_productchoice" value="[{$Product.oxid}]" id="[{$Product.oxid}]" />[{* <span style="display:inline-block; width:100px;">[{ $Product.oxartnum }]</span>[{$Product.oxtitle}]*}]
                                        </td>
                                        <td><label for="[{$Product.oxid}]">&nbsp;
                                            [{if $Product.oxactive == 1}]
                                                <img src="[{$oViewConf->getModuleUrl("jxbarcode","out/admin/img/ico_active.png")}]" />
                                            [{else}]
                                                <img src="[{$oViewConf->getModuleUrl("jxbarcode","out/admin/img/ico_inactive.png")}]" />
                                            [{/if}]
                                            </label>
                                        </td>
                                        <td><label for="[{$Product.oxid}]">&nbsp;
                                            <img [{if $Product.oxicon==""}]
                                                    src="[{ $pic1url}]/[{ $Product.oxpic1 }]"
                                                [{else}]
                                                    src="[{ $iconurl}]/[{ $Product.oxicon }]"
                                                [{/if}] 
                                                height="66" width="auto" />
                                            </label>
                                        </td>
                                        <td><label for="[{$Product.oxid}]" style="[{$lblStyle}]">
                                            <span style="" accesskey="[{$i}]">[{ $Product.oxartnum }]</span></label>
                                        </td>
                                        <td><label for="[{$Product.oxid}]" style="[{$lblStyle}]">
                                            [{$Product.oxtitle}]
                                            [{if $Product.oxvarselect}], [{$Product.oxvarselect}][{/if}]</label>
                                        </td>
                                        [{assign var="i" value=$i+1}]
                                    </tr>
                                    [{/foreach}]
                                </table>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary" [{*data-dismiss="modal"*}] onclick="document.forms.jxbc.submit();">
                                    [{ oxmultilang ident="JXBC_SELECT" }]
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
             
                <script>
                    $("#myModal").modal('show');

                    var $modalDialog = $('.modal-dialog'),
                    modalHeight = $modalDialog.height(),
                    browserHeight = window.innerHeight;

                    $modalDialog.css({'margin-top' : modalHeight >= browserHeight ? 0 : (browserHeight - modalHeight)/2});
                </script>
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
                            [{foreach name=outer item=Product from=$aProducts}]
                                [{if $lastoxid == $Product.oxid}]
                                    [{assign var="tcolor" value="#0000aa;font-weight:bold"}]
                                [{else}]
                                    [{assign var="tcolor" value="#888888"}]
                                [{/if}]
                                <input type="hidden" name="jxbc_oxid[]" value="[{$Product.oxid}]">
                                <tr>
                                    <td align="center">
                                        <img src="[{if $Product.oxicon==""}]
                                                [{ $pic1url}]/[{ $Product.oxpic1 }]
                                            [{else}]
                                                [{ $iconurl}]/[{ $Product.oxicon }]
                                            [{/if}]" />
                                    </td>
                                    <td><input type="text" name="jxbc_amount[]" value="[{ $Product.oxamount }]" size="2" class="jxbcNumInput" /></td>
                                    <td class="jxbcTitle" style="color:[{$tcolor}];">[{ $Product.oxartnum }]</td>
                                    <td class="jxbcTitle" style="color:[{$tcolor}];">[{ $Product.oxtitle }][{if $Product.oxvarselect}], [{$Product.oxvarselect}][{/if}]</td>
                                    <td class="jxbcTitle" style="color:[{$tcolor}];">[{ $Product.oxgtin }]</td>
                                    <td class="jxbcTitle" style="color:[{$tcolor}];">[{if isset($Product.jxinvstock)}][{ $Product.jxinvstock }][{else}][{ $Product.oxstock }][{/if}]</td>
                                    <td class="jxbcTitle" align="right" style="color:[{$tcolor}]};">[{ $Product.oxprice|string_format:"%.2f"  }]</td>
                                </tr>
                            [{/foreach}]
                        </table>
                    </div>
                </div>
                        
            [{if $aProducts}]
                <p><br />
                <button type="button" class="btn btn-success btn-lg" onclick="document.forms['jxbc'].elements['oxgtin'].value='';document.forms['jxbc'].elements['fnc'].value='jxbcSaveReceipt';document.forms.jxbc.submit();" 
                    [{*if $aProduct|@count > 1}]disabled="disabled"[{/if*}]>
                    [{ oxmultilang ident="JXBC_ADDTOSTOCK" }]
                </button>
                &nbsp;&nbsp;
                <button type="button" class="btn btn-warning btn-lg" onclick="document.forms['jxbc'].elements['oxgtin'].value='';document.forms['jxbc'].elements['fnc'].value='jxbcUpdateStock';document.forms.jxbc.submit();" 
                    [{*if $aProduct|@count > 1}]disabled="disabled"[{/if*}]>
                    [{ oxmultilang ident="JXBC_UPDATESTOCK" }]
                </button>
                </p>
            [{/if}]
            </form>
        </div>
    
    </p>
    <div style="position:absolute; bottom:0px; left:0px; height:50px; background-color:#dd0000;"></div>

</div>
</body>
