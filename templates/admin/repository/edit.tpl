{* purpose of this template: build the Form to edit an instance of repository *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/MediaRepository/javascript/MediaRepository_editFunctions.js'}
{pageaddvar name='javascript' value='modules/MediaRepository/javascript/MediaRepository_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit repository' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create repository' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit repository' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="mediarepository-repository mediarepository-edit">
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type=$adminPageIcon size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>
{form cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {mediarepositoryFormFrame}

    {formsetinitialfocus inputId='name'}


    <div class="z-panels" id="MediaRepository_panel">
        <h3 id="z-panel-header-fields" class="z-panel-header z-panel-indicator z-pointer">{gt text='Fields'}</h3>
        <div class="z-panel-content z-panel-active" style="overflow: visible">
            <fieldset>
                <legend>{gt text='Content'}</legend>
                
                <div class="z-formrow">
                    {gt text='Name of this repository, e.g. public download area.' assign='toolTip'}
                    {formlabel for='name' __text='Name' mandatorysym='1' class='mediarepositoryFormTooltips' title=$toolTip}
                    {formtextinput group='repository' id='name' mandatory=true readOnly=false __title='Enter the name of the repository' textMode='singleline' maxLength=255 cssClass='required' }
                    {mediarepositoryValidationError id='name' class='required'}
                </div>
                
                <div class="z-formrow">
                    {gt text='Absolute media upload folder (writable, ideally outside the webroot).' assign='toolTip'}
                    {formlabel for='workDirectory' __text='Work directory' mandatorysym='1' class='mediarepositoryFormTooltips' title=$toolTip}
                    {formtextinput group='repository' id='workDirectory' mandatory=true readOnly=false __title='Enter the work directory of the repository' textMode='singleline' maxLength=255 cssClass='required' }
                    {mediarepositoryValidationError id='workDirectory' class='required'}
                </div>
                
                <div class="z-formrow">
                    {gt text='Absolute repository storage folder (writable, ideally outside the webroot).' assign='toolTip'}
                    {formlabel for='storageDirectory' __text='Storage directory' mandatorysym='1' class='mediarepositoryFormTooltips' title=$toolTip}
                    {formtextinput group='repository' id='storageDirectory' mandatory=true readOnly=false __title='Enter the storage directory of the repository' textMode='singleline' maxLength=255 cssClass='required' }
                    {mediarepositoryValidationError id='storageDirectory' class='required'}
                </div>
                
                <div class="z-formrow">
                    {gt text='Absolute folder for cached files (e.g. thumbnails, writable, inside the webroot).' assign='toolTip'}
                    {formlabel for='cacheDirectory' __text='Cache directory' mandatorysym='1' class='mediarepositoryFormTooltips' title=$toolTip}
                    {formtextinput group='repository' id='cacheDirectory' mandatory=true readOnly=false __title='Enter the cache directory of the repository' textMode='singleline' maxLength=255 cssClass='required' }
                    {mediarepositoryValidationError id='cacheDirectory' class='required'}
                </div>
                
                <div class="z-formrow">
                    {gt text='How media items in this repository should be stored.' assign='toolTip'}
                    {formlabel for='storageMode' __text='Storage mode' mandatorysym='1' class='mediarepositoryFormTooltips' title=$toolTip}
                    {formdropdownlist group='repository' id='storageMode' items=$storageItems mandatory=true __title='Enter the storage mode of the repository'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='permissionScope' __text='Permission scope' mandatorysym='1'}
                    {formintinput group='repository' id='permissionScope' mandatory=true __title='Enter the permission scope of the repository' maxLength=4 cssClass='required validate-digits' }
                    {mediarepositoryValidationError id='permissionScope' class='required'}
                    {mediarepositoryValidationError id='permissionScope' class='validate-digits'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='useQuota' __text='Use quota'}
                    {formcheckbox group='repository' id='useQuota' readOnly=false __title='use quota ?' cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {formlabel for='allowManagementOfOwnFiles' __text='Allow management of own files'}
                    {formcheckbox group='repository' id='allowManagementOfOwnFiles' readOnly=false __title='allow management of own files ?' cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {formlabel for='allowFileMailing' __text='Allow file mailing'}
                    {formcheckbox group='repository' id='allowFileMailing' readOnly=false __title='allow file mailing ?' cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {formlabel for='maxSizeForMail' __text='Max size for mail (in MB)'}
                    {formintinput group='repository' id='maxSizeForMail' mandatory=false __title='Enter the max size for mail of the repository' maxLength=11 cssClass=' validate-digits' }
                    {mediarepositoryValidationError id='maxSizeForMail' class='validate-digits'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='maxFilesPerUpload' __text='Max files per upload' mandatorysym='1'}
                    {formintinput group='repository' id='maxFilesPerUpload' mandatory=true __title='Enter the max files per upload of the repository' maxLength=2 cssClass='required validate-digits' }
                    {mediarepositoryValidationError id='maxFilesPerUpload' class='required'}
                    {mediarepositoryValidationError id='maxFilesPerUpload' class='validate-digits'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='maxUploadFileSize' __text='Max upload file size (in MB)'}
                    {formintinput group='repository' id='maxUploadFileSize' mandatory=false __title='Enter the max upload file size of the repository' maxLength=11 cssClass=' validate-digits' }
                    {mediarepositoryValidationError id='maxUploadFileSize' class='validate-digits'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='uploadNamingConvention' __text='Upload naming convention' mandatorysym='1'}
                    {formintinput group='repository' id='uploadNamingConvention' mandatory=true __title='Enter the upload naming convention of the repository' maxLength=2 cssClass='required validate-digits' }
                    {mediarepositoryValidationError id='uploadNamingConvention' class='required'}
                    {mediarepositoryValidationError id='uploadNamingConvention' class='validate-digits'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='uploadNamingPrefix' __text='Upload naming prefix'}
                    {formtextinput group='repository' id='uploadNamingPrefix' mandatory=false readOnly=false __title='Enter the upload naming prefix of the repository' textMode='singleline' maxLength=50 cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {formlabel for='enableSharpen' __text='Enable sharpen'}
                    {formcheckbox group='repository' id='enableSharpen' readOnly=false __title='enable sharpen ?' cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {formlabel for='enableShrinking' __text='Enable shrinking'}
                    {formcheckbox group='repository' id='enableShrinking' readOnly=false __title='enable shrinking ?' cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {formlabel for='useThumbCropper' __text='Use thumb cropper'}
                    {formcheckbox group='repository' id='useThumbCropper' readOnly=false __title='use thumb cropper ?' cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {formlabel for='cropSizeMode' __text='Crop size mode'}
                    {formintinput group='repository' id='cropSizeMode' mandatory=false __title='Enter the crop size mode of the repository' maxLength=2 cssClass=' validate-digits' }
                    {mediarepositoryValidationError id='cropSizeMode' class='validate-digits'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='defaultTemplateCollection' __text='Default template collection' mandatorysym='1'}
                    {formtextinput group='repository' id='defaultTemplateCollection' mandatory=true readOnly=false __title='Enter the default template collection of the repository' textMode='singleline' maxLength=255 cssClass='required' }
                    {mediarepositoryValidationError id='defaultTemplateCollection' class='required'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='allowTemplateOverrideCollection' __text='Allow template override collection'}
                    {formcheckbox group='repository' id='allowTemplateOverrideCollection' readOnly=false __title='allow template override collection ?' cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {formlabel for='defaultTemplateDetail' __text='Default template detail' mandatorysym='1'}
                    {formtextinput group='repository' id='defaultTemplateDetail' mandatory=true readOnly=false __title='Enter the default template detail of the repository' textMode='singleline' maxLength=255 cssClass='required' }
                    {mediarepositoryValidationError id='defaultTemplateDetail' class='required'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='allowTemplateOverrideDetail' __text='Allow template override detail'}
                    {formcheckbox group='repository' id='allowTemplateOverrideDetail' readOnly=false __title='allow template override detail ?' cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {formlabel for='startPageViewMode' __text='Start page view mode'}
                    {formintinput group='repository' id='startPageViewMode' mandatory=false __title='Enter the start page view mode of the repository' maxLength=4 cssClass=' validate-digits' }
                    {mediarepositoryValidationError id='startPageViewMode' class='validate-digits'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='downloadMode' __text='Download mode' mandatorysym='1'}
                    {formintinput group='repository' id='downloadMode' mandatory=true __title='Enter the download mode of the repository' maxLength=2 cssClass='required validate-digits' }
                    {mediarepositoryValidationError id='downloadMode' class='required'}
                    {mediarepositoryValidationError id='downloadMode' class='validate-digits'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='sendMailAfterUpload' __text='Send mail after upload'}
                    {formcheckbox group='repository' id='sendMailAfterUpload' readOnly=false __title='send mail after upload ?' cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {formlabel for='mailRecipient' __text='Mail recipient'}
                    {formtextinput group='repository' id='mailRecipient' mandatory=false readOnly=false __title='Enter the mail recipient of the repository' textMode='singleline' maxLength=255 cssClass='' }
                </div>
                        
            </fieldset>
        </div>
        
        {include file='admin/include_categories_edit.tpl' obj=$repository groupName='repositoryObj' panel=true}
        {if $mode ne 'create'}
            {include file='admin/include_standardfields_edit.tpl' obj=$repository panel=true}
        {/if}
        {include file='admin/thumbSize/include_selectEditMany.tpl' relItem=$repository aliasName='thumbSizes' idPrefix='medrepRepository_ThumbSizes' panel=true}
        
        {* include display hooks *}
        {if $mode eq 'create'}
            {notifydisplayhooks eventname='mediarepository.ui_hooks.repositories.form_edit' id=null assign='hooks'}
        {else}
            {notifydisplayhooks eventname='mediarepository.ui_hooks.repositories.form_edit' id=$repository.id assign='hooks'}
        {/if}
        {if is_array($hooks) && count($hooks)}
            {foreach key='providerArea' item='hook' from=$hooks}
                <h3 class="hook z-panel-header z-panel-indicator z-pointer">{$providerArea}</h3>
                <fieldset class="hook z-panel-content" style="display: none">{$hook}</div>
                    {$hook}
                </fieldset>
            {/foreach}
        {/if}
        
        {* include return control *}
        {if $mode eq 'create'}
            <fieldset>
                <legend>{gt text='Return control'}</legend>
                <div class="z-formrow">
                    {formlabel for='repeatcreation' __text='Create another item after save'}
                    {formcheckbox group='repository' id='repeatcreation' readOnly=false}
                </div>
            </fieldset>
        {/if}
        
        {* include possible submit actions *}
        <div class="z-buttons z-formbuttons">
            {if $mode eq 'edit'}
                {formbutton id='btnUpdate' commandName='update' __text='Update repository' class='z-bt-save'}
              {if !$inlineUsage}
                {gt text='Really delete this repository?' assign='deleteConfirmMsg'}
                {formbutton id='btnDelete' commandName='delete' __text='Delete repository' class='z-bt-delete z-btred' confirmMessage=$deleteConfirmMsg}
              {/if}
            {elseif $mode eq 'create'}
                {formbutton id='btnCreate' commandName='create' __text='Create repository' class='z-bt-ok'}
            {else}
                {formbutton id='btnUpdate' commandName='update' __text='OK' class='z-bt-ok'}
            {/if}
            {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
        </div>
        
    </div>
    {/mediarepositoryFormFrame}
{/form}

</div>
{include file='admin/footer.tpl'}

{icon type='edit' size='extrasmall' assign='editImageArray'}
{icon type='delete' size='extrasmall' assign='deleteImageArray'}


<script type="text/javascript">
/* <![CDATA[ */
    var editImage = '<img src="{{$editImageArray.src}}" width="16" height="16" alt="" />';
    var removeImage = '<img src="{{$deleteImageArray.src}}" width="16" height="16" alt="" />';
    var relationHandler = new Array();
    var newItem = new Object();
    newItem.ot = 'thumbSize';
    newItem.alias = 'ThumbSizes';
    newItem.prefix = 'medrepRepository_ThumbSizesSelectorDoNew';
    newItem.acInstance = null;
    newItem.windowInstance = null;
    relationHandler.push(newItem);

    document.observe('dom:loaded', function() {
        medrepInitRelationItemsForm('thumbSize', 'medrepRepository_ThumbSizes', true);

        medrepAddCommonValidationRules('repository', '{{if $mode eq 'create'}}{{else}}{{$repository.id}}{{/if}}');

        // observe button events instead of form submit
        var valid = new Validation('{{$__formid}}', {onSubmit: false, immediate: true, focusOnError: false});
        {{if $mode ne 'create'}}
            var result = valid.validate();
        {{/if}}

        {{if $mode eq 'create'}}$('btnCreate'){{else}}$('btnUpdate'){{/if}}.observe('click', function (event) {
            var result = valid.validate();
            if (!result) {
                // validation error, abort form submit
                Event.stop(event);
            } else {
                // hide form buttons to prevent double submits by accident
                $$('div.z-formbuttons input').each(function (btn) {
                    btn.hide();
                });
            }
            return result;
        });

        var panel = new Zikula.UI.Panels('MediaRepository_panel', {
            headerSelector: 'h3',
            headerClassName: 'z-panel-header z-panel-indicator',
            contentClassName: 'z-panel-content',
            active: 'z-panel-header-fields'
        });

        Zikula.UI.Tooltips($$('.mediarepositoryFormTooltips'));
    });

/* ]]> */
</script>
