{* purpose of this template: build the Form to edit an instance of media handler *}
{include file='user/header.tpl'}
{pageaddvar name='javascript' value='modules/MediaRepository/javascript/MediaRepository_editFunctions.js'}
{pageaddvar name='javascript' value='modules/MediaRepository/javascript/MediaRepository_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit media handler' assign='templateTitle'}
{elseif $mode eq 'create'}
    {gt text='Create media handler' assign='templateTitle'}
{else}
    {gt text='Edit media handler' assign='templateTitle'}
{/if}
<div class="mediarepository-mediahandler mediarepository-edit">
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-frontendcontainer">
        <h2>{$templateTitle}</h2>
{form enctype='multipart/form-data' cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {mediarepositoryFormFrame}

    {formsetinitialfocus inputId='mimeType'}


    <fieldset>
        <legend>{gt text='Content'}</legend>
        
        <div class="z-formrow">
            {formlabel for='mimeType' __text='Mime type' mandatorysym='1'}
            {formtextinput group='mediahandler' id='mimeType' mandatory=true readOnly=false __title='Enter the mime type of the media handler' textMode='singleline' maxLength=50 cssClass='required' }
            {mediarepositoryValidationError id='mimeType' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='fileType' __text='File type' mandatorysym='1'}
            {formtextinput group='mediahandler' id='fileType' mandatory=true readOnly=false __title='Enter the file type of the media handler' textMode='singleline' maxLength=20 cssClass='required' }
            {mediarepositoryValidationError id='fileType' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='foundMimeType' __text='Found mime type' mandatorysym='1'}
            {formtextinput group='mediahandler' id='foundMimeType' mandatory=true readOnly=false __title='Enter the found mime type of the media handler' textMode='singleline' maxLength=50 cssClass='required' }
            {mediarepositoryValidationError id='foundMimeType' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='foundFileType' __text='Found file type' mandatorysym='1'}
            {formtextinput group='mediahandler' id='foundFileType' mandatory=true readOnly=false __title='Enter the found file type of the media handler' textMode='singleline' maxLength=50 cssClass='required' }
            {mediarepositoryValidationError id='foundFileType' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='handlerName' __text='Handler name' mandatorysym='1'}
            {formtextinput group='mediahandler' id='handlerName' mandatory=true readOnly=false __title='Enter the handler name of the media handler' textMode='singleline' maxLength=50 cssClass='required' }
            {mediarepositoryValidationError id='handlerName' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='title' __text='Title' mandatorysym='1'}
            {formtextinput group='mediahandler' id='title' mandatory=true readOnly=false __title='Enter the title of the media handler' textMode='singleline' maxLength=50 cssClass='required' }
            {mediarepositoryValidationError id='title' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='active' __text='Active'}
            {formcheckbox group='mediahandler' id='active' readOnly=false __title='active ?' cssClass='' }
        </div>
        
        <div class="z-formrow">
            {formlabel for='image' __text='Image'}<br />{* break required for Google Chrome *}
            {formuploadinput group='mediahandler' id='image' mandatory=false readOnly=false cssClass=' validate-upload' }
            
                <div class="z-formnote">{gt text='Allowed file extensions:'} <span id="fileextensionsimage">gif, jpeg, jpg, png</span></div>
                {if $mode ne 'create'}
                {if $mediaHandler.image ne ''}
                      <div class="z-formnote">
                          {gt text='Current file'}:
                          <a href="{$mediaHandler.imageFullPathUrl}" title="{$mediaHandler.title|replace:"\"":""}"{if $mediaHandler.imageMeta.isImage} rel="imageviewer[mediahandler]"{/if}>
                          {if $mediaHandler.imageMeta.isImage}
                              <img src="{$mediaHandler.imageFullPath|mediarepositoryImageThumb:80:50}" width="80" height="50" alt="{$mediaHandler.title|replace:"\"":""}" />
                          {else}
                              {gt text='Download'} ({$mediaHandler.imageMeta.size|mediarepositoryGetFileSize:$mediaHandler.imageFullPath:false:false})
                          {/if}
                          </a>
                      </div>
                <div class="z-formnote">
                    {formcheckbox group='mediahandler' id='imageDeleteFile' readOnly=false __title='Delete image ?'}
                    {formlabel for='imageDeleteFile' __text='Delete existing file'}
                </div>
                {/if}
                {/if}
            {mediarepositoryValidationError id='image' class='validate-upload'}
        </div>
                
    </fieldset>
    
    {if $mode ne 'create'}
        {include file='user/include_standardfields_edit.tpl' obj=$mediahandler}
    {/if}
    
    {* include display hooks *}
    {if $mode eq 'create'}
        {notifydisplayhooks eventname='mediarepository.ui_hooks.mediahandlers.form_edit' id=null assign='hooks'}
    {else}
        {notifydisplayhooks eventname='mediarepository.ui_hooks.mediahandlers.form_edit' id=$mediahandler.id assign='hooks'}
    {/if}
    {if is_array($hooks) && count($hooks)}
        {foreach key='providerArea' item='hook' from=$hooks}
            <fieldset>
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
                {formcheckbox group='mediahandler' id='repeatcreation' readOnly=false}
            </div>
        </fieldset>
    {/if}
    
    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
        {if $mode eq 'edit'}
            {formbutton id='btnUpdate' commandName='update' __text='Update media handler' class='z-bt-save'}
          {if !$inlineUsage}
            {gt text='Really delete this media handler?' assign='deleteConfirmMsg'}
            {formbutton id='btnDelete' commandName='delete' __text='Delete media handler' class='z-bt-delete z-btred' confirmMessage=$deleteConfirmMsg}
          {/if}
        {elseif $mode eq 'create'}
            {formbutton id='btnCreate' commandName='create' __text='Create media handler' class='z-bt-ok'}
        {else}
            {formbutton id='btnUpdate' commandName='update' __text='OK' class='z-bt-ok'}
        {/if}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
    </div>
    
    {/mediarepositoryFormFrame}
{/form}

    </div>
</div>
{include file='user/footer.tpl'}

{icon type='edit' size='extrasmall' assign='editImageArray'}
{icon type='delete' size='extrasmall' assign='deleteImageArray'}


<script type="text/javascript">
/* <![CDATA[ */
    var editImage = '<img src="{{$editImageArray.src}}" width="16" height="16" alt="" />';
    var removeImage = '<img src="{{$deleteImageArray.src}}" width="16" height="16" alt="" />';

    document.observe('dom:loaded', function() {

        medrepAddCommonValidationRules('mediaHandler', '{{if $mode eq 'create'}}{{else}}{{$mediahandler.id}}{{/if}}');

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

        Zikula.UI.Tooltips($$('.mediarepositoryFormTooltips'));
    });

/* ]]> */
</script>
