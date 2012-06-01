'use strict';

/**
 * Initialise a user field with autocompletion.
 */
function medrepInitUserField(fieldName, getterName) {
    if ($(fieldName + 'LiveSearch') === undefined) {
        return;
    }
    $(fieldName + 'LiveSearch').removeClassName('z-hide');
    new Ajax.Autocompleter(
        fieldName + 'Selector',
        fieldName + 'SelectorChoices',
        Zikula.Config.baseURL + 'ajax.php?module=MediaRepository&func=' + getterName,
        {
            paramName: 'fragment',
            minChars: 3,
            indicator: fieldName + 'Indicator',
            afterUpdateElement: function(data) {
                $(fieldName).value = $($(data).value).value;
            }
        }
    );
}


/**
 * Toggles the fields of an auto completion field.
 */
function medrepToggleRelatedItemForm(idPrefix) {
    // if we don't have a toggle link do nothing
    if ($(idPrefix + 'AddLink') === undefined) {
        return;
    }

    // show/hide the toggle link
    $(idPrefix + 'AddLink').toggle();

    // hide/show the fields
    $(idPrefix + 'AddFields').toggle();
}

/**
 * Resets an auto completion field.
 */
function medrepResetRelatedItemForm(idPrefix) {
    // hide the sub form
    medrepToggleRelatedItemForm(idPrefix);

    // reset value of the auto completion field
    $(idPrefix + 'Selector').value = '';
}

/**
 * Helper function to create new Zikula.UI.Window instances.
 * For edit forms we use "iframe: true" to ensure file uploads work without problems.
 * For all other windows we use "iframe: false" because we want the escape key working.
 */
function medrepCreateWindowInstance(containerElem, useIframe) {
    var newWindow;

    // define the new window instance
    newWindow = new Zikula.UI.Window(
        containerElem,
        {
            minmax: true,
            resizable: true,
            //title: containerElem.title,
            width: 600,
            initMaxHeight: 500,
            modal: false,
            iframe: useIframe
        }
    );

    // open it
    newWindow.openHandler();

    // return the instance
    return newWindow;
}

/**
 * Observe a link for opening an inline window
 */
function medrepInitInlineWindow(objectType, containerID) {
    var found, newItem;

    // whether the handler has been found
    found = false;

    // search for the handler
    relationHandler.each(function (relationHandler) {
        // is this the right one
        if (relationHandler.prefix === containerID) {
            // yes, it is
            found = true;
            // look whether there is already a window instance
            if (relationHandler.windowInstance !== null) {
                // unset it
                relationHandler.windowInstance.destroy();
            }
            // create and assign the new window instance
            relationHandler.windowInstance = medrepCreateWindowInstance($(containerID), true);
        }
    });

    // if no handler was found
    if (found === false) {
        // create a new one
        newItem = new Object();
        newItem.ot = objectType;
        newItem.alias = '';
        newItem.prefix = containerID;
        newItem.acInstance = null;
        newItem.windowInstance = medrepCreateWindowInstance($(containerID), true);

        // add it to the list of handlers
        relationHandler.push(newItem);
    }
}

/**
 * Removes a related item from the list of selected ones.
 */
function medrepRemoveRelatedItem(idPrefix, removeId) {
    var itemIds, itemIdsArr;

    itemIds = $F(idPrefix + 'ItemList');
    itemIdsArr = itemIds.split(',');

    itemIdsArr = itemIdsArr.without(removeId);

    itemIds = itemIdsArr.join(',');

    $(idPrefix + 'ItemList').value = itemIds;
    $(idPrefix + 'Reference_' + removeId).remove();
}

/**
 * Add a related item to selection which has been chosen by auto completion
 */
function medrepSelectRelatedItem(objectType, idPrefix, inputField, selectedListItem) {
    var newItemId, newTitle, includeEditing, editLink, removeLink, elemPrefix, itemPreview, li, editHref, fldPreview, itemIds, itemIdsArr;

    newItemId = selectedListItem.id;
    newTitle = $F(idPrefix + 'Selector');
    includeEditing = !!(($F(idPrefix + 'Mode') == '1'));
    elemPrefix = idPrefix + 'Reference_' + newItemId;
    itemPreview = '';

    if ($('itempreview' + selectedListItem.id) !== null) {
        itemPreview = $('itempreview' + selectedListItem.id).innerHTML;
    }

    var li = Builder.node('li', {id: elemPrefix}, newTitle);
    if (includeEditing === true) {
        var editHref = $(idPrefix + 'SelectorDoNew').href + '&id=' + newItemId;
        editLink = Builder.node('a', {id: elemPrefix + 'Edit', href: editHref}, 'edit');
        li.appendChild(editLink);
    }
    removeLink = Builder.node('a', {id: elemPrefix + 'Remove', href: 'javascript:medrepRemoveRelatedItem(\'' + idPrefix + '\', ' + newItemId + ');'}, 'remove');
    li.appendChild(removeLink);
    if (itemPreview !== '') {
        fldPreview = Builder.node('div', {id: elemPrefix + 'preview', name: idPrefix + 'preview'}, '');
        fldPreview.update(itemPreview);
        li.appendChild(fldPreview);
        itemPreview = '';
    }
    $(idPrefix + 'ReferenceList').appendChild(li);

    if (includeEditing === true) {
        editLink.update(' ' + editImage);

        $(elemPrefix + 'Edit').observe('click', function (e) {
            medrepInitInlineWindow(objectType, idPrefix + 'Reference_' + newItemId + 'Edit');
            e.stop();
        });
    }
    removeLink.update(' ' + removeImage);

    itemIds = $F(idPrefix + 'ItemList');
    if (itemIds !== '') {
        if ($F(idPrefix + 'Scope') === '0') {
            itemIdsArr = itemIds.split(',');
            itemIdsArr.each(function (existingId) {
                if (existingId) {
                    medrepRemoveRelatedItem(idPrefix, existingId);
                }
            });
            itemIds = '';
        } else {
            itemIds += ',';
        }
    }
    itemIds += newItemId;
    $(idPrefix + 'ItemList').value = itemIds;

    medrepResetRelatedItemForm(idPrefix);
}

/**
 * Initialise a relation field section with autocompletion and optional edit capabilities
 */
function medrepInitRelationItemsForm(objectType, idPrefix, includeEditing) {
    var acOptions, itemIds, itemIdsArr;

    // add handling for the toggle link if existing
    if ($(idPrefix + 'AddLink') !== undefined) {
        $(idPrefix + 'AddLink').observe('click', function (e) { medrepToggleRelatedItemForm(idPrefix); });
    }
    // add handling for the cancel button
    if ($(idPrefix + 'SelectorDoCancel') !== undefined) {
        $(idPrefix + 'SelectorDoCancel').observe('click', function (e) { medrepResetRelatedItemForm(idPrefix); });
    }
    // clear values and ensure starting state
    medrepResetRelatedItemForm(idPrefix);

    acOptions = {
        paramName: 'fragment',
        minChars: 2,
        indicator: idPrefix + 'Indicator',
        callback: function (inputField, defaultQueryString) {
            var queryString;

            // modify the query string before the request
            queryString = defaultQueryString + '&ot=' + objectType;
            if ($(idPrefix + 'ItemList') !== undefined) {
                queryString += '&exclude=' + $F(idPrefix + 'ItemList');
            }
            return queryString;
        },
        afterUpdateElement: function (inputField, selectedListItem) {
            // Called after the input element has been updated (i.e. when the user has selected an entry).
            // This function is called after the built-in function that adds the list item text to the input field.
            medrepSelectRelatedItem(objectType, idPrefix, inputField, selectedListItem);
        }
    };
    relationHandler.each(function (relationHandler) {
        if (relationHandler.prefix === (idPrefix + 'SelectorDoNew') && relationHandler.acInstance === null) {
            relationHandler.acInstance = new Ajax.Autocompleter(
                idPrefix + 'Selector',
                idPrefix + 'SelectorChoices',
                Zikula.Config.baseURL + 'ajax.php?module=MediaRepository&func=getItemListAutoCompletion',
                acOptions
            );
        }
    });

    if (!includeEditing || $(idPrefix + 'SelectorDoNew') === undefined) {
        return;
    }

    // from here inline editing will be handled
    $(idPrefix + 'SelectorDoNew').href += '&theme=Printer&idp=' + idPrefix + 'SelectorDoNew';
    $(idPrefix + 'SelectorDoNew').observe('click', function(e) {
        medrepInitInlineWindow(objectType, idPrefix + 'SelectorDoNew');
        e.stop();
    });

    itemIds = $F(idPrefix + 'ItemList');
    itemIdsArr = itemIds.split(',');
    itemIdsArr.each(function (existingId) {
        var elemPrefix;

        if (existingId) {
            elemPrefix = idPrefix + 'Reference_' + existingId + 'Edit';
            $(elemPrefix).href += '&theme=Printer&idp=' + elemPrefix;
            $(elemPrefix).observe('click', function (e) {
                medrepInitInlineWindow(objectType, elemPrefix);
                e.stop();
            });
        }
    });
}

/**
 * Closes an iframe from the document displayed in it
 */
function medrepCloseWindowFromInside(idPrefix, itemId) {
    // if there is no parent window do nothing
    if (window.parent === '') {
        return;
    }

    // search for the handler of the current window
    window.parent.relationHandler.each(function (relationHandler) {
        // look if this handler is the right one
        if (relationHandler['prefix'] === idPrefix) {
            // do we have an item created
            if (itemId > 0) {
                // look whether there is an auto completion instance
                if (relationHandler.acInstance !== null) {
                    // activate it
                    relationHandler.acInstance.activate();
                    // show a message 
                    Zikula.UI.Alert('Action has been completed.', 'Information');
                }
            }
            // look whether there is a windows instance
            if (relationHandler.windowInstance !== null) {
                // close it
                relationHandler.windowInstance.closeHandler();
            }
        }
    });
}

// TODO: support auto-hiding notification windows (see https://github.com/zikula/core/issues/121 for more information)
