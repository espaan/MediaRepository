{* purpose of this template: thumb sizes view view in admin area *}
{include file='admin/header.tpl'}
<div class="mediarepository-thumbsize mediarepository-view">
{gt text='Thumb size list' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-admin-content-pagetitle">
    {icon type='view' size='small' alt=$templateTitle}
    <h3>{$templateTitle}</h3>
</div>

{checkpermissionblock component='MediaRepository:ThumbSize:' instance='.*' level='ACCESS_ADD'}
    {gt text='Create thumb size' assign='createTitle'}
    <a href="{modurl modname='MediaRepository' type='admin' func='edit' ot='thumbSize'}" title="{$createTitle}" class="z-icon-es-add">
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
    <a href="{modurl modname='MediaRepository' type='admin' func='view' ot='thumbSize'}" title="{$linkTitle}" class="z-icon-es-view">
        {$linkTitle}
    </a>
    {assign var='all' value=1}
{else}
    {gt text='Show all entries' assign='linkTitle'}
    <a href="{modurl modname='MediaRepository' type='admin' func='view' ot='thumbSize' all=1}" title="{$linkTitle}" class="z-icon-es-view">
        {$linkTitle}
    </a>
{/if}

{include file='admin/thumbSize/view_quickNav.tpl'}{* see template file for available options *}

<table class="z-datatable">
    <colgroup>
        <col id="cname" />
        <col id="cwidth" />
        <col id="cheight" />
        <col id="ckeepaspectratio" />
        <col id="citemactions" />
    </colgroup>
    <thead>
    <tr>
        <th id="hname" scope="col" class="z-left">
            {sortlink __linktext='Name' sort='name' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize keepAspectRatio=$keepAspectRatio modname='MediaRepository' type='admin' func='view' ot='thumbSize'}
        </th>
        <th id="hwidth" scope="col" class="z-right">
            {sortlink __linktext='Width' sort='width' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize keepAspectRatio=$keepAspectRatio modname='MediaRepository' type='admin' func='view' ot='thumbSize'}
        </th>
        <th id="hheight" scope="col" class="z-right">
            {sortlink __linktext='Height' sort='height' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize keepAspectRatio=$keepAspectRatio modname='MediaRepository' type='admin' func='view' ot='thumbSize'}
        </th>
        <th id="hkeepaspectratio" scope="col" class="z-center">
            {sortlink __linktext='Keep aspect ratio' sort='keepAspectRatio' currentsort=$sort sortdir=$sdir all=$all own=$own searchterm=$searchterm pageSize=$pageSize keepAspectRatio=$keepAspectRatio modname='MediaRepository' type='admin' func='view' ot='thumbSize'}
        </th>
        <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
    </tr>
    </thead>
    <tbody>

{foreach item='thumbSize' from=$items}
    <tr class="{cycle values='z-odd, z-even'}">
        <td headers="hname" class="z-left">
            {$thumbSize.name|notifyfilters:'mediarepository.filterhook.thumbsizes'}
        </td>
        <td headers="hwidth" class="z-right">
            {$thumbSize.width}
        </td>
        <td headers="hheight" class="z-right">
            {$thumbSize.height}
        </td>
        <td headers="hkeepaspectratio" class="z-center">
            {$thumbSize.keepAspectRatio|yesno:true}
        </td>
        <td id="itemactions{$thumbSize.id}" headers="hitemactions" class="z-right z-nowrap z-w02">
            {if count($thumbSize._actions) gt 0}
                {foreach item='option' from=$thumbSize._actions}
                    <a href="{$option.url.type|mediarepositoryActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                {/foreach}
                {icon id="itemactions`$thumbSize.id`trigger" type='options' size='extrasmall' __alt='Actions' style='display: none' class='z-pointer'}
                <script type="text/javascript">
                /* <![CDATA[ */
                    document.observe('dom:loaded', function() {
                        medrepInitItemActions('thumbSize', 'view', 'itemactions{{$thumbSize.id}}');
                    });
                /* ]]> */
                </script>
            {/if}
        </td>
    </tr>
{foreachelse}
    <tr class="z-admintableempty">
      <td class="z-left" colspan="5">
    {gt text='No thumb sizes found.'}
      </td>
    </tr>
{/foreach}

    </tbody>
</table>

{if !isset($showAllEntries) || $showAllEntries ne 1}
    {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
{/if}
</div>
{include file='admin/footer.tpl'}

