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
        $sInvoiceNo = $this->getConfig()->getRequestParameter( 'jxInvoiceNo' );
        if ( !$sInvoiceNo ) {
            $aPackingList = array();
        }
        else {
            $sGtin = $this->getConfig()->getRequestParameter( 'jxGtin' );
            $aPackingList = $this->getPackingList($sInvoiceNo);
        }

        $oModule = oxNew('oxModule');
        $oModule->load('jxbarcode');
        $this->_aViewData["sModuleId"] = $oModule->getId();
        $this->_aViewData["sModuleVersion"] = $oModule->getInfo('version');

        $this->_aViewData["jxInvoiceNo"] = $sInvoiceNo;
        $this->_aViewData["jxPackingList"] = $aPackingList;

        return $this->_sThisTemplate;
    }
    
    
    public function getPackingList( $sInvoiceNo ) 
    {
        $myConfig = oxRegistry::get( "oxConfig" );
        $eanField = $myConfig->getConfigParam( "sJxBarcodeEanField" );

        $sSql = "SELECT oa.oxid, oa.oxartnum, oa.oxtitle, oa.oxselvariant, 0 AS jxchecked, a.{$eanField} AS oxgtin,"
                    . "oa.oxbprice, oa.oxprice, a.oxstock, oa.oxamount AS oxamount "
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
        /*echo 'aProdList:<pre>';
        print_r($aProdList);
        echo '</pre>';*/
        
        return $aProdList;
    }
    
}