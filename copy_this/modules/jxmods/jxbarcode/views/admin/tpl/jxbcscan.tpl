[{*debug*}]
[{include file="headitem.tpl" title="GENERAL_ADMIN_TITLE"|oxmultilangassign box=" "}]

<style>
    td.jxbcscanTitle {
        font-size: 1.5em;
        font-weight: normal;
    }
    td.jxbcscanValue {
        font-size: 1.5em;
        font-weight: bold;
        padding-left: 20px;
    }
    img.jxbcscanImage {
        width:400px; 
        height:auto;
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
    <h1>[{ oxmultilang ident="JXBCSCAN_TITLE" }]</h1>
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
                         value=" [{ oxmultilang ident="JXBCSCAN_SEARCH" }] " [{ $readonly }]><br /> <br/>
            </form>
            <hr>
            <table>
                <tr>
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
            </table>
            [{if $aproduct.oxpic1 }]
                <img src="[{ $picurl}]/[{ $aproduct.oxpic1 }]" class="jxbcscanImage" />
            [{/if}]
        </div>
    
    </p>
    <div style="position:absolute; bottom:0px; left:0px; height:50px; background-color:#dd0000;"></div>
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
    </table>

</div>
</body>
