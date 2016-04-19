[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign box=" " }]

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap-theme.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>

[{assign var="alertSound" value=$oViewConf->getModuleUrl('jxbarcode','out/admin/audio/alert.mp3') }]
[{assign var="questionSound" value=$oViewConf->getModuleUrl('jxbarcode','out/admin/audio/question.mp3') }]

[{assign var="cssFilePath" value=$oViewConf->getModulePath('jxbarcode','out/admin/src/jxbarcode.css') }]
[{php}] 
    $sCssFilePath = $this->get_template_vars('cssFilePath');;
    $sCssTime = filemtime( $sCssFilePath );
    $this->assign('cssTime', $sCssTime);
[{/php}]
[{assign var="cssFileUrl" value=$oViewConf->getModuleUrl('jxbarcode','out/admin/src/jxbarcode.css') }]
[{*assign var="cssFileUrl" value="$cssFileUrl?$cssTime" *}]
<link href="[{$cssFileUrl}]?[{$cssTime}]" type="text/css" rel="stylesheet">


<script type="text/javascript">
if(top)
  {
    top.sMenuItem    = "[{ oxmultilang ident="mxmanageprod" }]";
    top.sMenuSubItem = "[{ oxmultilang ident="jxbc_scan" }]";
    top.sWorkArea    = "[{$_act}]";
    top.setTitle();
  }
</script>

<body onload="document.forms.jxbcscan.oxgtin.focus();">
<div class="center" style="height:100%;margin-left:10px;margin-right:10px;">
    <h3>[{ oxmultilang ident="JXBC_SCAN_TITLE" }]</h3>
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
        
        <div style="position:relative;top:-10px;">
            <br />
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>[{ oxmultilang ident="JXBC_SCANARTICLE" }]</strong>
                </div>
                <div class="panel-body">
                    <form name="jxbcscan" id="jxbcscan" action="[{ $shop->selflink }]" method="post">
                        [{ $shop->hiddensid }]
                        <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
                        <input type="hidden" name="cl" value="jxbc_scan">
                        <input type="hidden" name="fnc" value="">
                        <input type="hidden" name="oxid" value="[{ $oxid }]">
                        
                        <div class="input-group" style="width:400px;">
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-barcode "></span> [{ oxmultilang ident="JXBC_GTIN" }]
                            </span>
                            <input type="text" class="form-control" name="oxgtin" value="[{ $aproduct.oxgtin }]" autocomplete="off" />
                            <span class="input-group-btn">
                            <button type="submit" class="btn btn-primary" onclick="document.forms.jxbcscan.submit();" [{ $readonly }]>
                                [{ oxmultilang ident="JXBC_SEARCH" }]
                            </button>
                            </span>
                        </div>
                    </form>
                </div>
            </div>

            [{foreach item=aproduct from=$aproducts}]
                <table>
                    <tr>
                        <td rowspan="7">
                            [{if $aproduct.oxpic1 }]
                                <img src="[{ $picurl}]/[{ $aproduct.oxpic1 }]" class="jxbcscanImage" />
                            [{/if}]
                        </td>
                        <td class="jxbcscanTitle">[{ oxmultilang ident="GENERAL_ARTNUM" }]</td>
                        <td class="jxbcscanValueLite">[{ $aproduct.oxartnum }]</td>
                    </tr>
                    <tr>
                        <td class="jxbcscanTitle">[{ oxmultilang ident="GENERAL_ARTICLE_OXTITLE" }]</td>
                        <td class="jxbcscanValue">[{ $aproduct.oxtitle }][{if $aproduct.oxvarselect != ""}]<span style="color:darkslategray;"> &mdash; [{ $aproduct.oxvarselect }]</span>[{/if}]</td>
                    </tr>
                    <tr>
                        <td class="jxbcscanTitle">[{ oxmultilang ident="GENERAL_ARTICLE_OXEAN" }]</td>
                        <td class="jxbcscanValue">[{ $aproduct.oxgtin }]</td>
                    </tr>
                    <tr>
                        <td class="jxbcscanTitle">[{ oxmultilang ident="ARTICLE_EXTEND_BPRICE" }]</td>
                        <td class="jxbcscanValueLite">[{ $aproduct.oxbprice|string_format:"%.2f" }]</td>
                    </tr>
                    <tr>
                        <td class="jxbcscanTitle">[{ oxmultilang ident="GENERAL_ARTICLE_OXPRICE" }]</td>
                        <td class="jxbcscanValue">[{ $aproduct.oxprice|string_format:"%.2f" }]</td>
                    </tr>
                    <tr>
                        <td class="jxbcscanTitle">[{ oxmultilang ident="JXBC_SHOPSTOCK" }]</td>
                        <td class="jxbcscanValueLite">[{ $aproduct.oxstock }]</td>
                    </tr>
                    [{if isset($aproduct.jxinvstock) }]
                        <tr>
                            <td class="jxbcscanTitle">[{ oxmultilang ident="JXBC_INVSTOCK" }]</td>
                            <td class="jxbcscanValue">[{ $aproduct.jxinvstock }]</td>
                        </tr>
                    [{/if}]
                </table>
                <div style="height:25px; "></div>
            [{/foreach}]
        </div>
    
    </p>

</div>
</body>
