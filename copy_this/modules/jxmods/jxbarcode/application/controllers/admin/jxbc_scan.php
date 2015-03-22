<?php

/*
 *    This file is part of the module jxBarcode for OXID eShop Community Edition.
 *
 *    The module jxBarcode for OXID eShop Community Edition is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    The module jxBarcode for OXID eShop Community Edition is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with OXID eShop Community Edition.  If not, see <http://www.gnu.org/licenses/>.
 *
 * @link      https://github.com/job963/jxBarcode
 * @license   http://www.gnu.org/licenses/gpl-3.0.html GPL v3 or later
 * @copyright (C) Joachim Barthel 2012-2015
 *
 */
 
class jxbc_scan extends oxAdminView
{
    protected $_sThisTemplate = "jxbc_scan.tpl";
    
    public function render()
    {
        parent::render();
        
        $myConfig = oxRegistry::get("oxConfig");
        $sPicUrl = $myConfig->getPictureUrl(FALSE) . 'master/product/1';
        $sThumbUrl = $myConfig->getPictureUrl(FALSE) . 'generated/product/' . 'icon/' . str_replace('*','_',$myConfig->getConfigParam( 'sIconsize' )) . '_' . $myConfig->getConfigParam( 'sDefaultImageQuality' );

        $sGtin = $this->getConfig()->getRequestParameter( 'oxgtin' );
        
        if (!empty($sGtin)) {
            $aProducts = array();
            $aProducts = $this->getArticleByGtin($sGtin); /* */
        }
        if ( (count($aProducts) == 0) && ($sGtin != "") ) {
            $this->_aViewData["message"] = "ean-not-found";
        }
        
        $oModule = oxNew('oxModule');
        $oModule->load('jxbarcode');
        $this->_aViewData["sModuleId"] = $oModule->getId();
        $this->_aViewData["sModuleVersion"] = $oModule->getInfo('version');
        
        $this->_aViewData["picurl"] = $sPicUrl;
        $this->_aViewData["thumburl"] = $sThumbUrl;
        $this->_aViewData["aproducts"] = $aProducts;

        return $this->_sThisTemplate;
    }

    
    public function getArticleByGtin($sGtin)
    {
        if (strlen($sGtin) == 12) //UPC-Code
            $sGtin = '0' . $sGtin;
        
        $myConfig = oxRegistry::get( "oxConfig" );
        $eanField = $myConfig->getConfigParam( "sJxBarcodeEanField" );
        
        $sSql = "SELECT a.oxid, a.oxactive, a.oxartnum, IF(a.oxparentid != '',(SELECT b.oxtitle FROM oxarticles b WHERE b.oxid=a.oxparentid),oxtitle) AS oxtitle, "
                    . "a.oxvarselect, a.{$eanField} AS oxgtin, a.oxbprice, a.oxprice, a.oxstock, 1 AS oxamount, "
                    . "IF(a.oxparentid != '' && a.oxicon = '' ,(SELECT c.oxicon FROM oxarticles c WHERE c.oxid=a.oxparentid),a.oxicon) AS oxicon, "
                    . "IF(a.oxparentid != '' && a.oxpic1 = '' ,(SELECT c.oxpic1 FROM oxarticles c WHERE c.oxid=a.oxparentid),a.oxpic1) AS oxpic1 "
                . "FROM oxarticles a "
                . "WHERE a.{$eanField} = '{$sGtin}' ";

        //echo '<pre>'.$sSql.'</pre>';
        $oDb = oxDb::getDb( oxDB::FETCH_MODE_ASSOC );
        $rs = $oDb->Execute($sSql);

        $aProducts = array();
        while (!$rs->EOF) {
            array_push($aProducts, $rs->fields);
            $rs->MoveNext();
        }

        return $aProducts;
    }

    
    public function getArticleById($sOxid)
    {
        $myConfig = oxRegistry::get( "oxConfig" );
        $eanField = $myConfig->getConfigParam( "sJxBarcodeEanField" );
        
        $sSql = "SELECT a.oxid, a.oxactive, a.oxartnum, IF(a.oxparentid != '',(SELECT b.oxtitle FROM oxarticles b WHERE b.oxid=a.oxparentid),oxtitle) AS oxtitle, "
                    . "a.oxvarselect, a.{$eanField} AS oxgtin, a.oxbprice, a.oxprice, 1 AS oxamount, "
                    . "IF(a.oxparentid != '' && a.oxicon = '' ,(SELECT c.oxicon FROM oxarticles c WHERE c.oxid=a.oxparentid),a.oxicon) AS oxicon, "
                    . "IF(a.oxparentid != '' && a.oxpic1 = '' ,(SELECT c.oxpic1 FROM oxarticles c WHERE c.oxid=a.oxparentid),a.oxpic1) AS oxpic1 "
                . "FROM oxarticles a "
                . "WHERE a.oxid = '{$sOxid}' ";

        //echo '<pre>'.$sSql.'</pre>';
        $oDb = oxDb::getDb( oxDB::FETCH_MODE_ASSOC );
        $rs = $oDb->Execute($sSql);

        $aProducts = array();
        while (!$rs->EOF) {
            array_push($aProducts, $rs->fields);
            $rs->MoveNext();
        }

        return $aProducts[0];
    }
}

?>