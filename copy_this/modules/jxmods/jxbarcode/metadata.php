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
    'version'      => '0.1.2',
    'author'       => 'Joachim Barthel',
    'url'          => 'https://github.com/job963/jxBarcode',
    'email'        => 'jobarthel@gmail.com',
    'extend'       => array(
                        ),
    'files'        => array(
        'jxbcscan' => 'jxmods/jxbarcode/application/controllers/admin/jxbcscan.php',
        'jxbc_receipt' => 'jxmods/jxbarcode/application/controllers/admin/jxbc_receipt.php'
                        ),
    'templates'    => array(
        'jxbcscan.tpl' => 'jxmods/jxbarcode/views/admin/tpl/jxbcscan.tpl',
        'jxbc_receipt.tpl' => 'jxmods/jxbarcode/views/admin/tpl/jxbc_receipt.tpl'
                        ),
    'settings' => array(
                        array(
                            'group' => 'JXBC_SUPPORT', 
                            'name'  => 'bJxBcUseShopStock', 
                            'type'  => 'bool', 
                            'value' => 'false'
                            ),
                        array(
                            'group' => 'JXBC_SUPPORT', 
                            'name'  => 'bJxBcUseInventoryStock', 
                            'type'  => 'bool', 
                            'value' => 'false'
                            )
                        )
    );

?>
