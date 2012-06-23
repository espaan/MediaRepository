{* purpose of this template: repositories view filter form in admin area *}
{checkpermissionblock component='MediaRepository:Repository:' instance='.*' level='ACCESS_EDIT'}
<form action="{$modvars.ZConfig.entrypoint|default:'index.php'}" method="get" id="medrepRepositoryQuickNavForm" class="medrepQuickNavForm">
    <fieldset>
        <h3>{gt text='Quick navigation'}</h3>
        <input type="hidden" name="module" value="{modgetinfo modname='MediaRepository' info='displayname'}" />
        <input type="hidden" name="type" value="admin" />
        <input type="hidden" name="func" value="view" />
        <input type="hidden" name="ot" value="repository" />
        {gt text='All' assign='lblDefault'}
        {if !isset($categoryFilter) || $categoryFilter eq true}
            <label for="categoryid">{gt text='Category'}</label>
            &nbsp;
            {modapifunc modname='MediaRepository' type='category' func='getMainCat' assign='mainCategory'}
            {selector_category category=$mainCategory name='catid' field='id' defaultText=$lblDefault editLink=false selectedValue=$catId}
        {/if}
        {if !isset($searchFilter) || $searchFilter eq true}
            <label for="searchterm">{gt text='Search'}:</label>
            <input type="text" id="searchterm" name="searchterm" value="{$searchterm}" />
        {/if}
        {if !isset($sorting) || $sorting eq true}
            <label for="sortby">{gt text='Sort by'}</label>
            &nbsp;
            <select id="sortby" name="sort">
            <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
            <option value="name"{if $sort eq 'name'} selected="selected"{/if}>{gt text='Name'}</option>
            <option value="workDirectory"{if $sort eq 'workDirectory'} selected="selected"{/if}>{gt text='Work directory'}</option>
            <option value="storageDirectory"{if $sort eq 'storageDirectory'} selected="selected"{/if}>{gt text='Storage directory'}</option>
            <option value="cacheDirectory"{if $sort eq 'cacheDirectory'} selected="selected"{/if}>{gt text='Cache directory'}</option>
            <option value="storageMode"{if $sort eq 'storageMode'} selected="selected"{/if}>{gt text='Storage mode'}</option>
            <option value="permissionScope"{if $sort eq 'permissionScope'} selected="selected"{/if}>{gt text='Permission scope'}</option>
            <option value="useQuota"{if $sort eq 'useQuota'} selected="selected"{/if}>{gt text='Use quota'}</option>
            <option value="allowManagementOfOwnFiles"{if $sort eq 'allowManagementOfOwnFiles'} selected="selected"{/if}>{gt text='Allow management of own files'}</option>
            <option value="allowFileMailing"{if $sort eq 'allowFileMailing'} selected="selected"{/if}>{gt text='Allow file mailing'}</option>
            <option value="maxSizeForMail"{if $sort eq 'maxSizeForMail'} selected="selected"{/if}>{gt text='Max size for mail'}</option>
            <option value="maxFilesPerUpload"{if $sort eq 'maxFilesPerUpload'} selected="selected"{/if}>{gt text='Max files per upload'}</option>
            <option value="maxUploadFileSize"{if $sort eq 'maxUploadFileSize'} selected="selected"{/if}>{gt text='Max upload file size'}</option>
            <option value="uploadNamingConvention"{if $sort eq 'uploadNamingConvention'} selected="selected"{/if}>{gt text='Upload naming convention'}</option>
            <option value="uploadNamingPrefix"{if $sort eq 'uploadNamingPrefix'} selected="selected"{/if}>{gt text='Upload naming prefix'}</option>
            <option value="enableSharpen"{if $sort eq 'enableSharpen'} selected="selected"{/if}>{gt text='Enable sharpen'}</option>
            <option value="enableShrinking"{if $sort eq 'enableShrinking'} selected="selected"{/if}>{gt text='Enable shrinking'}</option>
            <option value="shrinkDimensions"{if $sort eq 'shrinkDimensions'} selected="selected"{/if}>{gt text='Shrink dimensions'}</option>
            <option value="useThumbCropper"{if $sort eq 'useThumbCropper'} selected="selected"{/if}>{gt text='Use thumb cropper'}</option>
            <option value="cropSizeMode"{if $sort eq 'cropSizeMode'} selected="selected"{/if}>{gt text='Crop size mode'}</option>
            <option value="downloadMode"{if $sort eq 'downloadMode'} selected="selected"{/if}>{gt text='Download mode'}</option>
            <option value="sendMailAfterUpload"{if $sort eq 'sendMailAfterUpload'} selected="selected"{/if}>{gt text='Send mail after upload'}</option>
            <option value="mailRecipient"{if $sort eq 'mailRecipient'} selected="selected"{/if}>{gt text='Mail recipient'}</option>
            <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
            <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
            <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
            </select>
            <select id="sortdir" name="sortdir">
                <option value="asc"{if $sdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
                <option value="desc"{if $sdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
            </select>
        {else}
            <input type="hidden" name="sort" value="{$sort}" />
            <input type="hidden" name="sdir" value="{if $sdir eq 'desc'}asc{else}desc{/if}" />
        {/if}
        {if !isset($pageSizeSelector) || $pageSizeSelector eq true}
            {assign var='pageSize' value=$pager.itemsperpage}
            <label for="num">{gt text='Page size'}</label>
            &nbsp;
            <select id="num" name="num">
                <option value="5"{if $pageSize eq 5} selected="selected"{/if}>5</option>
                <option value="10"{if $pageSize eq 10} selected="selected"{/if}>10</option>
                <option value="15"{if $pageSize eq 15} selected="selected"{/if}>15</option>
                <option value="20"{if $pageSize eq 20} selected="selected"{/if}>20</option>
                <option value="30"{if $pageSize eq 30} selected="selected"{/if}>30</option>
                <option value="50"{if $pageSize eq 50} selected="selected"{/if}>50</option>
                <option value="100"{if $pageSize eq 100} selected="selected"{/if}>100</option>
            </select>
        {/if}
        {if !isset($useQuotaFilter) || $useQuotaFilter eq true}
            <input type="checkbox" id="useQuota" name="useQuota" value="1"{if $useQuota eq 1} checked="checked"{/if} />
            <label for="useQuota">{gt text='Use quota'}</label>
        {/if}
        {if !isset($allowManagementOfOwnFilesFilter) || $allowManagementOfOwnFilesFilter eq true}
            <input type="checkbox" id="allowManagementOfOwnFiles" name="allowManagementOfOwnFiles" value="1"{if $allowManagementOfOwnFiles eq 1} checked="checked"{/if} />
            <label for="allowManagementOfOwnFiles">{gt text='Allow management of own files'}</label>
        {/if}
        {if !isset($allowFileMailingFilter) || $allowFileMailingFilter eq true}
            <input type="checkbox" id="allowFileMailing" name="allowFileMailing" value="1"{if $allowFileMailing eq 1} checked="checked"{/if} />
            <label for="allowFileMailing">{gt text='Allow file mailing'}</label>
        {/if}
        {if !isset($enableSharpenFilter) || $enableSharpenFilter eq true}
            <input type="checkbox" id="enableSharpen" name="enableSharpen" value="1"{if $enableSharpen eq 1} checked="checked"{/if} />
            <label for="enableSharpen">{gt text='Enable sharpen'}</label>
        {/if}
        {if !isset($enableShrinkingFilter) || $enableShrinkingFilter eq true}
            <input type="checkbox" id="enableShrinking" name="enableShrinking" value="1"{if $enableShrinking eq 1} checked="checked"{/if} />
            <label for="enableShrinking">{gt text='Enable shrinking'}</label>
        {/if}
        {if !isset($useThumbCropperFilter) || $useThumbCropperFilter eq true}
            <input type="checkbox" id="useThumbCropper" name="useThumbCropper" value="1"{if $useThumbCropper eq 1} checked="checked"{/if} />
            <label for="useThumbCropper">{gt text='Use thumb cropper'}</label>
        {/if}
        {if !isset($sendMailAfterUploadFilter) || $sendMailAfterUploadFilter eq true}
            <input type="checkbox" id="sendMailAfterUpload" name="sendMailAfterUpload" value="1"{if $sendMailAfterUpload eq 1} checked="checked"{/if} />
            <label for="sendMailAfterUpload">{gt text='Send mail after upload'}</label>
        {/if}
        <input type="submit" name="updateview" id="quicknav_submit" value="{gt text='OK'}" />
    </fieldset>
</form>

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        medrepInitQuickNavigation('repository', 'admin');
        {{if isset($searchFilter) && $searchFilter eq false}}
            {{* we can hide the submit button if we have no quick search field *}}
            $('quicknav_submit').hide();
        {{/if}}
    });
/* ]]> */
</script>
{/checkpermissionblock}
