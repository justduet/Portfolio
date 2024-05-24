<?php
/**
 * Chunk English lexicon topic
 *
 * @language en
 * @package modx
 * @subpackage lexicon
 */

// Entry out of alpha order because it must come before the entry it's used in below
$_lang['example_tag_chunk_name'] = 'NameOfChunk';

$_lang['chunk'] = 'Chunk';
$_lang['chunk_category_desc'] = 'Use to group Chunks within the Elements tree.';
$_lang['chunk_code'] = 'Chunk Code (HTML)';
$_lang['chunk_description_desc'] = 'Usage information for this Chunk shown in search results and as a tooltip in the Elements tree.';
$_lang['chunk_delete_confirm'] = 'Sei sicuro di voler cancellare questo Chunk?';
$_lang['chunk_duplicate_confirm'] = 'Sei sicuro di voler duplicare questo Chunk?';
$_lang['chunk_err_create'] = 'Si è verificato un errore durante il tentativo di creare il chunk.';
$_lang['chunk_err_duplicate'] = 'Errore di duplicazione del Chunk.';
$_lang['chunk_err_ae'] = 'Un Chunck con nome "[[+name]]" è già esistente.';
$_lang['chunk_err_invalid_name'] = 'Nome del Chunk non valido.';
$_lang['chunk_err_locked'] = 'Il Chunk è bloccato (locked).';
$_lang['chunk_err_remove'] = 'Si è verificato un errore durante il tentativo di eliminare il chunk.';
$_lang['chunk_err_save'] = 'Si è verificato un errore tentando di salvare Chunk.';
$_lang['chunk_err_nf'] = 'Chunk non trovato!';
$_lang['chunk_err_nfs'] = 'Chunk  con id: [[+id]] non trovato';
$_lang['chunk_err_ns'] = 'Chunk non specificato.';
$_lang['chunk_err_ns_name'] = 'Specificare il nome.';
$_lang['chunk_lock'] = 'Blocca Modifiche Chunk';
$_lang['chunk_lock_desc'] = 'Only users with “edit_locked” permissions can edit this Chunk.';
$_lang['chunk_name_desc'] = 'Place the content generated by this Chunk in a Resource, Template, or other Chunk using the following MODX tag: [[+tag]]';
$_lang['chunk_new'] = 'Crea Chunk';
$_lang['chunk_properties'] = 'Proprietà di default';
$_lang['chunk_tab_general_desc'] = 'Here you can enter the basic attributes for this <em>Chunk</em> as well as its content. The content must be HTML, either placed in the <em>Chunk Code</em> field below or in a static external file, and may include MODX tags. Note, however, that PHP code will not run in this element.';
$_lang['chunk_tag_copied'] = 'Chunk tag copied!';
$_lang['chunks'] = 'Chunks';

// Temporarily match old keys to new ones to ensure compatibility
// --fields
$_lang['chunk_desc_category'] = $_lang['chunk_category_desc'];
$_lang['chunk_desc_description'] = $_lang['chunk_description_desc'];
$_lang['chunk_desc_name'] = $_lang['chunk_name_desc'];
$_lang['chunk_lock_msg'] = $_lang['chunk_lock_desc'];

// --tabs
$_lang['chunk_msg'] = $_lang['chunk_tab_general_desc'];