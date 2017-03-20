<?php

/**
 * Metadata version
 */
$sMetadataVersion = '1.1';
 
/**
 * Module information
 */
$aModule = array(
    'id'           => 'jxbarcode',
    'title'        => 'jxBarcode - Barcode Scanner Support',
    'description'  => array(
                        'de'=>'Modul f&uuml;r die Barcode-Reader Unterst&uuml;tzung.',
                        'en'=>'Module for barcode reader support.'
                        ),
    'thumbnail'    => 'jxbarcode.png',
    'version'      => '0.3.5',
    'author'       => 'Joachim Barthel',
    'url'          => 'https://github.com/job963/jxBarcode',
    'email'        => 'jobarthel@gmail.com',
    'extend'       => array(
                        'oxorder'  => 'jxmods/jxbarcode/application/models/jxbarcode_myorder'
                        ),
    'files'        => array(
                        'jxbarcode_events' => 'jxmods/jxbarcode/core/jxbarcode_events.php',
                        'jxbc_scan' => 'jxmods/jxbarcode/application/controllers/admin/jxbc_scan.php',
                        'jxbc_receipt' => 'jxmods/jxbarcode/application/controllers/admin/jxbc_receipt.php',
                        'jxbc_packing' => 'jxmods/jxbarcode/application/controllers/admin/jxbc_packing.php'
                        ),
    'templates'    => array(
                        'jxbc_messagebox.tpl' => 'jxmods/jxbarcode/application/views/admin/tpl/inc/jxbc_messagebox.tpl',
                        'jxbc_scan.tpl' => 'jxmods/jxbarcode/application/views/admin/tpl/jxbc_scan.tpl',
                        'jxbc_receipt.tpl' => 'jxmods/jxbarcode/application/views/admin/tpl/jxbc_receipt.tpl',
                        'jxbc_packing.tpl' => 'jxmods/jxbarcode/application/views/admin/tpl/jxbc_packing.tpl'
                        ),
    'events'       => array(
                        'onActivate'   => 'jxbarcode_events::onActivate', 
                        'onDeactivate' => 'jxbarcode_events::onDeactivate'
                        ),
    'settings' => array(
                        array(
                            'group' => 'JXBARCODE_SCAN', 
                            'name'  => 'sJxBarcodeEanField', 
                            'type'  => 'select', 
                            'value' => 'oxean',
                            'constrains' => 'oxean|oxdistean', 
                            'position' => 0 
                            ),
                        array(
                            'group' => 'JXBARCODE_SUPPORT', 
                            'name'  => 'bJxBarcodeUseShopStock', 
                            'type'  => 'bool', 
                            'value' => 'false'
                            ),
                        array(
                            'group' => 'JXBARCODE_SUPPORT', 
                            'name'  => 'bJxBarcodeUseInventoryStock', 
                            'type'  => 'bool', 
                            'value' => 'false'
                            )
                        )
    );

?>
