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
 
class jxbc_packing extends jxbc_scan
{
    protected $_sThisTemplate = "jxbc_packing.tpl";
    
    public function render()
    {
        $myConfig = oxRegistry::get("oxConfig");
        $sPicUrl = $myConfig->getPictureUrl(FALSE) . 'master/product/1';
        $sPic1Url = $myConfig->getPictureUrl(FALSE) . 'generated/product/' . '1/' . str_replace('*','_',$myConfig->getConfigParam( 'sIconsize' )) . '_' . $myConfig->getConfigParam( 'sDefaultImageQuality' );
        $sIconUrl = $myConfig->getPictureUrl(FALSE) . 'generated/product/' . 'icon/' . str_replace('*','_',$myConfig->getConfigParam( 'sIconsize' )) . '_' . $myConfig->getConfigParam( 'sDefaultImageQuality' );

        $sInvoiceNo = $this->getConfig()->getRequestParameter( 'jxInvoiceNo' );
        if ( !$sInvoiceNo ) {
            $aPackingList = array();
            $aOxid = array();
            $aPieces = array();
        }
        elseif ( $this->isPackingChecked($sInvoiceNo) ) {
            $sInvoiceNo = '';
            if ( $this->getConfig()->getRequestParameter( 'fnc' ) == 'jxbcSavePackingList' ) {
                $this->_aViewData["message"] = "check-saved";
            }
            else {
                $this->_aViewData["message"] = "already-checked";
            }
            $aPackingList = array();
            $aOxid = array();
            $aPieces = array();
        }
        else {
            $sGtin = $this->getConfig()->getRequestParameter( 'jxGtin' );
            $aPackingList = $this->getPackingList($sInvoiceNo);
            $aPieces = $this->getConfig()->getRequestParameter( 'jxbc_pieces' );
            $aPackingList = $this->addPieces( $aPieces, $aPackingList );

            if ( $sGtin ) {
                // add new piece of article based on the scanned GTIN
                if ( $this->isGtinInPackingList( $sGtin, $aPackingList ) ) {
                    $aPackingList = $this->addPieceToPacking( $sGtin, $aPackingList );
                }
                else {
                    $this->_aViewData["message"] = "wrong-article";
                }
            }
            if ( $this->checkPackingDone($aPackingList) == 1 ) {
                $this->_aViewData["message"] = "packing-done";
            }
            if ( $this->checkPackingDone($aPackingList) == 2 ) {
                $this->_aViewData["message"] = "to-many-items";
            }
        }

        $oModule = oxNew('oxModule');
        $oModule->load('jxbarcode');
        $this->_aViewData["sModuleId"] = $oModule->getId();
        $this->_aViewData["sModuleVersion"] = $oModule->getInfo('version');
        
        $this->_aViewData["picurl"] = $sPicUrl;
        $this->_aViewData["pic1url"] = $sPic1Url;
        $this->_aViewData["iconurl"] = $sIconUrl;

        $this->_aViewData["sInvoiceNo"] = $sInvoiceNo;
        $this->_aViewData["aPackingList"] = $aPackingList;

        return $this->_sThisTemplate;
    }
    
    
    public function getPackingList( $sInvoiceNo ) 
    {
        $myConfig = oxRegistry::get( "oxConfig" );
        $eanField = $myConfig->getConfigParam( "sJxBarcodeEanField" );

        $sSql = "SELECT oa.oxid, oa.oxartnum, oa.oxtitle, oa.oxselvariant, 0 AS jxchecked, a.{$eanField} AS oxgtin,"
                    . "oa.oxbprice, oa.oxprice, a.oxstock, oa.oxamount AS oxamount, "
                    . "IF(a.oxparentid != '' && a.oxicon = '' ,(SELECT c.oxicon FROM oxarticles c WHERE c.oxid=a.oxparentid),a.oxicon) AS oxicon, "
                    . "IF(a.oxparentid != '' && a.oxpic1 = '' ,(SELECT c.oxpic1 FROM oxarticles c WHERE c.oxid=a.oxparentid),a.oxpic1) AS oxpic1 "
                . "FROM oxorderarticles oa, oxorder o, oxarticles a "
                . "WHERE "
                    . "oa.oxorderid = o.oxid "
                    . "AND oa.oxartid = a.oxid "
                    . "AND o.oxbillnr = {$sInvoiceNo} ";
                    
        // echo '<pre>'.$sSql.'</pre>';
        $oDb = oxDb::getDb( oxDB::FETCH_MODE_ASSOC );
        try {
        $rs = $oDb->Execute($sSql);
        }
            catch (Exception $e) {
                echo '<div style="border:2px solid #dd0000;margin:10px;padding:5px;background-color:#ffdddd;font-family:sans-serif;font-size:14px;">';
                echo '<b>SQL-Error '.$e->getCode().' in SQL statement</b><br />'.$e->getMessage().'';
                echo '</div>';
                return;
            }
        $aProdList = array();
        while (!$rs->EOF) {
            array_push($aProdList, $rs->fields);
            $rs->MoveNext();
        }
        
        return $aProdList;
    }
    
    
    public function addPieces( $aPieces, $aPackingList )
    {
        foreach ($aPackingList as $key => $Product) {
            $aPackingList[$key]['pieces'] = $aPieces[$key];
        }
        return $aPackingList;
    }
    
    
    public function checkPackingDone( $aPackingList )
    {
        $done = TRUE;
        $over = FALSE;
        foreach ($aPackingList as $key => $aProduct) {
            if ( $aProduct['pieces'] < $aProduct['oxamount'] ){
                $done = FALSE;
            }
            elseif ( $aProduct['pieces'] > $aProduct['oxamount'] ){
                $over = TRUE;
            }
        }
        
        if ( $over )
            return 2;
        elseif ( $done )
            return 1;
        else
            return 0;
    }
    
    
    public function isGtinInPackingList( $sGtin, $aPackingList )
    {
        foreach ($aPackingList as $key => $aProduct) {
            if ( $aProduct['oxgtin'] == $sGtin ) {
                return TRUE;
            }
        }
        return FALSE;
    }
    
    
    public function isPackingChecked( $sInvoiceNo )
    {
        $oDb = oxDb::getDb();
        if ( $oDb->getOne( "SELECT jxpackinguserid FROM oxorder WHERE oxbillnr='{$sInvoiceNo}' AND jxpackingcheck != '0000-00-00 00:00:00' ", false, false ) ) {
            return TRUE;
        }
        return FALSE;
    }
    
    
    public function addPieceToPacking( $sGtin, $aPackingList )
    {
        foreach ($aPackingList as $key => $aProduct) {
            if ( $aProduct['oxgtin'] == $sGtin ) {
                $aPackingList[$key]['pieces'] = (int)$aPackingList[$key]['pieces'] + 1;
            }
        }
        return $aPackingList;
    }
    
    
    public function jxbcSavePackingList()
    {
        $myConfig = oxRegistry::get("oxConfig");
        
        $sInvoiceNo = $this->getConfig()->getRequestParameter( 'jxInvoiceNo' );
        $sDate = date("Y-m-d H:i:s");
        $oUser = $this->getUser(); 
        $sUserId = $oUser->getId(); 
        
        $sSql = "UPDATE oxorder SET jxpackingcheck='{$sDate}', jxpackinguserid='{$sUserId}' WHERE oxbillnr='{$sInvoiceNo}' ";
        //echo $sSql.'<br>';
        $oDb = oxDb::getDb();
        $ret = $oDb->Execute($sSql);
        
        return;
    }
    
}