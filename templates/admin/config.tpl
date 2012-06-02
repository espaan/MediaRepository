{* purpose of this template: module configuration *}
{include file='admin/header.tpl'}
<div class="mediarepository-config">
    {gt text='Settings' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='config' size='small' __alt='Settings'}
        <h3>{$templateTitle}</h3>
    </div>

    {form cssClass='z-form'}


        {* add validation summary and a <div> element for styling the form *}
        {mediarepositoryFormFrame}
            {formsetinitialfocus inputId='pageSize'}
            <fieldset>
                <legend>{gt text='Here you can manage all basic settings for this application.'}</legend>
            
                <div class="z-formrow">
                    {formlabel for='pageSize' __text='Page size'}
                    {formintinput id='pageSize' group='config' maxLength=255 __title='Enter this setting. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {formlabel for='uiMode' __text='Ui mode'}
                    {formintinput id='uiMode' group='config' maxLength=255 __title='Enter this setting. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {formlabel for='useAccountArea' __text='Use account area'}
                    {formcheckbox id='useAccountArea' group='config'}
                </div>
                <div class="z-formrow">
                    {formlabel for='apiKeyFlickr' __text='Api key flickr'}
                    {formtextinput id='apiKeyFlickr' group='config' maxLength=255 __title='Enter this setting.'}
                </div>
                <div class="z-formrow">
                    {formlabel for='apiKeyPicasa' __text='Api key picasa'}
                    {formtextinput id='apiKeyPicasa' group='config' maxLength=255 __title='Enter this setting.'}
                </div>
                <div class="z-formrow">
                    {formlabel for='apiKeySmugMug' __text='Api key smug mug'}
                    {formtextinput id='apiKeySmugMug' group='config' maxLength=255 __title='Enter this setting.'}
                </div>
            </fieldset>

            <div class="z-buttons z-formbuttons">
                {formbutton commandName='save' __text='Update configuration' class='z-bt-save'}
                {formbutton commandName='cancel' __text='Cancel' class='z-bt-cancel'}
            </div>
        {/mediarepositoryFormFrame}
    {/form}
</div>
{include file='admin/footer.tpl'}
