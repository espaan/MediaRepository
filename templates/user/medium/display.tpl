{* purpose of this template: media display view in user area *}
{include file='user/header.tpl'}
<div class="mediarepository-medium mediarepository-display">
{gt text='Medium' assign='templateTitle'}
{assign var='templateTitle' value=$medium.title|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-frontendcontainer">
    <h2>{$templateTitle|notifyfilters:'mediarepository.filter_hooks.media.filter'}{icon id='itemactionstrigger' type='options' size='extrasmall' __alt='Actions' style='display: none' class='z-pointer'}</h2>

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    <div class="mediarepositoryRightBox">
        <h3>{gt text='Media handlers'}</h3>
        
        {if isset($medium.mediaHandlers) && $medium.mediaHandlers ne null}
            {include file='user/mediaHandler/include_displayItemListMany.tpl' items=$medium.mediaHandlers}
        {/if}
        
        {checkpermission component='MediaRepository:Medium:' instance="`$medium.id`::" level='ACCESS_ADMIN' assign='authAdmin'}
        {if $authAdmin || (isset($uid) && isset($medium.createdUserId) && $medium.createdUserId eq $uid)}
        <p class="manageLink">
            {gt text='Create media handler' assign='createTitle'}
            <a href="{modurl modname='MediaRepository' type='user' func='edit' ot='mediaHandler' medium="`$medium.id`" returnTo='userDisplayMedium'}" title="{$createTitle}" class="z-icon-es-add">
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
    <dt>{gt text='Owner'}</dt>
    <dd>{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {$medium.owner|profilelinkbyuid}
    {else}
      {usergetvar name='uname' uid=$medium.owner}
    {/if}
    </dd>
    <dt>{gt text='Keywords'}</dt>
    <dd>{$medium.keywords}</dd>
    <dt>{gt text='Description'}</dt>
    <dd>{$medium.description}</dd>
    <dt>{gt text='Description2'}</dt>
    <dd>{$medium.description2}</dd>
    <dt>{gt text='Date taken'}</dt>
    <dd>{$medium.dateTaken}</dd>
    <dt>{gt text='Place taken'}</dt>
    <dd>{$medium.placeTaken}</dd>
    <dt>{gt text='Notes'}</dt>
    <dd>{$medium.notes}</dd>
    <dt>{gt text='License'}</dt>
    <dd>{$medium.license}</dd>
    <dt>{gt text='Areamap'}</dt>
    <dd>{$medium.areamap}</dd>
    <dt>{gt text='Show location'}</dt>
    <dd>{$medium.showLocation|yesno:true}</dd>
    <dt>{gt text='Latitude'}</dt>
    <dd>{$medium.latitude|formatnumber}</dd>
    <dt>{gt text='Longitude'}</dt>
    <dd>{$medium.longitude|formatnumber}</dd>
    <dt>{gt text='Zoom factor'}</dt>
    <dd>{$medium.zoomFactor}</dd>
    <dt>{gt text='Settings'}</dt>
    <dd>{$medium.settings}</dd>
    <dt>{gt text='Dlcount'}</dt>
    <dd>{$medium.dlcount}</dd>
    <dt>{gt text='Url'}</dt>
    <dd>{if $medium.url ne ''}
    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <a href="{$medium.url}" title="{gt text='Visit this page'}">{icon type='url' size='extrasmall' __alt='Homepage'}</a>
    {else}
      {$medium.url}
    {/if}
    {else}&nbsp;{/if}
    </dd>
    <dt>{gt text='Media handler'}</dt>
    <dd>{$medium.mediaHandler}</dd>
    <dt>{gt text='Free type'}</dt>
    <dd>{$medium.freeType}</dd>
    <dt>{gt text='Additions'}</dt>
    <dd>{$medium.additions}</dd>
    <dt>{gt text='File upload'}</dt>
    <dd>  <a href="{$medium.fileUploadFullPathURL}" title="{$medium.title|replace:"\"":""}"{if $medium.fileUploadMeta.isImage} rel="imageviewer[medium]"{/if}>
      {if $medium.fileUploadMeta.isImage}
          <img src="{$medium.fileUploadFullPath|mediarepositoryImageThumb:250:150}" width="250" height="150" alt="{$medium.title|replace:"\"":""}" />
      {else}
          {gt text='Download'} ({$medium.fileUploadMeta.size|mediarepositoryGetFileSize:$medium.fileUploadFullPath:false:false})
      {/if}
      </a>
    </dd>
    
</dl>
{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    </div>
{/if}
{include file='user/include_attributes_display.tpl' obj=$medium panel=true}
{include file='user/include_categories_display.tpl' obj=$medium panel=true}
{include file='user/include_standardfields_display.tpl' obj=$medium panel=true}
{include file='user/include_metadata_display.tpl' obj=$medium panel=true}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    {* include display hooks *}
    {notifydisplayhooks eventname='mediarepository.ui_hooks.media.display_view' id=$medium.id urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        <h3 class="z-panel-header z-panel-indicator z-pointer">{$providerArea}</h3>
        <div class="z-panel-content" style="display: none">{$hook}</div>
    {/foreach}
    {if count($medium._actions) gt 0}
        <p id="itemactions">
        {foreach item='option' from=$medium._actions}
            <a href="{$option.url.type|mediarepositoryActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
        {/foreach}
        </p>
        <script type="text/javascript">
        /* <![CDATA[ */
            document.observe('dom:loaded', function() {
                medrepInitItemActions('medium', 'display', 'itemactions');
            });
        /* ]]> */
        </script>
    {/if}
    <br style="clear: right" />
{/if}

</div>
</div>
{include file='user/footer.tpl'}

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
