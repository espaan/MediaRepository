'use strict';

var currentMediaRepositoryEditor = null;
var currentMediaRepositoryInput = null;

/**
 * Returns the attributes used for the popup window. 
 * @return {String}
 */
function getPopupAttributes() {
    var pWidth, pHeight;

    pWidth = screen.width * 0.75;
    pHeight = screen.height * 0.66;
    return 'width=' + pWidth + ',height=' + pHeight + ',scrollbars,resizable';
}

/**
 * Open a popup window with the finder triggered by a Xinha button.
 */
function MediaRepositoryFinderXinha(editor, medrepURL) {
	var popupAttributes;

    // Save editor for access in selector window
    currentMediaRepositoryEditor = editor;

    popupAttributes = getPopupAttributes();
    window.open(medrepURL, '', popupAttributes);
}



var mediarepository = {};

mediarepository.finder = {};

mediarepository.finder.onLoad = function (baseId, selectedId) {
    $('MediaRepository_sort').observe('change', mediarepository.finder.onParamChanged);
    $('MediaRepository_sortdir').observe('change', mediarepository.finder.onParamChanged);
    $('MediaRepository_pagesize').observe('change', mediarepository.finder.onParamChanged);
    $('MediaRepository_gosearch').observe('click', mediarepository.finder.onParamChanged)
                           .observe('keypress', mediarepository.finder.onParamChanged);
    $('MediaRepository_submit').hide();
    $('MediaRepository_cancel').observe('click', mediarepository.finder.handleCancel);
};

mediarepository.finder.onParamChanged = function () {
    $('selectorForm').submit();
};

mediarepository.finder.handleCancel = function () {
    var editor, w;

    editor = $F('editorName');
    if (editor === 'xinha') {
        w = parent.window;
        window.close();
        w.focus();
    } else if (editor === 'tinymce') {
        tinyMCEPopup.close();
        //medrepClosePopup();
    } else if (editor === 'ckeditor') {
        /** to be done*/
    } else {
        alert('Close Editor: ' + editor);
    }
};


function getPasteSnippet(mode, itemId) {
    var itemUrl, itemTitle, itemDescription, pasteMode;

    itemUrl = $F('url' + itemId);
    itemTitle = $F('title' + itemId);
    itemDescription = $F('desc' + itemId);

    pasteMode = $F('MediaRepository_pasteas');

    if (pasteMode === '2' || pasteMode !== '1') {
        return itemId;
    }

    // return link to item
    if (mode === 'url') {
        // plugin mode
        return itemUrl;
    } else {
        // editor mode
        return '<a href="' + itemUrl + '" title="' + itemDescription + '">' + itemTitle + '</a>';
    }
}


// User clicks on "select item" button
mediarepository.finder.selectItem = function (itemId) {
    var editor, html;

    editor = $F('editorName');
    if (editor === 'xinha') {
        if (window.opener.currentMediaRepositoryEditor !== null) {
            html = getPasteSnippet('html', itemId);

            window.opener.currentMediaRepositoryEditor.focusEditor();
            window.opener.currentMediaRepositoryEditor.insertHTML(html);
        } else {
            html = getPasteSnippet('url', itemId);
            var currentInput = window.opener.currentMediaRepositoryInput;

            if (currentInput.tagName === 'INPUT') {
                // Simply overwrite value of input elements
                currentInput.value = html;
            } else if (currentInput.tagName === 'TEXTAREA') {
                // Try to paste into textarea - technique depends on environment
                if (typeof document.selection !== 'undefined') {
                    // IE: Move focus to textarea (which fortunately keeps its current selection) and overwrite selection
                    currentInput.focus();
                    window.opener.document.selection.createRange().text = html;
                } else if (typeof currentInput.selectionStart !== 'undefined') {
                    // Firefox: Get start and end points of selection and create new value based on old value
                    var startPos = currentInput.selectionStart;
                    var endPos = currentInput.selectionEnd;
                    currentInput.value = currentInput.value.substring(0, startPos)
                                        + html
                                        + currentInput.value.substring(endPos, currentInput.value.length);
                } else {
                    // Others: just append to the current value
                    currentInput.value += html;
                }
            }
        }
    } else if (editor === 'tinymce') {
        html = getPasteSnippet('html', itemId);
        tinyMCEPopup.editor.execCommand('mceInsertContent', false, html);
        tinyMCEPopup.close();
        return;
    } else if (editor === 'ckeditor') {
        /** to be done*/
    } else {
        alert('Insert into Editor: ' + editor);
    }
    medrepClosePopup();
};


function medrepClosePopup() {
    window.opener.focus();
    window.close();
}




//=============================================================================
// MediaRepository item selector for Forms
//=============================================================================

mediarepository.itemSelector = {};
mediarepository.itemSelector.items = {};
mediarepository.itemSelector.baseId = 0;
mediarepository.itemSelector.selectedId = 0;

mediarepository.itemSelector.onLoad = function (baseId, selectedId) {
    mediarepository.itemSelector.baseId = baseId;
    mediarepository.itemSelector.selectedId = selectedId;

    // required as a changed object type requires a new instance of the item selector plugin
    $(baseId + '_objecttype').observe('change', mediarepository.itemSelector.onParamChanged);

    if ($(baseId + '_catid') !== undefined) {
        $(baseId + '_catid').observe('change', mediarepository.itemSelector.onParamChanged);
    }
    $(baseId + '_id').observe('change', mediarepository.itemSelector.onItemChanged);
    $(baseId + '_sort').observe('change', mediarepository.itemSelector.onParamChanged);
    $(baseId + '_sortdir').observe('change', mediarepository.itemSelector.onParamChanged);
    $('MediaRepository_gosearch').observe('click', mediarepository.itemSelector.onParamChanged)
                           .observe('keypress', mediarepository.itemSelector.onParamChanged);

    mediarepository.itemSelector.getItemList();
};

mediarepository.itemSelector.onParamChanged = function () {
    $('ajax_indicator').show();

    mediarepository.itemSelector.getItemList();
};

mediarepository.itemSelector.getItemList = function () {
    var baseId, pars, request;

    baseId = mediarepository.itemSelector.baseId;
    pars = 'objectType=' + baseId + '&';
    if ($(baseId + '_catid') !== undefined) {
        pars += 'catid=' + $F(baseId + '_catid') + '&';
    }
    pars += 'sort=' + $F(baseId + '_sort') + '&' +
            'sortdir=' + $F(baseId + '_sortdir') + '&' +
            'searchterm=' + $F(baseId + '_searchterm');

    request = new Zikula.Ajax.Request('ajax.php?module=MediaRepository&func=getItemListFinder', {
        method: 'post',
        parameters: pars,
        onFailure: function(req) {
            Zikula.showajaxerror(req.getMessage());
        },
        onSuccess: function(req) {
            var baseId;
            baseId = mediarepository.itemSelector.baseId;
            mediarepository.itemSelector.items[baseId] = req.getData();
            $('ajax_indicator').hide();
            mediarepository.itemSelector.updateItemDropdownEntries();
            mediarepository.itemSelector.updatePreview();
        }
    });
};

mediarepository.itemSelector.updateItemDropdownEntries = function () {
	var baseId, itemSelector, items, i, item;

    baseId = mediarepository.itemSelector.baseId;
    itemSelector = $(baseId + '_id');
    itemSelector.length = 0;

    items = mediarepository.itemSelector.items[baseId];
    for (i = 0; i < items.length; ++i) {
        item = items[i];
        itemSelector.options[i] = new Option(item.title, item.id, false);
    }

    if (mediarepository.itemSelector.selectedId > 0) {
        $(baseId + '_id').value = mediarepository.itemSelector.selectedId;
    }
};

mediarepository.itemSelector.updatePreview = function () {
    var baseId, items, selectedElement, i;

    baseId = mediarepository.itemSelector.baseId;
    items = mediarepository.itemSelector.items[baseId];

    $(baseId + '_previewcontainer').hide();

    if (items.length === 0) {
        return;
    }

    selectedElement = items[0];
    if (mediarepository.itemSelector.selectedId > 0) {
        for (var i = 0; i < items.length; ++i) {
            if (items[i].id === mediarepository.itemSelector.selectedId) {
                selectedElement = items[i];
                break;
            }
        }
    }

    if (selectedElement !== null) {
        $(baseId + '_previewcontainer').update(window.atob(selectedElement.previewInfo))
                                       .show();
    }
};

mediarepository.itemSelector.onItemChanged = function () {
    var baseId, itemSelector, preview;

    baseId = mediarepository.itemSelector.baseId;
    itemSelector = $(baseId + '_id');
    preview = window.atob(mediarepository.itemSelector.items[baseId][itemSelector.selectedIndex].previewInfo);

    $(baseId + '_previewcontainer').update(preview);
    mediarepository.itemSelector.selectedId = $F(baseId + '_id');
};
