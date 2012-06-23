{* purpose of this template: repositories display view in admin area *}
{include file='admin/header.tpl'}
<div class="mediarepository-repository mediarepository-display">
{gt text='Repository' assign='templateTitle'}
{assign var='templateTitle' value=$repository.name|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-admin-content-pagetitle">
    {icon type='display' size='small' __alt='Details'}
    <h3>{$templateTitle|notifyfilters:'mediarepository.filter_hooks.repositories.filter'}{icon id='itemactionstrigger' type='options' size='extrasmall' __alt='Actions' style='display: none' class='z-pointer'}</h3>
</div>

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    <div class="mediarepositoryRightBox">
        <h3>{gt text='Media'}</h3>
        
        {if isset($repository.files) && $repository.files ne null}
            {include file='admin/medium/include_displayItemListMany.tpl' items=$repository.files}
        {/if}
        
        {checkpermission component='MediaRepository:Repository:' instance="`$repository.id`::" level='ACCESS_ADMIN' assign='authAdmin'}
        {if $authAdmin || (isset($uid) && isset($repository.createdUserId) && $repository.createdUserId eq $uid)}
        <p class="manageLink">
            {gt text='Create medium' assign='createTitle'}
            <a href="{modurl modname='MediaRepository' type='admin' func='edit' ot='medium' repository="`$repository.id`" returnTo='adminDisplayRepository'}" title="{$createTitle}" class="z-icon-es-add">
                {$createTitle}
            </a>
        </p>
        {/if}
        <h3>{gt text='Thumb sizes'}</h3>
        
        {if isset($repository.thumbSizes) && $repository.thumbSizes ne null}
            {include file='admin/thumbSize/include_displayItemListMany.tpl' items=$repository.thumbSizes}
        {/if}
        
        {checkpermission component='MediaRepository:Repository:' instance="`$repository.id`::" level='ACCESS_ADMIN' assign='authAdmin'}
        {if $authAdmin || (isset($uid) && isset($repository.createdUserId) && $repository.createdUserId eq $uid)}
        <p class="manageLink">
            {gt text='Create thumb size' assign='createTitle'}
            <a href="{modurl modname='MediaRepository' type='admin' func='edit' ot='thumbSize' repositories="`$repository.id`" returnTo='adminDisplayRepository'}" title="{$createTitle}" class="z-icon-es-add">
                {$createTitle}
            </a>
        </p>
        {/if}
    </div>
{/if}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
<div class="z-panels" id="MediaRepository_panel">
    <h3 id="z-panel-header-fields" class="z-panel-header z-panel-indicator z-pointer z-panel-active">{gt text='Fields'}</h3>
    <div class="z-panel-content z-panel-active" style="overflow: visible">
{/if}
<dl id="MediaRepository_body">
    <dt>{gt text='Work directory'}</dt>
    <dd>{$repository.workDirectory}</dd>
    <dt>{gt text='Storage directory'}</dt>
    <dd>{$repository.storageDirectory}</dd>
    <dt>{gt text='Cache directory'}</dt>
    <dd>{$repository.cacheDirectory}</dd>
    <dt>{gt text='Storage mode'}</dt>
    <dd>{$repository.storageMode}</dd>
    <dt>{gt text='Permission scope'}</dt>
    <dd>{$repository.permissionScope}</dd>
    <dt>{gt text='Use quota'}</dt>
    <dd>{$repository.useQuota|yesno:true}</dd>
    <dt>{gt text='Allow management of own files'}</dt>
    <dd>{$repository.allowManagementOfOwnFiles|yesno:true}</dd>
    <dt>{gt text='Allow file mailing'}</dt>
    <dd>{$repository.allowFileMailing|yesno:true}</dd>
    <dt>{gt text='Max size for mail'}</dt>
    <dd>{$repository.maxSizeForMail}</dd>
    <dt>{gt text='Max files per upload'}</dt>
    <dd>{$repository.maxFilesPerUpload}</dd>
    <dt>{gt text='Max upload file size'}</dt>
    <dd>{$repository.maxUploadFileSize}</dd>
    <dt>{gt text='Upload naming convention'}</dt>
    <dd>{$repository.uploadNamingConvention}</dd>
    <dt>{gt text='Upload naming prefix'}</dt>
    <dd>{$repository.uploadNamingPrefix}</dd>
    <dt>{gt text='Enable sharpen'}</dt>
    <dd>{$repository.enableSharpen|yesno:true}</dd>
    <dt>{gt text='Enable shrinking'}</dt>
    <dd>{$repository.enableShrinking|yesno:true}</dd>
    <dt>{gt text='Shrink dimensions'}</dt>
    <dd>{$repository.shrinkDimensions}</dd>
    <dt>{gt text='Use thumb cropper'}</dt>
    <dd>{$repository.useThumbCropper|yesno:true}</dd>
    <dt>{gt text='Crop size mode'}</dt>
    <dd>{$repository.cropSizeMode}</dd>
    <dt>{gt text='Download mode'}</dt>
    <dd>{$repository.downloadMode}</dd>
    <dt>{gt text='Send mail after upload'}</dt>
    <dd>{$repository.sendMailAfterUpload|yesno:true}</dd>
    <dt>{gt text='Mail recipient'}</dt>
    <dd>{$repository.mailRecipient}</dd>
    
</dl>
{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    </div>
{/if}
{include file='admin/include_categories_display.tpl' obj=$repository panel=true}
{include file='admin/include_standardfields_display.tpl' obj=$repository panel=true}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    {* include display hooks *}
    {notifydisplayhooks eventname='mediarepository.ui_hooks.repositories.display_view' id=$repository.id urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        <h3 class="z-panel-header z-panel-indicator z-pointer">{$providerArea}</h3>
        <div class="z-panel-content" style="display: none">{$hook}</div>
    {/foreach}
    {if count($repository._actions) gt 0}
        <p id="itemactions">
        {foreach item='option' from=$repository._actions}
            <a href="{$option.url.type|mediarepositoryActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
        {/foreach}
        </p>
        <script type="text/javascript">
        /* <![CDATA[ */
            document.observe('dom:loaded', function() {
                medrepInitItemActions('repository', 'display', 'itemactions');
            });
        /* ]]> */
        </script>
    {/if}
    <br style="clear: right" />
{/if}

</div>
{include file='admin/footer.tpl'}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    <script type="text/javascript">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            var panel = new Zikula.UI.Panels('MediaRepository_panel', {
                headerSelector: 'h3',
                headerClassName: 'z-panel-header z-panel-indicator',
                contentClassName: 'z-panel-content',
                active: 'z-panel-header-fields'
            });
        });
    /* ]]> */
    </script>
{/if}
