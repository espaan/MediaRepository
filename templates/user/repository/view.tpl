{* purpose of this template: repositories view view in user area *}
{include file='user/header.tpl'}
<div class="mediarepository-repository mediarepository-view">
{gt text='Repository list' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>

{checkpermissionblock component='MediaRepository:Repository:' instance='.*' level='ACCESS_ADD'}
    {gt text='Create repository' assign='createTitle'}
    <a href="{modurl modname='MediaRepository' type='user' func='edit' ot='repository'}" title="{$createTitle}" class="z-icon-es-add">
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
    <a href="{modurl modname='MediaRepository' type='user' func='view' ot='repository'}" title="{$linkTitle}" class="z-icon-es-view">
        {$linkTitle}
    </a>
    {assign var='all' value=1}
{else}
    {gt text='Show all entries' assign='linkTitle'}
    <a href="{modurl modname='MediaRepository' type='user' func='view' ot='repository' all=1}" title="{$linkTitle}" class="z-icon-es-view">
        {$linkTitle}
    </a>
{/if}

{include file='user/repository/view_quickNav.tpl'}{* see template file for available options *}

<table class="z-datatable">
    <colgroup>
        <col id="cname" />
        <col id="cworkdirectory" />
        <col id="cstoragedirectory" />
        <col id="ccachedirectory" />
        <col id="cstoragemode" />
        <col id="cpermissionscope" />
        <col id="cusequota" />
        <col id="callowmanagementofownfiles" />
        <col id="callowfilemailing" />
        <col id="cmaxsizeformail" />
        <col id="cmaxfilesperupload" />
        <col id="cmaxuploadfilesize" />
        <col id="cuploadnamingconvention" />
        <col id="cuploadnamingprefix" />
        <col id="cenablesharpen" />
        <col id="cenableshrinking" />
        <col id="cshrinkdimensions" />
        <col id="cusethumbcropper" />
        <col id="ccropsizemode" />
        <col id="cdownloadmode" />
        <col id="csendmailafterupload" />
        <col id="cmailrecipient" />
        <col id="citemactions" />
    </colgroup>
    <thead>
    <tr>
        <th id="hname" scope="col" class="z-left">
            {sortlink __linktext='Name' sort='name' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="hworkdirectory" scope="col" class="z-left">
            {sortlink __linktext='Work directory' sort='workDirectory' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="hstoragedirectory" scope="col" class="z-left">
            {sortlink __linktext='Storage directory' sort='storageDirectory' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="hcachedirectory" scope="col" class="z-left">
            {sortlink __linktext='Cache directory' sort='cacheDirectory' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="hstoragemode" scope="col" class="z-right">
            {sortlink __linktext='Storage mode' sort='storageMode' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="hpermissionscope" scope="col" class="z-right">
            {sortlink __linktext='Permission scope' sort='permissionScope' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="husequota" scope="col" class="z-center">
            {sortlink __linktext='Use quota' sort='useQuota' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="hallowmanagementofownfiles" scope="col" class="z-center">
            {sortlink __linktext='Allow management of own files' sort='allowManagementOfOwnFiles' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="hallowfilemailing" scope="col" class="z-center">
            {sortlink __linktext='Allow file mailing' sort='allowFileMailing' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="hmaxsizeformail" scope="col" class="z-right">
            {sortlink __linktext='Max size for mail' sort='maxSizeForMail' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="hmaxfilesperupload" scope="col" class="z-right">
            {sortlink __linktext='Max files per upload' sort='maxFilesPerUpload' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="hmaxuploadfilesize" scope="col" class="z-right">
            {sortlink __linktext='Max upload file size' sort='maxUploadFileSize' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="huploadnamingconvention" scope="col" class="z-right">
            {sortlink __linktext='Upload naming convention' sort='uploadNamingConvention' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="huploadnamingprefix" scope="col" class="z-left">
            {sortlink __linktext='Upload naming prefix' sort='uploadNamingPrefix' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="henablesharpen" scope="col" class="z-center">
            {sortlink __linktext='Enable sharpen' sort='enableSharpen' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="henableshrinking" scope="col" class="z-center">
            {sortlink __linktext='Enable shrinking' sort='enableShrinking' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="hshrinkdimensions" scope="col" class="z-left">
            {sortlink __linktext='Shrink dimensions' sort='shrinkDimensions' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="husethumbcropper" scope="col" class="z-center">
            {sortlink __linktext='Use thumb cropper' sort='useThumbCropper' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="hcropsizemode" scope="col" class="z-right">
            {sortlink __linktext='Crop size mode' sort='cropSizeMode' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="hdownloadmode" scope="col" class="z-right">
            {sortlink __linktext='Download mode' sort='downloadMode' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="hsendmailafterupload" scope="col" class="z-center">
            {sortlink __linktext='Send mail after upload' sort='sendMailAfterUpload' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="hmailrecipient" scope="col" class="z-left">
            {sortlink __linktext='Mail recipient' sort='mailRecipient' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId searchterm=$searchterm pageSize=$pageSize useQuota=$useQuota allowManagementOfOwnFiles=$allowManagementOfOwnFiles allowFileMailing=$allowFileMailing enableSharpen=$enableSharpen enableShrinking=$enableShrinking useThumbCropper=$useThumbCropper sendMailAfterUpload=$sendMailAfterUpload modname='MediaRepository' type='user' func='view' ot='repository'}
        </th>
        <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
    </tr>
    </thead>
    <tbody>

{foreach item='repository' from=$items}
    <tr class="{cycle values='z-odd, z-even'}">
        <td headers="hname" class="z-left">
            {$repository.name|notifyfilters:'mediarepository.filterhook.repositories'}
        </td>
        <td headers="hworkdirectory" class="z-left">
            {$repository.workDirectory}
        </td>
        <td headers="hstoragedirectory" class="z-left">
            {$repository.storageDirectory}
        </td>
        <td headers="hcachedirectory" class="z-left">
            {$repository.cacheDirectory}
        </td>
        <td headers="hstoragemode" class="z-right">
            {$repository.storageMode}
        </td>
        <td headers="hpermissionscope" class="z-right">
            {$repository.permissionScope}
        </td>
        <td headers="husequota" class="z-center">
            {$repository.useQuota|yesno:true}
        </td>
        <td headers="hallowmanagementofownfiles" class="z-center">
            {$repository.allowManagementOfOwnFiles|yesno:true}
        </td>
        <td headers="hallowfilemailing" class="z-center">
            {$repository.allowFileMailing|yesno:true}
        </td>
        <td headers="hmaxsizeformail" class="z-right">
            {$repository.maxSizeForMail}
        </td>
        <td headers="hmaxfilesperupload" class="z-right">
            {$repository.maxFilesPerUpload}
        </td>
        <td headers="hmaxuploadfilesize" class="z-right">
            {$repository.maxUploadFileSize}
        </td>
        <td headers="huploadnamingconvention" class="z-right">
            {$repository.uploadNamingConvention}
        </td>
        <td headers="huploadnamingprefix" class="z-left">
            {$repository.uploadNamingPrefix}
        </td>
        <td headers="henablesharpen" class="z-center">
            {$repository.enableSharpen|yesno:true}
        </td>
        <td headers="henableshrinking" class="z-center">
            {$repository.enableShrinking|yesno:true}
        </td>
        <td headers="hshrinkdimensions" class="z-left">
            {$repository.shrinkDimensions}
        </td>
        <td headers="husethumbcropper" class="z-center">
            {$repository.useThumbCropper|yesno:true}
        </td>
        <td headers="hcropsizemode" class="z-right">
            {$repository.cropSizeMode}
        </td>
        <td headers="hdownloadmode" class="z-right">
            {$repository.downloadMode}
        </td>
        <td headers="hsendmailafterupload" class="z-center">
            {$repository.sendMailAfterUpload|yesno:true}
        </td>
        <td headers="hmailrecipient" class="z-left">
            {$repository.mailRecipient}
        </td>
        <td id="itemactions{$repository.id}" headers="hitemactions" class="z-right z-nowrap z-w02">
            {if count($repository._actions) gt 0}
                {foreach item='option' from=$repository._actions}
                    <a href="{$option.url.type|mediarepositoryActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                {/foreach}
                {icon id="itemactions`$repository.id`trigger" type='options' size='extrasmall' __alt='Actions' style='display: none' class='z-pointer'}
                <script type="text/javascript">
                /* <![CDATA[ */
                    document.observe('dom:loaded', function() {
                        medrepInitItemActions('repository', 'view', 'itemactions{{$repository.id}}');
                    });
                /* ]]> */
                </script>
            {/if}
        </td>
    </tr>
{foreachelse}
    <tr class="z-datatableempty">
      <td class="z-left" colspan="23">
    {gt text='No repositories found.'}
      </td>
    </tr>
{/foreach}

    </tbody>
</table>

{if !isset($showAllEntries) || $showAllEntries ne 1}
    {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
{/if}

{notifydisplayhooks eventname='mediarepository.ui_hooks.repositories.display_view' urlobject=$currentUrlObject assign='hooks'}
{foreach key='providerArea' item='hook' from=$hooks}
    {$hook}
{/foreach}
</div>
</div>
{include file='user/footer.tpl'}

