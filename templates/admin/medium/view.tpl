{* purpose of this template: media view view in admin area *}
{include file='admin/header.tpl'}
<div class="mediarepository-medium mediarepository-view">
{gt text='Medium list' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-admin-content-pagetitle">
    {icon type='view' size='small' alt=$templateTitle}
    <h3>{$templateTitle}</h3>
</div>

{checkpermissionblock component='MediaRepository:Medium:' instance='.*' level='ACCESS_ADD'}
    {gt text='Create medium' assign='createTitle'}
    <a href="{modurl modname='MediaRepository' type='admin' func='edit' ot='medium'}" title="{$createTitle}" class="z-icon-es-add">
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
    <a href="{modurl modname='MediaRepository' type='admin' func='view' ot='medium'}" title="{$linkTitle}" class="z-icon-es-view">
        {$linkTitle}
    </a>
    {assign var='all' value=1}
{else}
    {gt text='Show all entries' assign='linkTitle'}
    <a href="{modurl modname='MediaRepository' type='admin' func='view' ot='medium' all=1}" title="{$linkTitle}" class="z-icon-es-view">
        {$linkTitle}
    </a>
{/if}

{include file='admin/medium/view_quickNav.tpl'}{* see template file for available options *}

<table class="z-datatable">
    <colgroup>
        <col id="cowner" />
        <col id="ctitle" />
        <col id="ckeywords" />
        <col id="cdescription" />
        <col id="clicense" />
        <col id="cdlcount" />
        <col id="curl" />
        <col id="cmediahandler" />
        <col id="cfreetype" />
        <col id="cfileupload" />
        <col id="citemactions" />
    </colgroup>
    <thead>
    <tr>
        <th id="howner" scope="col" class="z-left">
            {sortlink __linktext='Owner' sort='owner' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId Repository=$Repository owner=$owner searchterm=$searchterm pageSize=$pageSize showLocation=$showLocation modname='MediaRepository' type='admin' func='view' ot='medium'}
        </th>
        <th id="htitle" scope="col" class="z-left">
            {sortlink __linktext='Title' sort='title' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId Repository=$Repository owner=$owner searchterm=$searchterm pageSize=$pageSize showLocation=$showLocation modname='MediaRepository' type='admin' func='view' ot='medium'}
        </th>
        <th id="hkeywords" scope="col" class="z-left">
            {sortlink __linktext='Keywords' sort='keywords' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId Repository=$Repository owner=$owner searchterm=$searchterm pageSize=$pageSize showLocation=$showLocation modname='MediaRepository' type='admin' func='view' ot='medium'}
        </th>
        <th id="hdescription" scope="col" class="z-left">
            {sortlink __linktext='Description' sort='description' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId Repository=$Repository owner=$owner searchterm=$searchterm pageSize=$pageSize showLocation=$showLocation modname='MediaRepository' type='admin' func='view' ot='medium'}
        </th>
        <th id="hlicense" scope="col" class="z-left">
            {sortlink __linktext='License' sort='license' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId Repository=$Repository owner=$owner searchterm=$searchterm pageSize=$pageSize showLocation=$showLocation modname='MediaRepository' type='admin' func='view' ot='medium'}
        </th>
        <th id="hdlcount" scope="col" class="z-right">
            {sortlink __linktext='Dlcount' sort='dlcount' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId Repository=$Repository owner=$owner searchterm=$searchterm pageSize=$pageSize showLocation=$showLocation modname='MediaRepository' type='admin' func='view' ot='medium'}
        </th>
        <th id="hurl" scope="col" class="z-left">
            {sortlink __linktext='Url' sort='url' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId Repository=$Repository owner=$owner searchterm=$searchterm pageSize=$pageSize showLocation=$showLocation modname='MediaRepository' type='admin' func='view' ot='medium'}
        </th>
        <th id="hmediahandler" scope="col" class="z-left">
            {sortlink __linktext='Media handler' sort='mediaHandler' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId Repository=$Repository owner=$owner searchterm=$searchterm pageSize=$pageSize showLocation=$showLocation modname='MediaRepository' type='admin' func='view' ot='medium'}
        </th>
        <th id="hfreetype" scope="col" class="z-right">
            {sortlink __linktext='Free type' sort='freeType' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId Repository=$Repository owner=$owner searchterm=$searchterm pageSize=$pageSize showLocation=$showLocation modname='MediaRepository' type='admin' func='view' ot='medium'}
        </th>
        <th id="hadditions" scope="col" class="z-left">
            {sortlink __linktext='Additions' sort='additions' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId Repository=$Repository owner=$owner searchterm=$searchterm pageSize=$pageSize showLocation=$showLocation modname='MediaRepository' type='admin' func='view' ot='medium'}
        </th>
        <th id="hfileupload" scope="col" class="z-left">
            {sortlink __linktext='File upload' sort='fileUpload' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId Repository=$Repository owner=$owner searchterm=$searchterm pageSize=$pageSize showLocation=$showLocation modname='MediaRepository' type='admin' func='view' ot='medium'}
        </th>
        <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
    </tr>
    </thead>
    <tbody>

{foreach item='medium' from=$items}
    <tr class="{cycle values='z-odd, z-even'}">
        <td headers="howner" class="z-left">
                {$medium.owner|profilelinkbyuid}
        </td>
        <td headers="htitle" class="z-left">
            {$medium.title|notifyfilters:'mediarepository.filterhook.media'}
        </td>
        <td headers="hkeywords" class="z-left">
            {$medium.keywords}
        </td>
        <td headers="hdescription" class="z-left">
            {$medium.description}
        </td>
        <td headers="hlicense" class="z-left">
            {$medium.license}
        </td>
        <td headers="hdlcount" class="z-right">
            {$medium.dlcount}
        </td>
        <td headers="hurl" class="z-left">
            {if $medium.url ne ''}
                <a href="{$medium.url}" title="{gt text='Visit this page'}">{icon type='url' size='extrasmall' __alt='Homepage'}</a>
            {else}&nbsp;{/if}
        </td>
        <td headers="hmediahandler" class="z-left">
            {$medium.mediaHandler}
        </td>
        <td headers="hfreetype" class="z-right">
            {$medium.freeType}
        </td>
        <td headers="hadditions" class="z-left">
            {$medium.additions}
        </td>
        <td headers="hfileupload" class="z-left">
              <a href="{$medium.fileUploadFullPathURL}" title="{$medium.title|replace:"\"":""}"{if $medium.fileUploadMeta.isImage} rel="imageviewer[medium]"{/if}>
              {if $medium.fileUploadMeta.isImage}
                  <img src="{$medium.fileUploadFullPath|mediarepositoryImageThumb:32:20}" width="32" height="20" alt="{$medium.title|replace:"\"":""}" />
              {else}
                  {gt text='Download'} ({$medium.fileUploadMeta.size|mediarepositoryGetFileSize:$medium.fileUploadFullPath:false:false})
              {/if}
              </a>
        </td>
        <td id="itemactions{$medium.id}" headers="hitemactions" class="z-right z-nowrap z-w02">
            {if count($medium._actions) gt 0}
                {foreach item='option' from=$medium._actions}
                    <a href="{$option.url.type|mediarepositoryActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                {/foreach}
                {icon id="itemactions`$medium.id`trigger" type='options' size='extrasmall' __alt='Actions' style='display: none' class='z-pointer'}
            {/if}
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    medrepInitItemActions('medium', 'view', 'itemactions{{$medium.id}}');
                });
            /* ]]> */
            </script>
        </td>
    </tr>
{foreachelse}
    <tr class="z-admintableempty">
      <td class="z-left" colspan="22">
    {gt text='No media found.'}
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

