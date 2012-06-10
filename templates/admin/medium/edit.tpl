{* purpose of this template: build the Form to edit an instance of medium *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/MediaRepository/javascript/MediaRepository_editFunctions.js'}
{pageaddvar name='javascript' value='modules/MediaRepository/javascript/MediaRepository_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit medium' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create medium' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit medium' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="mediarepository-medium mediarepository-edit">
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type=$adminPageIcon size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>
{form enctype='multipart/form-data' cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {mediarepositoryFormFrame}

    {formsetinitialfocus inputId='owner'}


    <div class="z-panels" id="MediaRepository_panel">
        <h3 id="z-panel-header-fields" class="z-panel-header z-panel-indicator z-pointer">{gt text='Fields'}</h3>
        <div class="z-panel-content z-panel-active" style="overflow: visible">
            <fieldset>
                <legend>{gt text='Content'}</legend>
                
                <div class="z-formrow">
                    {formlabel for='owner' __text='Owner' mandatorysym='1'}
                    {* to be replaced by a plugin (see https://github.com/Guite/MostGenerator/issues/86 for more information) *} 
                    <div id="ownerLiveSearch" class="medrepLiveSearchUser z-hide">
                        {icon type='search' size='extrasmall' __alt='Search user'}
                        {formtextinput group='medium' id='ownerSelector' mandatory=true readOnly=false __title='Enter a part of the user name to search' maxLength=11 cssClass='required validate-alphanum'}
                        {img src='indicator_circle.gif' modname='core' set='ajax' alt='' id='ownerIndicator' style='display: none'}
                        <div id="ownerSelectorChoices" class="medrepAutoCompleteUser"></div>
                    </div>
                    <noscript><p>{gt text='This function requires JavaScript activated!'}</p></noscript>
                    <input type="hidden" id="owner" name="owner" value="{$medium.owner}" />
                    {if $mode ne 'create' && $owner && !$inlineUsage}<div class="z-formnote"><a href="{modurl modname='Users' type='admin' func='modify' userid=$owner}" title="{gt text='Switch to the user administration'}">{gt text='Manage user'}</a></div>{/if}
                    {mediarepositoryValidationError id='owner' class='required'}
                    {mediarepositoryValidationError id='owner' class='validate-alphanum'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='title' __text='Title' mandatorysym='1'}
                    {formtextinput group='medium' id='title' mandatory=true readOnly=false __title='Enter the title of the medium' textMode='singleline' maxLength=255 cssClass='required' }
                    {mediarepositoryValidationError id='title' class='required'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='keywords' __text='Keywords'}
                    {formtextinput group='medium' id='keywords' mandatory=false readOnly=false __title='Enter the keywords of the medium' textMode='singleline' maxLength=255 cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {formlabel for='description' __text='Description'}
                    {formtextinput group='medium' id='description' mandatory=false __title='Enter the description of the medium' textMode='multiline' rows='6' cols='50' cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {formlabel for='description2' __text='Description2'}
                    {formtextinput group='medium' id='description2' mandatory=false __title='Enter the description2 of the medium' textMode='multiline' rows='6' cols='50' cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {formlabel for='dateTaken' __text='Date taken'}
                    {formdateinput group='medium' id='dateTaken' mandatory=false readOnly=false __title='Enter the date taken of the medium' textMode='singleline' cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {formlabel for='placeTaken' __text='Place taken'}
                    {formtextinput group='medium' id='placeTaken' mandatory=false __title='Enter the place taken of the medium' textMode='multiline' rows='6' cols='50' cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {gt text='Any additional notes about this medium.' assign='toolTip'}
                    {formlabel for='notes' __text='Notes' class='mediarepositoryFormTooltips' title=$toolTip}
                    {formtextinput group='medium' id='notes' mandatory=false __title='Enter the notes of the medium' textMode='multiline' rows='6' cols='50' cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {gt text='Copyright and licensing.' assign='toolTip'}
                    {formlabel for='license' __text='License' class='mediarepositoryFormTooltips' title=$toolTip}
                    {formtextinput group='medium' id='license' mandatory=false __title='Enter the license of the medium' textMode='multiline' rows='6' cols='50' cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {gt text='This field is reserved for storing area maps for defining links on picture parts.' assign='toolTip'}
                    {formlabel for='areamap' __text='Areamap' class='mediarepositoryFormTooltips' title=$toolTip}
                    {formtextinput group='medium' id='areamap' mandatory=false __title='Enter the areamap of the medium' textMode='multiline' rows='6' cols='50' cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {formlabel for='showLocation' __text='Show location'}
                    {formcheckbox group='medium' id='showLocation' readOnly=false __title='show location ?' cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {formlabel for='latitude' __text='Latitude'}
                    {formfloatinput group='medium' id='latitude' mandatory=false __title='Enter the latitude of the medium' minValue=0.0 maxValue=0.0 maxLength=20 precision=7 cssClass=' validate-number' }
                    {mediarepositoryValidationError id='latitude' class='validate-number'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='longitude' __text='Longitude'}
                    {formfloatinput group='medium' id='longitude' mandatory=false __title='Enter the longitude of the medium' minValue=0.0 maxValue=0.0 maxLength=20 precision=7 cssClass=' validate-number' }
                    {mediarepositoryValidationError id='longitude' class='validate-number'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='zoomFactor' __text='Zoom factor'}
                    {formintinput group='medium' id='zoomFactor' mandatory=false __title='Enter the zoom factor of the medium' maxLength=4 cssClass=' validate-digits' }
                    {mediarepositoryValidationError id='zoomFactor' class='validate-digits'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='dlcount' __text='Dlcount'}
                    {formintinput group='medium' id='dlcount' mandatory=false __title='Enter the dlcount of the medium' maxLength=11 cssClass=' validate-digits' }
                    {mediarepositoryValidationError id='dlcount' class='validate-digits'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='url' __text='Url'}
                    {formurlinput group='medium' id='url' mandatory=false readOnly=false __title='Enter the url of the medium' textMode='singleline' maxLength=255 cssClass=' validate-url' }
                    {mediarepositoryValidationError id='url' class='validate-url'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='mediaHandler' __text='Media handler'}
                    {formtextinput group='medium' id='mediaHandler' mandatory=false readOnly=false __title='Enter the media handler of the medium' textMode='singleline' maxLength=50 cssClass='' }
                </div>
                
                <div class="z-formrow">
                    {formlabel for='freeType' __text='Free type'}
                    {formintinput group='medium' id='freeType' mandatory=false __title='Enter the free type of the medium' maxLength=4 cssClass=' validate-digits' }
                    {mediarepositoryValidationError id='freeType' class='validate-digits'}
                </div>
                <div class="z-formrow">
                    {formlabel for='repository' __text='Repository'}
                    {formdropdownlist id='repository' group='medium' mandatory=true __title='Please choose a repository'}
                    
                </div>
                
                <div class="z-formrow">
                    {assign var='mandatorySym' value='1'}
                    {if $mode ne 'create'}
                        {assign var='mandatorySym' value='0'}
                    {/if}
                    {formlabel for='fileUpload' __text='File upload' mandatorysym=$mandatorySym}<br />{* break required for Google Chrome *}
                    {if $mode eq 'create'}
                        {formuploadinput group='medium' id='fileUpload' mandatory=true readOnly=false cssClass='required validate-upload' }
                    {else}
                        {formuploadinput group='medium' id='fileUpload' mandatory=false readOnly=false cssClass=' validate-upload' }
                    {/if}
                    
                        <div class="z-formnote">{gt text='Allowed file extensions:'} <span id="fileextensionsfileUpload">gif, jpeg, jpg, png</span></div>
                        {if $mode ne 'create'}
                              <div class="z-formnote">
                                  {gt text='Current file'}:
                                  <a href="{$medium.fileUploadFullPathUrl}" title="{$medium.title|replace:"\"":""}"{if $medium.fileUploadMeta.isImage} rel="imageviewer[medium]"{/if}>
                                  {if $medium.fileUploadMeta.isImage}
                                      <img src="{$medium.fileUploadFullPath|mediarepositoryImageThumb:80:50}" width="80" height="50" alt="{$medium.title|replace:"\"":""}" />
                                  {else}
                                      {gt text='Download'} ({$medium.fileUploadMeta.size|mediarepositoryGetFileSize:$medium.fileUploadFullPath:false:false})
                                  {/if}
                                  </a>
                              </div>
                        {/if}
                    {mediarepositoryValidationError id='fileUpload' class='required'}
                    {mediarepositoryValidationError id='fileUpload' class='validate-upload'}
                </div>
                        
            </fieldset>
        </div>
        
        {include file='admin/include_attributes_edit.tpl' obj=$medium panel=true}
        {include file='admin/include_categories_edit.tpl' obj=$medium groupName='mediumObj' panel=true}
        {if $mode ne 'create'}
            {include file='admin/include_standardfields_edit.tpl' obj=$medium panel=true}
        {/if}
        {include file='admin/include_metadata_edit.tpl' obj=$medium panel=true}
        
        {* include display hooks *}
        {if $mode eq 'create'}
            {notifydisplayhooks eventname='mediarepository.ui_hooks.media.form_edit' id=null assign='hooks'}
        {else}
            {notifydisplayhooks eventname='mediarepository.ui_hooks.media.form_edit' id=$medium.id assign='hooks'}
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
                    {formcheckbox group='medium' id='repeatcreation' readOnly=false}
                </div>
            </fieldset>
        {/if}
        
        {* include possible submit actions *}
        <div class="z-buttons z-formbuttons">
            {if $mode eq 'edit'}
                {formbutton id='btnUpdate' commandName='update' __text='Update medium' class='z-bt-save'}
              {if !$inlineUsage}
                {gt text='Really delete this medium?' assign='deleteConfirmMsg'}
                {formbutton id='btnDelete' commandName='delete' __text='Delete medium' class='z-bt-delete z-btred' confirmMessage=$deleteConfirmMsg}
              {/if}
            {elseif $mode eq 'create'}
                {formbutton id='btnCreate' commandName='create' __text='Create medium' class='z-bt-ok'}
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

    document.observe('dom:loaded', function() {
        // initialise auto completion for user fields
        {{if isset($owner) && $owner gt 0}}
            $('ownerSelector').value = '{{usergetvar name='uname' uid=$owner}}';
        {{/if}}
        medrepInitUserField('owner', 'getMediumOwnerUsers');

        medrepAddCommonValidationRules('medium', '{{if $mode eq 'create'}}{{else}}{{$medium.id}}{{/if}}');

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