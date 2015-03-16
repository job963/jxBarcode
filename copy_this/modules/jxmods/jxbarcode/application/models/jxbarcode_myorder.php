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

class jxbarcode_myorder extends jxbarcode_myorder_parent
{
    public function pdfHeader( $oPdf )
    {
        parent::pdfHeader( $oPdf );
        
        $this->pdfBarcode( $oPdf );

        return;
    }   

	
    /**
     * ------ Extension by jxBarcode module ------
     * Method creates barcode with invoice number as content
     * @return null
     */
    public function pdfBarcode( $oPdf )
    {

        $aStyle = array(
                'position' => 'R',
                'align' => 'C',
                'stretch' => false,
                'fitwidth' => true,
                'cellfitalign' => '',
                'border' => false,
                'hpadding' => 'auto',
                'vpadding' => 'auto',
                'fgcolor' => array(0,0,0),
                'bgcolor' => false,
                'text' => false,
                'font' => 'helvetica',
                'fontsize' => 8,
                'stretchtext' => 4
        );

        $sText = sprintf( "%06d", $this->oxorder__oxbillnr->value );
        $oPdf->write1DBarcode($sText, 'C39', '', 74, '', 6, 0.4, $aStyle, 'N');
        $oPdf->Ln();
    }
    
    
}