{* purpose of this template: media handlers display view in user area *}
{include file='user/header.tpl'}
<div class="mediarepository-mediahandler mediarepository-display">
{gt text='Media handler' assign='templateTitle'}
{assign var='templateTitle' value=$mediaHandler.title|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-frontendcontainer">
    <h2>{$templateTitle|notifyfilters:'mediarepository.filter_hooks.mediahandlers.filter'}{icon id='itemactionstrigger' type='options' size='extrasmall' __alt='Actions' style='display: none' class='z-pointer'}</h2>


<dl id="MediaRepository_body">
    <dt>{gt text='Mime type'}</dt>
    <dd>{$mediaHandler.mimeType}</dd>
    <dt>{gt text='File type'}</dt>
    <dd>{$mediaHandler.fileType}</dd>
    <dt>{gt text='Found mime type'}</dt>
    <dd>{$mediaHandler.foundMimeType}</dd>
    <dt>{gt text='Found file type'}</dt>
    <dd>{$mediaHandler.foundFileType}</dd>
    <dt>{gt text='Handler name'}</dt>
    <dd>{$mediaHandler.handlerName}</dd>
    <dt>{gt text='Active'}</dt>
    <dd>{assign var='itemid' value=$mediaHandler.id}
    <a id="toggleactive{$itemid}" href="javascript:void(0);" style="display: none">
    {if $mediaHandler.active}
        {icon type='ok' size='extrasmall' __alt='Yes' id="yesactive_`$itemid`" __title="This setting is enabled. Click here to disable it."}
        {icon type='cancel' size='extrasmall' __alt='No' id="noactive_`$itemid`" __title="This setting is disabled. Click here to enable it." style="display: none;"}
    {else}
        {icon type='ok' size='extrasmall' __alt='Yes' id="yesactive_`$itemid`" __title="This setting is enabled. Click here to disable it." style="display: none;"}
        {icon type='cancel' size='extrasmall' __alt='No' id="noactive_`$itemid`" __title="This setting is disabled. Click here to enable it."}
    {/if}
    </a>
    <noscript><div id="noscriptactive{$itemid}">
        {$mediaHandler.active|yesno:true}
    </div></noscript>
    </dd>
    <dt>{gt text='Image'}</dt>
    <dd>{if $mediaHandler.image ne ''}
      <a href="{$mediaHandler.imageFullPathURL}" title="{$mediaHandler.title|replace:"\"":""}"{if $mediaHandler.imageMeta.isImage} rel="imageviewer[mediahandler]"{/if}>
      {if $mediaHandler.imageMeta.isImage}
          <img src="{$mediaHandler.imageFullPath|mediarepositoryImageThumb:250:150}" width="250" height="150" alt="{$mediaHandler.title|replace:"\"":""}" />
      {else}
          {gt text='Download'} ({$mediaHandler.imageMeta.size|mediarepositoryGetFileSize:$mediaHandler.imageFullPath:false:false})
      {/if}
      </a>
    {else}&nbsp;{/if}
    </dd>
    
</dl>
{include file='user/include_standardfields_display.tpl' obj=$mediaHandler}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    {* include display hooks *}
    {notifydisplayhooks eventname='mediarepository.ui_hooks.mediahandlers.display_view' id=$mediaHandler.id urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        {$hook}
    {/foreach}
    {if count($mediaHandler._actions) gt 0}
        <p id="itemactions">
        {foreach item='option' from=$mediaHandler._actions}
            <a href="{$option.url.type|mediarepositoryActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
        {/foreach}
        </p>
        <script type="text/javascript">
        /* <![CDATA[ */
            document.observe('dom:loaded', function() {
                medrepInitItemActions('mediaHandler', 'display', 'itemactions');
            });
        /* ]]> */
        </script>
    {/if}
{/if}

</div>
</div>
{include file='user/footer.tpl'}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    <script type="text/javascript">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            {{assign var='itemid' value=$mediaHandler.id}}
                medrepInitToggle('mediaHandler', 'active', '{{$itemid}}');
        });
    /* ]]> */
    </script>
{/if}
