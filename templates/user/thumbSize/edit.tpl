{* purpose of this template: build the Form to edit an instance of thumb size *}
{include file='user/header.tpl'}
{pageaddvar name='javascript' value='modules/MediaRepository/javascript/MediaRepository_editFunctions.js'}
{pageaddvar name='javascript' value='modules/MediaRepository/javascript/MediaRepository_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit thumb size' assign='templateTitle'}
{elseif $mode eq 'create'}
    {gt text='Create thumb size' assign='templateTitle'}
{else}
    {gt text='Edit thumb size' assign='templateTitle'}
{/if}
<div class="mediarepository-thumbsize mediarepository-edit">
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-frontendcontainer">
        <h2>{$templateTitle}</h2>
{form cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {mediarepositoryFormFrame}

    {formsetinitialfocus inputId='name'}


    <fieldset>
        <legend>{gt text='Content'}</legend>
        
        <div class="z-formrow">
            {formlabel for='name' __text='Name' mandatorysym='1'}
            {formtextinput group='thumbsize' id='name' mandatory=true readOnly=false __title='Enter the name of the thumb size' textMode='singleline' maxLength=100 cssClass='required' }
            {mediarepositoryValidationError id='name' class='required'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='width' __text='Width' mandatorysym='1'}
            {formintinput group='thumbsize' id='width' mandatory=true __title='Enter the width of the thumb size' maxLength=5 cssClass='required validate-digits' }
            {mediarepositoryValidationError id='width' class='required'}
            {mediarepositoryValidationError id='width' class='validate-digits'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='height' __text='Height' mandatorysym='1'}
            {formintinput group='thumbsize' id='height' mandatory=true __title='Enter the height of the thumb size' maxLength=5 cssClass='required validate-digits' }
            {mediarepositoryValidationError id='height' class='required'}
            {mediarepositoryValidationError id='height' class='validate-digits'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='keepAspectRatio' __text='Keep aspect ratio' mandatorysym='1'}
            {formcheckbox group='thumbsize' id='keepAspectRatio' readOnly=false __title='keep aspect ratio ?' cssClass='required' }
            {mediarepositoryValidationError id='keepAspectRatio' class='required'}
        </div>
                
    </fieldset>
    
    {if $mode ne 'create'}
        {include file='user/include_standardfields_edit.tpl' obj=$thumbsize}
    {/if}
    
    {* include display hooks *}
    {if $mode eq 'create'}
        {notifydisplayhooks eventname='mediarepository.ui_hooks.thumbsizes.form_edit' id=null assign='hooks'}
    {else}
        {notifydisplayhooks eventname='mediarepository.ui_hooks.thumbsizes.form_edit' id=$thumbsize.id assign='hooks'}
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
                {formcheckbox group='thumbsize' id='repeatcreation' readOnly=false}
            </div>
        </fieldset>
    {/if}
    
    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
        {if $mode eq 'edit'}
            {formbutton id='btnUpdate' commandName='update' __text='Update thumb size' class='z-bt-save'}
          {if !$inlineUsage}
            {gt text='Really delete this thumb size?' assign='deleteConfirmMsg'}
            {formbutton id='btnDelete' commandName='delete' __text='Delete thumb size' class='z-bt-delete z-btred' confirmMessage=$deleteConfirmMsg}
          {/if}
        {elseif $mode eq 'create'}
            {formbutton id='btnCreate' commandName='create' __text='Create thumb size' class='z-bt-ok'}
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

        medrepAddCommonValidationRules('thumbSize', '{{if $mode eq 'create'}}{{else}}{{$thumbsize.id}}{{/if}}');

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
