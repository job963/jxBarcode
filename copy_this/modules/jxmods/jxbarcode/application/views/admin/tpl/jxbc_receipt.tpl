[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign box=" "}]

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>

[{assign var="alertSound" value=$oViewConf->getModuleUrl('jxbarcode','out/admin/audio/alert.mp3') }]
[{assign var="questionSound" value=$oViewConf->getModuleUrl('jxbarcode','out/admin/audio/question.mp3') }]

<style>
    td.jxbcTitle {
        font-size: 1.4em;
        font-weight: normal;
    }
    td.jxbcValue {
        font-size: 1.4em;
        font-weight: bold;
        padding-left: 20px;
    }
    img.jxbcImage {
        width:400px; 
        height:auto;
    }
    input.jxbcNumInput {
        font-size: 1.4em;
        padding-right: 4px;
        text-align: right;
    }
    input.jxbcSubmit {
        font-size: 1.4em;
    }
    span.msgError {
        position: relative; 
        top: -20px; 
        color: #dd0000;
        font-weight: bold;
        font-size: 1.4em;
        border: 1px solid #dd0000;
        border-radius: 6px;
        padding: 2px;
        background-color: #ffc0c0;
    }
    span.msgSuccess {
        position: relative; 
        top: -20px; 
        color: #009900;
        font-weight: bold; 
        font-size: 1.4em;
        border: 1px solid #00bb00;
        border-radius: 6px;
        padding: 2px;
        background-color: #c0ffc0;
    }
    .artSelect fieldset {
        border: 1px solid #00439a; 
        border-radius: 8px; 
        padding: 12px; 
        padding-left: 8px; 
        box-shadow: 0px 0px 60px 20px #aaa; 
        width: 70%; 
        margin: auto;
        color: #00439a; 
        background-color: #fafafa; 
        font-size: 1.4em;
    }
    .artSelect legend {
        color: #ffffff; 
        background-color: #00439a; 
        border: 1px solid #0053be; 
        border-radius: 4px    
    }
    .artSelect input {
        color: #00439a; 
        font-size: 1.0em; 
        font-weight: bold;
    }
    
    .msg {
        margin: 20px;
    }
</style>

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
<div class="center" style="height:100%;margin-left: 10px;">
    <h1>[{ oxmultilang ident="JXBC_RECEIPT_TITLE" }]</h1>
    <div style="position:absolute;top:4px;right:8px;color:gray;font-size:0.9em;border:1px solid gray;border-radius:3px;">
        &nbsp;[{$sModuleId}]&nbsp;[{$sModuleVersion}]&nbsp;
    </div>

    [{if $message == "ean-not-found"}]
        [{*<span class="msgError">&nbsp;[{ oxmultilang ident="JXBC_MSG_EANNOTFOUND" }]&nbsp;</span>*}]
        <div class="msg">
            <div class="alert alert-danger alert-error">
                <a href="#" class="close" data-dismiss="alert">&times;</a>
                <b>[{ oxmultilang ident="JXBC_MSG_EANNOTFOUND" }]</b>
            </div>
        </div>
        <audio autoplay>
            <source src="[{$alertSound}]" type="audio/mpeg">
            Your browser does not support the audio element.
        </audio>
    [{elseif $message == "receipt-saved"}]
        [{*<span class="msgSuccess">&nbsp;[{ oxmultilang ident="JXBC_MSG_RECEIPTSAVED" }]&nbsp;</span>*}]
        <div class="msg">
            <div class="alert alert-success">
                <a href="#" class="close" data-dismiss="alert">&times;</a>
                [{ oxmultilang ident="JXBC_MSG_RECEIPTSAVED" }]
            </div>
        </div>
    [{/if}]
    <p>
        <form name="transfer" id="transfer" action="[{ $shop->selflink }]" method="post">
            [{ $shop->hiddensid }]
            <input type="hidden" name="oxid" value="[{ $oxid }]">
            <input type="hidden" name="cl" value="article" size="40">
            <input type="hidden" name="updatelist" value="1">
        </form>
    
        <div style="position:relative; top:-10px;">
            <hr><br>
            <form name="jxbc" id="jxbc" action="[{ $shop->selflink }]" method="post">
                [{ $shop->hiddensid }]
                <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
                <input type="hidden" name="cl" value="jxbc_receipt">
                <input type="hidden" name="fnc" value="">
                <input type="hidden" name="oxid" value="[{ $oxid }]">
                
                GTIN: 
                <input type="text" name="oxgtin" value="[{ $aproduct.oxgtin }]"  autocomplete="off">
                <input class="edittext" type="submit" 
                         onclick="
                             var sCode = document.forms['jxbc'].elements['oxgtin'].value;
                             if (document.forms['jxbc'].elements['oxgtin'].value == '011223344550') {
                                 document.forms['jxbc'].elements['oxgtin'].value='';
                                 document.forms['jxbc'].elements['fnc'].value='jxbcSaveReceipt';
                             } else {
                                 document.forms['jxbc'].elements['fnc'].value='';
                                 document.forms.jxbc.submit();
                             }" 
                         value=" [{ oxmultilang ident="JXBC_SEARCH" }] " [{ $readonly }]><br /> <br/>
                
            <hr>
            [{if $aProduct|@count > 1}]
                <br />
                <div class="artSelect">
                <fieldset class="artSelect">
                    <legend class="artSelect">&nbsp;[{ oxmultilang ident="JXBC_MULTIPLEFOUND" }]&nbsp;</legend>
                    <input type="hidden" name="jxbc_prevgtin" value="[{$sprevgtin}]" />
                    [{assign var="i" value=1}]
                    [{foreach name=founds item=Product from=$aProduct}]
                        <input type="radio" name="jxbc_productchoice" value="[{$Product.oxid}]" [{*name="[{$Product.oxid}]"*}] id="[{$Product.oxid}]" />[{* <span style="display:inline-block; width:100px;">[{ $Product.oxartnum }]</span>[{$Product.oxtitle}]*}]
                        <label for="[{$Product.oxid}]">
                            [{if $Product.oxactive == 1}]
                                <img src="[{$oViewConf->getModuleUrl("jxbc","out/admin/img/ico_active.png")}]"/>
                            [{else}]
                                <img src="[{$oViewConf->getModuleUrl("jxbc","out/admin/img/ico_inactive.png")}]"/>
                            [{/if}]
                            <span style="display:inline-block; width:175px;" accesskey="[{$i}]">[{ $Product.oxartnum }]</span>[{$Product.oxtitle}]
                            [{if $Product.oxvarselect}], [{$Product.oxvarselect}][{/if}]
                        </label><br>
                        [{assign var="i" value=$i+1}]
                    [{/foreach}]
                    [{*<button style="color:#00439a; font-size:1.1em; font-weight:bold;">Ausw&auml;hlen</button>*}]
                    <input type="submit" autofocus="autofocus" class=artSelect" value=" [{ oxmultilang ident="JXBC_SELECT" }] " />
                </fieldset>
                <audio autoplay>
                    <source src="[{$questionSound}]" type="audio/mpeg">
                    Your browser does not support the audio element.
                </audio>
                </div>
                <br />
            [{/if}]
            <table width="95%" border="0">
                [{foreach name=outer item=Product from=$aProducts}]
                    [{if $lastoxid == $Product.oxid}]
                        [{assign var="tcolor" value="#0000cc;font-weight:bold"}]
                    [{else}]
                        [{assign var="tcolor" value="#888888"}]
                    [{/if}]
                    <input type="hidden" name="jxbc_oxid[]" value="[{$Product.oxid}]">
                    <tr>
                        <td align="center"><img src="[{if $Product.oxicon==""}]
                                            [{ $pic1url}]/[{ $Product.oxpic1 }]
                                        [{else}]
                                            [{ $iconurl}]/[{ $Product.oxicon }]
                                        [{/if}]" /></td>
                        <td><input type="text" name="jxbc_amount[]" value="[{ $Product.oxamount }]" size="2" class="jxbcNumInput" /></td>
                        <td class="jxbcTitle" style="color:[{$tcolor}];">[{ $Product.oxartnum }]</td>
                        <td class="jxbcTitle" style="color:[{$tcolor}];">[{ $Product.oxtitle }][{if $Product.oxvarselect}], [{$Product.oxvarselect}][{/if}]</td>
                        <td class="jxbcTitle" style="color:[{$tcolor}];">[{ $Product.oxgtin }]</td>
                        <td class="jxbcTitle" align="right" style="color:[{$tcolor}]};">[{ $Product.oxprice|string_format:"%.2f"  }]</td>
                </tr>
                [{/foreach}]
            </table>
            [{if $aProducts}]
                <p><br />
                <input type="submit" value=" In Lagerbestand &uuml;bernehmen " class="jxbcSubmit" 
                    onclick="document.forms['jxbc'].elements['oxgtin'].value='';document.forms['jxbc'].elements['fnc'].value='jxbcSaveReceipt';" 
                    [{if $aProduct|@count > 1}]disabled="disabled"[{/if}] />
                </p>
            [{/if}]
            </form>
        </div>
        [{*<form name="jxbcSave" id="jxbcSave" action="[{ $shop->selflink }]" method="post">
            [{ $shop->hiddensid }]
            <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
            <input type="hidden" name="cl" value="jxbc_receipt">
            <input type="hidden" name="fnc" value="jxbcSaveReceipt">
        </form>*}]
    
    </p>
    <div style="position:absolute; bottom:0px; left:0px; height:50px; background-color:#dd0000;"></div>

</div>
</body>
