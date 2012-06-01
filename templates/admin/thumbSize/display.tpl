{* purpose of this template: thumb sizes display view in admin area *}
{include file='admin/header.tpl'}
<div class="mediarepository-thumbsize mediarepository-display">
{gt text='Thumb size' assign='templateTitle'}
{assign var='templateTitle' value=$thumbSize.name|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-admin-content-pagetitle">
    {icon type='display' size='small' __alt='Details'}
    <h3>{$templateTitle|notifyfilters:'mediarepository.filter_hooks.thumbsizes.filter'}{icon id='itemactionstrigger' type='options' size='extrasmall' __alt='Actions' style='display: none' class='z-pointer'}</h3>
</div>

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    <div class="mediarepositoryRightBox">
        <h3>{gt text='Repositories'}</h3>
        
        {if isset($thumbSize.repositories) && $thumbSize.repositories ne null}
            {include file='admin/repository/include_displayItemListMany.tpl' items=$thumbSize.repositories}
        {/if}
        
        {checkpermission component='MediaRepository:ThumbSize:' instance="`$thumbSize.id`::" level='ACCESS_ADMIN' assign='authAdmin'}
        {if $authAdmin || (isset($uid) && isset($thumbSize.createdUserId) && $thumbSize.createdUserId eq $uid)}
        <p class="manageLink">
            {gt text='Create repository' assign='createTitle'}
            <a href="{modurl modname='MediaRepository' type='admin' func='edit' ot='repository' thumbsizes="`$thumbSize.id`" returnTo='adminDisplayThumbSize'}" title="{$createTitle}" class="z-icon-es-add">
                {$createTitle}
            </a>
        </p>
        {/if}
    </div>
{/if}

<dl id="MediaRepository_body">
    <dt>{gt text='Width'}</dt>
    <dd>{$thumbSize.width}</dd>
    <dt>{gt text='Height'}</dt>
    <dd>{$thumbSize.height}</dd>
    <dt>{gt text='Keep aspect ratio'}</dt>
    <dd>{$thumbSize.keepAspectRatio|yesno:true}</dd>
    
</dl>
{include file='admin/include_standardfields_display.tpl' obj=$thumbSize}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    {* include display hooks *}
    {notifydisplayhooks eventname='mediarepository.ui_hooks.thumbsizes.display_view' id=$thumbSize.id urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        {$hook}
    {/foreach}
    {if count($thumbSize._actions) gt 0}
        <p id="itemactions">
        {foreach item='option' from=$thumbSize._actions}
            <a href="{$option.url.type|mediarepositoryActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
        {/foreach}
        </p>
        <script type="text/javascript">
        /* <![CDATA[ */
            document.observe('dom:loaded', function() {
                medrepInitItemActions('thumbSize', 'display', 'itemactions');
            });
        /* ]]> */
        </script>
    {/if}
    <br style="clear: right" />
{/if}

</div>
{include file='admin/footer.tpl'}

