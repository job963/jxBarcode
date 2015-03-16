[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign box=" "}]

<style>
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
</style>

<script type="text/javascript">
  if(top)
  {
    top.sMenuItem    = "[{ oxmultilang ident="mxservice" }]";
    top.sMenuSubItem = "[{ oxmultilang ident="jxbcscan_menu" }]";
    top.sWorkArea    = "[{$_act}]";
    top.setTitle();
  }
</script>

<body onload="document.forms.jxbcscan.oxgtin.focus();">
<div class="center" style="height:100%;">
    <h1>[{ oxmultilang ident="JXBC_SCAN_TITLE" }]</h1>
    <div style="position:absolute;top:4px;right:8px;color:gray;font-size:0.9em;border:1px solid gray;border-radius:3px;">
        &nbsp;[{$sModuleId}]&nbsp;[{$sModuleVersion}]&nbsp;
    </div>
    <p>
        <form name="transfer" id="transfer" action="[{ $shop->selflink }]" method="post">
            [{ $shop->hiddensid }]
            <input type="hidden" name="oxid" value="[{ $oxid }]">
            <input type="hidden" name="cl" value="article" size="40">
            <input type="hidden" name="updatelist" value="1">
        </form>
        
        <div style="position:relative; top:-10px;">
            <hr><br>
            <form name="jxbcscan" id="jxbcscan" action="[{ $shop->selflink }]" method="post">
                [{ $shop->hiddensid }]
                <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
                <input type="hidden" name="cl" value="jxbcscan">
                <input type="hidden" name="fnc" value="">
                <input type="hidden" name="oxid" value="[{ $oxid }]">
                GTIN: <input type="text" name="oxgtin" value="[{ $aproduct.oxgtin }]">
                <input class="edittext" type="submit" 
                         onkeyup="document.forms.jxbcscan.submit();" 
                         value=" [{ oxmultilang ident="JXBC_SEARCH" }] " [{ $readonly }]><br /> <br/>
            </form>
            <hr>
            [{foreach item=aproduct from=$aproducts}]
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
                [{*if $aproduct.oxpic1 }]
                    <img src="[{ $picurl}]/[{ $aproduct.oxpic1 }]" class="jxbcscanImage" />
                [{/if*}]
            [{/foreach}]
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
