<?php
/*
 *    This file is part of the module jxBarcode for OXID eShop Community Edition.
 *
 *    The module jxReferer for OXID eShop Community Edition is free software: you can redistribute it and/or modify
 *    it under the terms of the GNU General Public License as published by 
 *    the Free Software Foundation, either version 3 of the License, or
 *    (at your option) any later version.
 *
 *    The module jxReferer for OXID eShop Community Edition is distributed in the hope that it will be useful,
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

class jxBarcode_Events
{ 

    public static function onActivate() 
    { 
        $oDb = oxDb::getDb();   

        $sLogPath = oxRegistry::get("oxConfig")->getConfigParam("sShopDir") . '/log/';
        $fh = fopen($sLogPath.'jxmods.log', "a+");

        $aSql = array();
        $aSql[] = array(
                    "field"     => "JXPACKINGCHECKED",
                    "statement" => "ALTER TABLE `oxorder` ADD COLUMN `JXPACKINGCHECKED` TINYINT(4) NOT NULL DEFAULT '0'  "
                ); 
        
        try {
            foreach ($aSql as $sSql) {
                if ( !$oDb->getOne( "SHOW COLUMNS FROM oxorder LIKE '{$sSql['field']}'", false, false ) ) {
                    $oRs = $oDb->Execute($sSql['statement']);
                }
            }
        }
        catch (Exception $e) {
            fputs( $fh, date("Y-m-d H:i:s ").$e->getMessage() );
            echo '<div style="border:2px solid #dd0000;margin:10px;padding:5px;background-color:#ffdddd;font-family:sans-serif;font-size:14px;">';
            echo '<b>SQL-Error '.$e->getCode().' in SQL statement</b><br />'.$e->getMessage().'';
            echo '</div>';
        }
        fclose($fh);

        return true;
    }

    
    public static function onDeactivate() 
    { 
        $oDb = oxDb::getDb(); 
        $sSql = "DELETE FROM oxtplblocks WHERE OXMODULE = 'jxreferer' ";
        $oRs = $oDb->execute($sSql); 
        
        return true;
    }
    
}    
