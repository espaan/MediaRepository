{* purpose of this template: media handlers view view in user area *}
{include file='user/header.tpl'}
<div class="mediarepository-mediahandler mediarepository-view">
{gt text='Media handler list' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>

{checkpermissionblock component='MediaRepository:MediaHandler:' instance='.*' level='ACCESS_ADD'}
    {gt text='Create media handler' assign='createTitle'}
    <a href="{modurl modname='MediaRepository' type='user' func='edit' ot='mediaHandler'}" title="{$createTitle}" class="z-icon-es-add">
        {$createTitle}
    </a>
{/checkpermissionblock}
{assign var='own' value=0}
{if isset($showOwnEntries) && $showOwnEntries eq 1}
    {assign var='own' value=1}
{/if}
{assign var='all' value=0}
{if isset($showAllEntries) && $showAllEntries eq 1}
    {gt text='Back to paginated view' assign='linkTitle'}
    <a href="{modurl modname='MediaRepository' type='user' func='view' ot='mediaHandler'}" title="{$linkTitle}" class="z-icon-es-view">
        {$linkTitle}
    </a>
    {assign var='all' value=1}
{else}
    {gt text='Show all entries' assign='linkTitle'}
    <a href="{modurl modname='MediaRepository' type='user' func='view' ot='mediaHandler' all=1}" title="{$linkTitle}" class="z-icon-es-view">
        {$linkTitle}
    </a>
{/if}

{include file='user/mediaHandler/view_quickNav.tpl'}{* see template file for available options *}

<table class="z-datatable">
    <colgroup>
        <col id="cmimetype" />
        <col id="cfiletype" />
        <col id="cfoundmimetype" />
        <col id="cfoundfiletype" />
        <col id="chandlername" />
        <col id="ctitle" />
        <col id="cactive" />
        <col id="cimage" />
        <col id="citemactions" />
    </colgroup>
    <thead>
    <tr>
        <th id="hmimetype" scope="col" class="z-left">
            {sortlink __linktext='Mime type' sort='mimeType' currentsort=$sort sortdir=$sdir all=$all own=$own Medium=$Medium searchterm=$searchterm pageSize=$pageSize active=$active modname='MediaRepository' type='user' func='view' ot='mediaHandler'}
        </th>
        <th id="hfiletype" scope="col" class="z-left">
            {sortlink __linktext='File type' sort='fileType' currentsort=$sort sortdir=$sdir all=$all own=$own Medium=$Medium searchterm=$searchterm pageSize=$pageSize active=$active modname='MediaRepository' type='user' func='view' ot='mediaHandler'}
        </th>
        <th id="hfoundmimetype" scope="col" class="z-left">
            {sortlink __linktext='Found mime type' sort='foundMimeType' currentsort=$sort sortdir=$sdir all=$all own=$own Medium=$Medium searchterm=$searchterm pageSize=$pageSize active=$active modname='MediaRepository' type='user' func='view' ot='mediaHandler'}
        </th>
        <th id="hfoundfiletype" scope="col" class="z-left">
            {sortlink __linktext='Found file type' sort='foundFileType' currentsort=$sort sortdir=$sdir all=$all own=$own Medium=$Medium searchterm=$searchterm pageSize=$pageSize active=$active modname='MediaRepository' type='user' func='view' ot='mediaHandler'}
        </th>
        <th id="hhandlername" scope="col" class="z-left">
            {sortlink __linktext='Handler name' sort='handlerName' currentsort=$sort sortdir=$sdir all=$all own=$own Medium=$Medium searchterm=$searchterm pageSize=$pageSize active=$active modname='MediaRepository' type='user' func='view' ot='mediaHandler'}
        </th>
        <th id="htitle" scope="col" class="z-left">
            {sortlink __linktext='Title' sort='title' currentsort=$sort sortdir=$sdir all=$all own=$own Medium=$Medium searchterm=$searchterm pageSize=$pageSize active=$active modname='MediaRepository' type='user' func='view' ot='mediaHandler'}
        </th>
        <th id="hactive" scope="col" class="z-center">
            {sortlink __linktext='Active' sort='active' currentsort=$sort sortdir=$sdir all=$all own=$own Medium=$Medium searchterm=$searchterm pageSize=$pageSize active=$active modname='MediaRepository' type='user' func='view' ot='mediaHandler'}
        </th>
        <th id="himage" scope="col" class="z-left">
            {sortlink __linktext='Image' sort='image' currentsort=$sort sortdir=$sdir all=$all own=$own Medium=$Medium searchterm=$searchterm pageSize=$pageSize active=$active modname='MediaRepository' type='user' func='view' ot='mediaHandler'}
        </th>
        <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
    </tr>
    </thead>
    <tbody>

{foreach item='mediaHandler' from=$items}
    <tr class="{cycle values='z-odd, z-even'}">
        <td headers="hmimetype" class="z-left">
            {$mediaHandler.mimeType}
        </td>
        <td headers="hfiletype" class="z-left">
            {$mediaHandler.fileType}
        </td>
        <td headers="hfoundmimetype" class="z-left">
            {$mediaHandler.foundMimeType}
        </td>
        <td headers="hfoundfiletype" class="z-left">
            {$mediaHandler.foundFileType}
        </td>
        <td headers="hhandlername" class="z-left">
            {$mediaHandler.handlerName}
        </td>
        <td headers="htitle" class="z-left">
            {$mediaHandler.title|notifyfilters:'mediarepository.filterhook.mediahandlers'}
        </td>
        <td headers="hactive" class="z-center">
            {assign var='itemid' value=$mediaHandler.id}
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
        </td>
        <td headers="himage" class="z-left">
            {if $mediaHandler.image ne ''}
              <a href="{$mediaHandler.imageFullPathURL}" title="{$mediaHandler.title|replace:"\"":""}"{if $mediaHandler.imageMeta.isImage} rel="imageviewer[mediahandler]"{/if}>
              {if $mediaHandler.imageMeta.isImage}
                  <img src="{$mediaHandler.imageFullPath|mediarepositoryImageThumb:32:20}" width="32" height="20" alt="{$mediaHandler.title|replace:"\"":""}" />
              {else}
                  {gt text='Download'} ({$mediaHandler.imageMeta.size|mediarepositoryGetFileSize:$mediaHandler.imageFullPath:false:false})
              {/if}
              </a>
            {else}&nbsp;{/if}
        </td>
        <td id="itemactions{$mediaHandler.id}" headers="hitemactions" class="z-right z-nowrap z-w02">
            {if count($mediaHandler._actions) gt 0}
                {foreach item='option' from=$mediaHandler._actions}
                    <a href="{$option.url.type|mediarepositoryActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                {/foreach}
                {icon id="itemactions`$mediaHandler.id`trigger" type='options' size='extrasmall' __alt='Actions' style='display: none' class='z-pointer'}
            {/if}
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    medrepInitItemActions('mediaHandler', 'view', 'itemactions{{$mediaHandler.id}}');
                });
            /* ]]> */
            </script>
        </td>
    </tr>
{foreachelse}
    <tr class="z-datatableempty">
      <td class="z-left" colspan="9">
    {gt text='No media handlers found.'}
      </td>
    </tr>
{/foreach}

    </tbody>
</table>

{if !isset($showAllEntries) || $showAllEntries ne 1}
    {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
{/if}

{notifydisplayhooks eventname='mediarepository.ui_hooks.mediahandlers.display_view' urlobject=$currentUrlObject assign='hooks'}
{foreach key='providerArea' item='hook' from=$hooks}
    {$hook}
{/foreach}
</div>
</div>
{include file='user/footer.tpl'}

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
    {{foreach item='mediaHandler' from=$items}}
        {{assign var='itemid' value=$mediaHandler.id}}
        medrepInitToggle('mediaHandler', 'active', '{{$itemid}}');
    {{/foreach}}
    });
/* ]]> */
</script>
