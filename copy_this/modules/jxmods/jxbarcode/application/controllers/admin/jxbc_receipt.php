<?php

/*
 *    This file is part of the module jxBcScan for OXID eShop Community Edition.
 *
 *    The module OxProbs for OXID eShop Community Edition is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    The module OxProbs for OXID eShop Community Edition is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with OXID eShop Community Edition.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @link      https://github.com/job963/jxBcScan
 * @license   http://www.gnu.org/licenses/gpl-3.0.html GPL v3 or later
 * @copyright (C) Joachim Barthel 2012-2013
 *
 */
 
class jxbc_receipt extends jxbcscan
{
    protected $_sThisTemplate = "jxbc_receipt.tpl";
    
    public function render()
    {
        parent::render();
        $oSmarty = oxUtilsView::getInstance()->getSmarty();
        $oSmarty->assign( "oViewConf", $this->_aViewData["oViewConf"]);
        $oSmarty->assign( "shop", $this->_aViewData["shop"]);
        
        $myConfig = oxRegistry::get("oxConfig");
        $sPicUrl = $myConfig->getPictureUrl(FALSE) . 'master/product/1';
        $sPic1Url = $myConfig->getPictureUrl(FALSE) . 'generated/product/' . '1/' . str_replace('*','_',$myConfig->getConfigParam( 'sIconsize' )) . '_' . $myConfig->getConfigParam( 'sDefaultImageQuality' );
        $sIconUrl = $myConfig->getPictureUrl(FALSE) . 'generated/product/' . 'icon/' . str_replace('*','_',$myConfig->getConfigParam( 'sIconsize' )) . '_' . $myConfig->getConfigParam( 'sDefaultImageQuality' );

        $sGtin = oxConfig::getParameter( 'oxgtin' );
        //$aProducts = array();
        /*$iRows = oxConfig::getParameter( 'jxbcscan_ean_rows' );
        for ($i=0; $i<$iRows; $i++) {
            $sEAN = oxConfig::getParameter( "jxbcscan_ean_$i" );
            echo $sEAN . ' ';
            array_push( $aProducts, $sEAN );
        }
        /**/
        $aOxids = oxConfig::getParameter( 'jxbcscan_oxid' );
        $aAmount = oxConfig::getParameter( 'jxbcscan_amount' );
        $sSelOxid = oxConfig::getParameter( 'jxbcscan_productchoice' );
                //echo 'sGtin='.$sGtin.'<br>';
                //echo 'selOxid='.$sSelOxid.'<br>';
        if (isset($aOxids)) {
            $aProducts = $this->getAllArticles( $aOxids );
            $aProducts = array_reverse($aProducts); //reverse due to reverse display in tpl
            $aProducts = $this->addAmount( $aAmount, $aProducts  );
        }
        else
            $aProducts = array();
            
        /* echo '<hr><pre>';
        print_r($aGtins);
        echo '</pre><hr>'; /* */
        
        // ------ new/next product was scanned
        if (!empty($sGtin)) {

            $aProduct = $this->getArticleByGtin($sGtin); 

            if ($aProduct) {
                if (count($aProduct) == 1) {
                    // only on product found
                    $aOneProduct = array();
                    $aOneProduct = $aProduct[0];
                    /*echo count($aProduct). '<pre>';
                    print_r($aProducts);
                    echo '</pre>'; /* */
                    //echo 'yet='.$this->yetScanned($aOneProduct['oxid'],$aProducts);
                    if ( $this->yetScanned($aOneProduct['oxid'],$aProducts) )
                        $aProducts = $this->increaseAmount( $aOneProduct['oxid'], $aProducts );
                    else
                        array_push( $aProducts, $aOneProduct );
                } else {
                    // multiple entries found
                    /*$aMultiFound = array();
                    $aMultiFound = $aProduct;*/
                    //$sPrevGtin = $sGtin;
                    $sGtin = '';
                }
            }
            //array_push( $aGtins, $aProduct['oxgtin']);
            //array_push( $aProducts, $this->getArticle($sGtin) );
            
            /*echo count($aOneProduct). '<pre>';
            print_r($aProducts);
            echo '</pre>'; /* */
        }
        
        //--------- multiple products found, on selected by oxid
        if (!empty($sSelOxid)) {
            $sGtin = ''; //oxConfig::getParameter( 'jxbc_prevgtin' );
            //echo 'yet='.$this->yetScanned($sSelOxid,$aProducts).'<br>';
            if ( $this->yetScanned($sSelOxid,$aProducts) )
                $aProducts = $this->increaseAmount( $sSelOxid, $aProducts );
            else {
                //echo 'selOxid='.$sSelOxid.'<br>';
                $aOneProduct = array();
                $aOneProduct = $this->getArticleById($sSelOxid);
                /*echo count($aOneProduct). '<pre>';
                print_r($aProducts);
                echo '</pre>'; /* */
                array_push( $aProducts, $aOneProduct );
            }
        }
        
        if ( (count($aOneProduct) == 0) && ($sGtin != "") ) {
            $oSmarty->assign("message","ean-not-found");
        }
        
        if ( oxConfig::getParameter('fnc') == 'jxbcSaveReceipt' ) {
            $aProducts = array();
            $oSmarty->assign("message","receipt-saved");
        }
        
        $aProducts = array_reverse($aProducts); //reverse to show newest first
        
        $oSmarty->assign("picurl",$sPicUrl);
        $oSmarty->assign("pic1url",$sPic1Url);
        $oSmarty->assign("iconurl",$sIconUrl);
        //$oSmarty->assign("aGtins",$aGtins);
        $oSmarty->assign("sprevgtin",$sPrevGtin);
        $oSmarty->assign("aProducts",$aProducts);
        //echo count($aProduct);
        $oSmarty->assign("aProduct",$aProduct);

        return $this->_sThisTemplate;
    }
    
    
    public function jxbcSaveReceipt()
    {
        $myConfig = oxRegistry::get("oxConfig");
        
        $aOxids = oxConfig::getParameter( 'jxbcscan_oxid' );
        $aAmount = oxConfig::getParameter( 'jxbcscan_amount' );
        $aProducts = $this->getAllArticles( $aOxids );
        $aProducts = $this->addAmount( $aAmount, $aProducts );
        /*echo '<hr><pre>';
        print_r($aProducts);
        echo '</pre><hr>'; /* */
        
        $bConfig_UseShopStock = $myConfig->getConfigParam("bJxBcScanUseShopStock");
        if ($bConfig_UseShopStock) {
            foreach ($aProducts as $Product) {
                $sSql = "UPDATE oxarticles SET oxstock=oxstock+{$Product['oxamount']} WHERE oxid='{$Product['oxid']}' ";
                //echo $sSql.'<br>';
                $oDb = oxDb::getDb();
                $ret = $oDb->Execute($sSql);
            }
        }

        $bConfig_UseInventoryStock = $myConfig->getConfigParam("bJxBcScanUseInventoryStock");
        if ($bConfig_UseInventoryStock) {
            foreach ($aProducts as $Product) {
                $sSql = "INSERT INTO jxinvarticles (jxartid, jxinvstock) VALUES ('{$Product['oxid']}', {$Product['oxamount']}) "
                      . "ON DUPLICATE KEY UPDATE jxinvstock=jxinvstock+{$Product['oxamount']} ";
                //echo $sSql.'<br>';
                $oDb = oxDb::getDb();
                $ret = $oDb->Execute($sSql);
            }
        }

        return;
    }
    
    /*
    public function jxbcChooseProduct()
    {
        $myConfig = oxRegistry::get("oxConfig");
        
        $aGtins = oxConfig::getParameter( 'jxbcscan_gtin' );
        $aAmount = oxConfig::getParameter( 'jxbcscan_amount' );
        $aProducts = $this->getAllArticles( $aGtins );
        $aProducts = $this->addAmount( $aAmount, $aProducts );
        
        return;
    }
    */
    
    public function getAllArticles( $aOxids )
    {
        $aProducts = array();
        foreach ($aOxids as $sOxid) {
            array_push( $aProducts, $this->getArticleById($sOxid) );
        }
        return $aProducts;
    }
    
    
    public function increaseAmount( $sOxid, $aProducts )
    {
        foreach ($aProducts as $key => $Product) {
            if ($Product['oxid'] == $sOxid)
                $aProducts[$key]['oxamount'] += 1;
        }
        return $aProducts;
    }
    
    
    public function yetScanned( $sOxid, $aProducts )
    {
        foreach ($aProducts as $key => $Product) {
            if ($Product['oxid'] == $sOxid)
                return TRUE;
        }
        return FALSE;
    }
    
    
    public function addAmount( $aAmount, $aProducts )
    {
        foreach ($aProducts as $key => $Product) {
            $aProducts[$key]['oxamount'] = $aAmount[$key];
        }
        return $aProducts;
    }
    
}

?>