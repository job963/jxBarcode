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

[{*<style>
    td.jxbcscanTitle {
        font-size: 1.5em;
        font-weight: normal;
        color: dimgray;
    }
    td.jxbcscanValue {
        font-size: 1.5em;
        font-weight: bold;
        padding-left: 20px;
    }
    img.jxbcscanImage {
        width: 200px; 
        height: auto;
        margin-right: 20px;
        border: 1px solid lightgray;
        box-shadow: 4px 4px 4px #aaa;
    }
</style>*}]

<script type="text/javascript">
  if(top)
  {
    top.sMenuItem    = "[{ oxmultilang ident="mxorders" }]";
    top.sMenuSubItem = "[{ oxmultilang ident="jxbc_packing" }]";
    top.sWorkArea    = "[{$_act}]";
    top.setTitle();
  }
</script>

<body onload="document.forms.jxbcscan.oxgtin.focus();">
<div class="center" style="height:100%;margin-left:10px;">
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
        
        <div style="position:relative; top:-10px;">
            <br />
            <div class="panel panel-default">
                <div class="panel-heading">
                [{if $jxInvoiceNo == ""}]
                    <strong><span class="glyphicon glyphicon-barcode" aria-hidden="true"></span> Lieferschein scannen</strong>
                    </div>
                    <div class="panel-body">
                    <form name="jxbcscan" id="jxbcscan" action="[{ $shop->selflink }]" method="post">
                        [{ $shop->hiddensid }]
                        <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
                        <input type="hidden" name="cl" value="jxbc_packing">
                        <input type="hidden" name="fnc" value="">
                        <input type="hidden" name="oxid" value="[{ $oxid }]">
                        Inv-No: <input type="text" name="jxInvoiceNo" value="[{ $jxInvoiceNo }]">&nbsp;
                        <button type="button" class="btn btn-default btn-sm" onclick="document.forms.jxbcscan.submit();" [{ $readonly }]>
                            <strong>[{ oxmultilang ident="JXBC_SEARCH" }]</strong>
                        </button>
                        [{*<input class="edittext" type="submit" 
                                 onkeyup="document.forms.jxbcscan.submit();" 
                                 value=" [{ oxmultilang ident="JXBC_SEARCH" }] " [{ $readonly }]><br /> <br/>*}]
                    </form>
                [{else}]
                    <strong><span class="glyphicon glyphicon-barcode" aria-hidden="true"></span> Artikel scannen</strong>
                    </div>
                    <div class="panel-body">
                    <form name="jxbcscan" id="jxbcscan" action="[{ $shop->selflink }]" method="post">
                        [{ $shop->hiddensid }]
                        <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
                        <input type="hidden" name="cl" value="jxbc_packing">
                        <input type="hidden" name="fnc" value="">
                        <input type="hidden" name="oxid" value="[{ $oxid }]">
                        <input type="hidden" name="jxInvoiceNo" value="[{ $jxInvoiceNo }]">
                        GTIN: <input type="text" name="jxGtin" value="[{ $aproduct.oxgtin }]">&nbsp;
                        <button type="button" class="btn btn-default btn-sm" onclick="document.forms.jxbcscan.submit();" [{ $readonly }]>
                            <strong>[{ oxmultilang ident="JXBC_SEARCH" }]</strong>
                        </button>
                        [{*<input class="edittext" type="submit" 
                                 onkeyup="document.forms.jxbcscan.submit();" 
                                 value=" [{ oxmultilang ident="JXBC_SEARCH" }] " [{ $readonly }]><br /> <br/>*}]
                    </form>
                [{/if}]
                </div>
            </div>

            <table width="95%" border="0">
                [{foreach name=outer item=Product from=$jxPackingList}]
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
                        <td><input type="text" name="jxbc_amount[]" value="[{ $Product.oxamount }]" size="2" class="jxbcNumInput" />/[{ $Product.oxamount }]</td>
                        <td class="jxbcTitle" style="color:[{$tcolor}];">[{ $Product.oxartnum }]</td>
                        <td class="jxbcTitle" style="color:[{$tcolor}];">[{ $Product.oxtitle }][{if $Product.oxvarselect}], [{$Product.oxvarselect}][{/if}]</td>
                        <td class="jxbcTitle" style="color:[{$tcolor}];">[{ $Product.oxgtin }]</td>
                        <td class="jxbcTitle" align="right" style="color:[{$tcolor}]};">[{ $Product.oxprice|string_format:"%.2f"  }]</td>
                    </tr>
                [{/foreach}]
            </table>
            [{*foreach item=aproduct from=$jxPackingList}]
                <table>
                    <tr>
                        <td rowspan="6">
                            [{if $aproduct.oxpic1 }]
                                <img src="[{ $picurl}]/[{ $aproduct.oxpic1 }]" class="jxbcscanImage" />
                            [{/if}]
                        </td>
                        <td class="jxbcscanTitle">Art-Nr</td>
                        <td class="jxbcscanValue">[{ $aproduct.oxartnum }]</td>
                    </tr>
                    <tr>
                        <td class="jxbcscanTitle">Title</td>
                        <td class="jxbcscanValue">[{ $aproduct.oxtitle }]</td>
                    </tr>
                    <tr>
                        <td class="jxbcscanTitle">GTIN</td>
                        <td class="jxbcscanValue">[{ $aproduct.oxgtin }]</td>
                    </tr>
                    <tr>
                        <td class="jxbcscanTitle">EK</td>
                        <td class="jxbcscanValue">[{ $aproduct.oxbprice }]</td>
                    </tr>
                    <tr>
                        <td class="jxbcscanTitle">VK</td>
                        <td class="jxbcscanValue">[{ $aproduct.oxprice }]</td>
                    </tr>
                    <tr>
                        <td class="jxbcscanTitle">Stock</td>
                        <td class="jxbcscanValue">[{ $aproduct.oxstock }]</td>
                    </tr>
                </table>
                <div style="height:25px; "></div>
            [{/foreach*}]
        </div>
    
    </p>
    [{*<div style="position:absolute; bottom:0px; left:0px; height:50px; background-color:#dd0000;"></div>
    <table width="99%">
        <tr>
            <td><img src="[{ $thumburl}]/[{ $aproduct.oxpic1 }]" /></td>
            <td class="jxbcscanTitle">[{ $aproduct.oxartnum }]</td>
            <td class="jxbcscanTitle">[{ $aproduct.oxtitle }]</td>
            <td class="jxbcscanTitle">[{ $aproduct.oxgtin }]</td>
            <td class="jxbcscanTitle">[{ $aproduct.oxprice }]</td>
        </tr>
        <tr>
            <td><img src="[{ $thumburl}]/[{ $aproduct.oxpic1 }]" /></td>
            <td class="jxbcscanTitle">[{ $aproduct.oxartnum }]</td>
            <td class="jxbcscanTitle">[{ $aproduct.oxtitle }]</td>
            <td class="jxbcscanTitle">[{ $aproduct.oxgtin }]</td>
            <td class="jxbcscanTitle">[{ $aproduct.oxprice }]</td>
        </tr>
    </table>*}]

</div>
</body>
