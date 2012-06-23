'use strict';

var medrepContextMenu;

medrepContextMenu = Class.create(Control.ContextMenu, {
    selectMenuItem: function ($super, event, item, item_container) {
        // open in new tab / window when right-clicked
        if (event.isRightClick()) {
            item.callback(this.clicked, true);
            event.stop(); // close the menu
            return;
        }
        // open in current window when left-clicked
        return $super(event, item, item_container);
    }
});

/**
 * Initialises the context menu for item actions.
 */
function medrepInitItemActions(objectType, func, containerId) {
    var triggerId, contextMenu, iconFile;

    triggerId = containerId + 'trigger';

    // attach context menu
    //contextMenu = new Control.ContextMenu(triggerId, { leftClick: true, animation: false });
    contextMenu = new medrepContextMenu(triggerId, { leftClick: true, animation: false });

    // process normal links
    $$('#' + containerId + ' a').each(function (elem) {
        // hide it
        elem.hide();
        // determine the link text
        var linkText = '';
        if (func === 'display') {
            linkText = elem.innerHTML;
        } else if (func === 'view') {
            elem.select('img').each(function (imgElem) {
                linkText = imgElem.readAttribute('alt');
            });
        }

        // determine the icon
        iconFile = '';
        if (func === 'display') {
            if (elem.hasClassName('z-icon-es-preview')) {
                iconFile = 'xeyes.png';
            } else if (elem.hasClassName('z-icon-es-display')) {
                iconFile = 'kview.png';
            } else if (elem.hasClassName('z-icon-es-edit')) {
                iconFile = 'edit';
            } else if (elem.hasClassName('z-icon-es-saveas')) {
                iconFile = 'filesaveas';
            } else if (elem.hasClassName('z-icon-es-delete')) {
                iconFile = '14_layer_deletelayer';
            } else if (elem.hasClassName('z-icon-es-back')) {
                iconFile = 'agt_back';
            }
            if (iconFile !== '') {
                iconFile = '/images/icons/extrasmall/' + iconFile + '.png';
            }
        } else if (func === 'view') {
            elem.select('img').each(function (imgElem) {
                iconFile = imgElem.readAttribute('src');
            });
        }
        if (iconFile !== '') {
            iconFile = '<img src="' + iconFile + '" width="16" height="16" alt="' + linkText + '" /> ';
        }

        contextMenu.addItem({
            label: iconFile + linkText,
            callback: function (selectedMenuItem, isRightClick) {
                var url;

                url = elem.readAttribute('href');
                if (isRightClick) {
                    window.open(url);
                } else {
                    window.location = url;
                }
            }
        });
    });
    $(triggerId).show();
}

function medrepCapitaliseFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

/**
 * Submits a quick navigation form.
 */
function medrepSubmitQuickNavForm(objectType) {
    $('medrep' + medrepCapitaliseFirstLetter(objectType) + 'QuickNavForm').submit();
}

/**
 * Initialise the quick navigation panel in list views.
 */
function medrepInitQuickNavigation(objectType, controller) {
    if ($('medrep' + medrepCapitaliseFirstLetter(objectType) + 'QuickNavForm') === undefined) {
        return;
    }

    if ($('catid') !== undefined) {
        $('catid').observe('change', function () { medrepSubmitQuickNavForm(objectType); });
    }
    if ($('sortby') !== undefined) {
        $('sortby').observe('change', function () { medrepSubmitQuickNavForm(objectType); });
    }
    if ($('sortdir') !== undefined) {
        $('sortdir').observe('change', function () { medrepSubmitQuickNavForm(objectType); });
    }
    if ($('num') !== undefined) {
        $('num').observe('change', function () { medrepSubmitQuickNavForm(objectType); });
    }

    switch (objectType) {
    case 'repository':
        if ($('useQuota') !== undefined) {
            $('useQuota').observe('click', function () { medrepSubmitQuickNavForm(objectType); })
                                     .observe('keypress', function () { medrepSubmitQuickNavForm(objectType); });
        }
        if ($('allowManagementOfOwnFiles') !== undefined) {
            $('allowManagementOfOwnFiles').observe('click', function () { medrepSubmitQuickNavForm(objectType); })
                                     .observe('keypress', function () { medrepSubmitQuickNavForm(objectType); });
        }
        if ($('allowFileMailing') !== undefined) {
            $('allowFileMailing').observe('click', function () { medrepSubmitQuickNavForm(objectType); })
                                     .observe('keypress', function () { medrepSubmitQuickNavForm(objectType); });
        }
        if ($('enableSharpen') !== undefined) {
            $('enableSharpen').observe('click', function () { medrepSubmitQuickNavForm(objectType); })
                                     .observe('keypress', function () { medrepSubmitQuickNavForm(objectType); });
        }
        if ($('enableShrinking') !== undefined) {
            $('enableShrinking').observe('click', function () { medrepSubmitQuickNavForm(objectType); })
                                     .observe('keypress', function () { medrepSubmitQuickNavForm(objectType); });
        }
        if ($('useThumbCropper') !== undefined) {
            $('useThumbCropper').observe('click', function () { medrepSubmitQuickNavForm(objectType); })
                                     .observe('keypress', function () { medrepSubmitQuickNavForm(objectType); });
        }
        if ($('sendMailAfterUpload') !== undefined) {
            $('sendMailAfterUpload').observe('click', function () { medrepSubmitQuickNavForm(objectType); })
                                     .observe('keypress', function () { medrepSubmitQuickNavForm(objectType); });
        }
        break;
    case 'mediaHandler':
        if ($('active') !== undefined) {
            $('active').observe('click', function () { medrepSubmitQuickNavForm(objectType); })
                                     .observe('keypress', function () { medrepSubmitQuickNavForm(objectType); });
        }
        break;
    case 'medium':
        if ($('owner') !== undefined) {
            $('owner').observe('change', function () { medrepSubmitQuickNavForm(objectType); });
        }
        if ($('showLocation') !== undefined) {
            $('showLocation').observe('click', function () { medrepSubmitQuickNavForm(objectType); })
                                     .observe('keypress', function () { medrepSubmitQuickNavForm(objectType); });
        }
        break;
    case 'thumbSize':
        if ($('keepAspectRatio') !== undefined) {
            $('keepAspectRatio').observe('click', function () { medrepSubmitQuickNavForm(objectType); })
                                     .observe('keypress', function () { medrepSubmitQuickNavForm(objectType); });
        }
        break;
    default:
        break;
    }
}

/**
 * Helper function to create new Zikula.UI.Window instances.
 * For edit forms we use "iframe: true" to ensure file uploads work without problems.
 * For all other windows we use "iframe: false" because we want the escape key working.
 */
function medrepInitInlineWindow(containerElem, title) {
    var newWindow;

    // show the container (hidden for users without JavaScript)
    containerElem.show();

    // define the new window instance
    newWindow = new Zikula.UI.Window(
        containerElem,
        {
            minmax: true,
            resizable: true,
            title: title,
            width: 600,
            initMaxHeight: 400,
            modal: false,
            iframe: false
        }
    );

    // return the instance
    return newWindow;
}


/**
 * Initialise ajax-based toggle for boolean fields.
 */
function medrepInitToggle(objectType, fieldName, itemId)
{
    var idSuffix = fieldName.toLowerCase() + itemId;
    if ($('toggle' + idSuffix) == undefined) {
        return;
    }
    $('toggle' + idSuffix).observe('click', function() {
        medrepToggleFlag(objectType, fieldName, itemId);
    }).show();
}


/**
 * Toggle a certain flag for a given item.
 */
function medrepToggleFlag(objectType, fieldName, itemId)
{
    var pars = 'ot=' + objectType + '&field=' + fieldName + '&id=' + itemId;

    new Zikula.Ajax.Request(
        Zikula.Config.baseURL + 'ajax.php?module=MediaRepository&func=toggleFlag',
        {
            method: 'post',
            parameters: pars,
            onComplete: function(req) {
                if (!req.isSuccess()) {
                    Zikula.UI.Alert(req.getMessage(), Zikula.__('Error', 'module_MediaRepository'));
                    return;
                }
                var data = req.getData();
                /*if (data.message) {
                    Zikula.UI.Alert(data.message, Zikula.__('Success', 'module_MediaRepository'));
                }*/

                var idSuffix = fieldName.toLowerCase() + '_' + itemId;
                var state = data.state;
                if (state === true) {
                    $('no' + idSuffix).hide();
                    $('yes' + idSuffix).show();
                } else {
                    $('yes' + idSuffix).hide();
                    $('no' + idSuffix).show();
                }
            }
        }
    );
}
