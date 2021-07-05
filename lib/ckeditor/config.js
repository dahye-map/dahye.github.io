/**
 * @license Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	
	config.toolbar =[
	                 ['Source','-','Cut','Copy','Paste','PasteText','PasteFromWord','Undo','Redo','SelectAll','RemoveFormat'],
	                 '/',
	                 ['Bold','Italic','Underline','Strike', 'Subscript','Superscript'],
	                 ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	                 ['NumberedList','BulletedList','Outdent','Indent','Blockquote','CreateDiv'],
	                 ['Image','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
	                 ['Styles','Format','Font','FontSize','TextColor','BGColor','Maximize', 'ShowBlocks']
	             ];
	
	config.font_names = '굴림; 돋움; 궁서; HY견고딕; HY견명조; 휴먼둥근헤드라인;' 
        + '휴먼매직체; 휴먼모음T; 휴먼아미체; 휴먼엑스포; 휴먼옛체; 휴먼편지체; 나눔고딕;' 
        +  CKEDITOR.config.font_names;
	
	config.height = '500';
};

CKEDITOR.config.allowedContent = true; // CSS 사용 허용