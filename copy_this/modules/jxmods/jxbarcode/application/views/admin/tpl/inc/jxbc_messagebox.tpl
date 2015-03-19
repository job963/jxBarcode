<div style="margin-right: 24px;">
    [{if $message == "ean-not-found"}]
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
    [{elseif $message == "wrong-article"}]
        <div class="msg">
            <div class="alert alert-danger alert-error">
                <a href="#" class="close" data-dismiss="alert">&times;</a>
                <b>[{ oxmultilang ident="JXBC_MSG_WRONGARTICLE" }]</b>
            </div>
        </div>
        <audio autoplay>
            <source src="[{$alertSound}]" type="audio/mpeg">
            Your browser does not support the audio element.
        </audio>
    [{elseif $message == "already-checked"}]
        <div class="msg">
            <div class="alert alert-warning alert-error">
                <a href="#" class="close" data-dismiss="alert">&times;</a>
                <b>[{ oxmultilang ident="JXBC_MSG_ALREADYCHECKED" }]</b>
            </div>
        </div>
        <audio autoplay>
            <source src="[{$alertSound}]" type="audio/mpeg">
            Your browser does not support the audio element.
        </audio>
    [{elseif $message == "to-many-items"}]
        <div class="msg">
            <div class="alert alert-warning alert-error">
                <a href="#" class="close" data-dismiss="alert">&times;</a>
                <b>[{ oxmultilang ident="JXBC_MSG_TOMANYITEMS" }]</b>
            </div>
        </div>
        <audio autoplay>
            <source src="[{$alertSound}]" type="audio/mpeg">
            Your browser does not support the audio element.
        </audio>
    [{elseif $message == "packing-done"}]
        <div class="msg">
            <div class="alert alert-success">
                <a href="#" class="close" data-dismiss="alert">&times;</a>
                <b>[{ oxmultilang ident="JXBC_MSG_PACKINGDONE" }]</b>
            </div>
        </div>
    [{elseif $message == "check-saved"}]
        <div class="msg">
            <div class="alert alert-success">
                <a href="#" class="close" data-dismiss="alert">&times;</a>
                <b>[{ oxmultilang ident="JXBC_MSG_CHECKSAVED" }]</b>
            </div>
        </div>
    [{elseif $message == "receipt-saved"}]
        <div class="msg">
            <div class="alert alert-success">
                <a href="#" class="close" data-dismiss="alert">&times;</a>
                <b>[{ oxmultilang ident="JXBC_MSG_RECEIPTSAVED" }]</b>
            </div>
        </div>
    [{/if}]
</div>
