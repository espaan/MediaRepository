'use strict';

function medrepToday(format) {
    var timestamp, todayDate, month, day, hours, minutes, seconds;

    timestamp = new Date();
    todayDate = '';
    if (format !== 'time') {
        month = new String((parseInt(timestamp.getMonth()) + 1));
        if (month.length === 1) {
            month = '0' + month;
        }
        day = new String(timestamp.getDate());
        if (day.length === 1) {
            day = '0' + day;
        }
        todayDate += timestamp.getFullYear() + '-' + month + '-' + day;
    }
    if (format === 'datetime') {
        todayDate += ' ';
    }
    if (format != 'date') {
        hours = new String(timestamp.getHours());
        if (hours.length === 1) {
            hours = '0' + hours;
        }
        minutes = new String(timestamp.getMinutes());
        if (minutes.length === 1) {
            minutes = '0' + minutes;
        }
        seconds = new String(timestamp.getSeconds());
        if (seconds.length === 1) {
            seconds = '0' + seconds;
        }
        todayDate += hours + ':' + minutes;// + ':' + seconds;
    }
    return todayDate;
}

// returns YYYY-MM-DD even if date is in DD.MM.YYYY
function medrepReadDate(val, includeTime) {
    // look if we have YYYY-MM-DD
    if (val.substr(4, 1) === '-' && val.substr(7, 1) === '-') {
        return val;
    }

    // look if we have DD.MM.YYYY
    if (val.substr(2, 1) === '.' && val.substr(4, 1) === '.') {
        var newVal = val.substr(6, 4) + '-' + val.substr(3, 2) + '-' + val.substr(0, 2);
        if (includeTime === true) {
            newVal += ' ' + val.substr(11, 5);
        }
        return newVal;
    }
}

/**
 * Add special validation rules.
 */
function medrepAddCommonValidationRules(objectType, id) {
    Validation.addAllThese([
        ['validate-nospace', Zikula.__('No spaces', 'module_MediaRepository'), function(val, elem) {
            var valStr;
            valStr = new String(val);
            return (valStr.indexOf(' ') === -1);
        }],
        ['validate-htmlcolour', Zikula.__('Please select a valid html colour code.', 'module_MediaRepository'), function(val, elem) {
            var valStr;
            valStr = new String(val);
            return Validation.get('IsEmpty').test(val) || (/^#[0-9a-f]{3}([0-9a-f]{3})?$/i.test(valStr));
        }],
        ['validate-upload', Zikula.__('Please select a valid file extension.', 'module_MediaRepository'), function(val, elem) {
            var allowedExtensions;
            if (val === '') {
                return true;
            }
            allowedExtensions = $('fileextensions' + elem.id).innerHTML;
            allowedExtensions = '(.' + allowedExtensions.replace(/, /g, '|.') + ')$';
            allowedExtensions = new RegExp(allowedExtensions, 'i');
            return allowedExtensions.test(val);
        }],
        ['validate-datetime-past', Zikula.__('Please select a value in the past.', 'module_MediaRepository'), function(val, elem) {
            var valStr, cmpVal;
            valStr = new String(val);
            cmpVal = medrepReadDate(valStr, true);
            return Validation.get('IsEmpty').test(val) || (cmpVal < medrepToday('datetime'));
        }],
        ['validate-datetime-future', Zikula.__('Please select a value in the future.', 'module_MediaRepository'), function(val, elem) {
            var valStr, cmpVal;
            valStr = new String(val);
            cmpVal = medrepReadDate(valStr, true);
            return Validation.get('IsEmpty').test(val) || (cmpVal >= medrepToday('datetime'));
        }],
        ['validate-date-past', Zikula.__('Please select a value in the past.', 'module_MediaRepository'), function(val, elem) {
            var valStr, cmpVal;
            valStr = new String(val);
            cmpVal = medrepReadDate(valStr, false);
            return Validation.get('IsEmpty').test(val) || (cmpVal < medrepToday('date'));
        }],
        ['validate-date-future', Zikula.__('Please select a value in the future.', 'module_MediaRepository'), function(val, elem) {
            var valStr, cmpVal;
            valStr = new String(val);
            cmpVal = medrepReadDate(valStr, false);
            return Validation.get('IsEmpty').test(val) || (cmpVal >= medrepToday('date'));
        }],
        ['validate-time-past', Zikula.__('Please select a value in the past.', 'module_MediaRepository'), function(val, elem) {
            var cmpVal;
            cmpVal = new String(val);
            return Validation.get('IsEmpty').test(val) || (cmpVal < medrepToday('time'));
        }],
        ['validate-time-future', Zikula.__('Please select a value in the future.', 'module_MediaRepository'), function(val, elem) {
            var cmpVal;
            cmpVal = new String(val);
            return Validation.get('IsEmpty').test(val) || (cmpVal >= medrepToday('time'));
        }]
    ]);
}
