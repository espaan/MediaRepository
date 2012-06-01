{* Purpose of this template: Display a popup selector for Forms and Content integration *}
{assign var='baseID' value='repository'}
<div id="{$baseID}_preview" style="float: right; width: 300px; border: 1px dotted #a3a3a3; padding: .2em .5em; margin-right: 1em">
    <p><strong>{gt text='Repository information'}</strong></p>
    {img id='ajax_indicator' modname='core' set='ajax' src='indicator_circle.gif' alt='' style='display: none'}
    <div id="{$baseID}_previewcontainer">&nbsp;</div>
</div>
<br />
<br />
{assign var='leftSide' value=' style="float: left; width: 10em"'}
{assign var='rightSide' value=' style="float: left"'}
{assign var='break' value=' style="clear: left"'}
<p>
    <label for="{$baseID}_catid"{$leftSide}>{gt text='Category'}:</label>
    {gt text='All' assign='lblDef'}
    {selector_category category=$mainCategory name="`$baseID`_catid" field='id' defaultText=$lblDef editLink=false selectedValue=$catId}
    <br{$break} />
</p>
<p>
    <label for="{$baseID}_id"{$leftSide}>{gt text='Repository'}:</label>
    <select id="{$baseID}_id" name="id" {$rightSide}>
        {foreach item='repository' from=$items}{strip}
            <option value="{$repository.id}"{if $selectedId eq $repository.id} selected="selected"{/if}>
                {$repository.name}
            </option>{/strip}
        {foreachelse}
            <option value="0">{gt text='No entries found.'}</option>
        {/foreach}
    </select>
    <br{$break} />
</p>
<p>
    <label for="{$baseID}_sort"{$leftSide}>{gt text='Sort by'}:</label>
    <select id="{$baseID}_sort" name="sort" {$rightSide}>
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
        <option value="defaultTemplateCollection"{if $sort eq 'defaultTemplateCollection'} selected="selected"{/if}>{gt text='Default template collection'}</option>
        <option value="allowTemplateOverrideCollection"{if $sort eq 'allowTemplateOverrideCollection'} selected="selected"{/if}>{gt text='Allow template override collection'}</option>
        <option value="defaultTemplateDetail"{if $sort eq 'defaultTemplateDetail'} selected="selected"{/if}>{gt text='Default template detail'}</option>
        <option value="allowTemplateOverrideDetail"{if $sort eq 'allowTemplateOverrideDetail'} selected="selected"{/if}>{gt text='Allow template override detail'}</option>
        <option value="startPageViewMode"{if $sort eq 'startPageViewMode'} selected="selected"{/if}>{gt text='Start page view mode'}</option>
        <option value="downloadMode"{if $sort eq 'downloadMode'} selected="selected"{/if}>{gt text='Download mode'}</option>
        <option value="sendMailAfterUpload"{if $sort eq 'sendMailAfterUpload'} selected="selected"{/if}>{gt text='Send mail after upload'}</option>
        <option value="mailRecipient"{if $sort eq 'mailRecipient'} selected="selected"{/if}>{gt text='Mail recipient'}</option>
        <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
        <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
        <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
    </select>
    <select id="{$baseID}_sortdir" name="sortdir">
        <option value="asc"{if $sortdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
        <option value="desc"{if $sortdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
    </select>
    <br{$break} />
</p>
<p>
    <label for="{$baseID}_searchterm"{$leftSide}>{gt text='Search for'}:</label>
    <input type="text" id="{$baseID}_searchterm" name="searchterm"{$rightSide} />
    <input type="button" id="MediaRepository_gosearch" name="gosearch" value="{gt text='Filter'}" />
    <br{$break} />
</p>
<br />
<br />

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        mediarepository.itemSelector.onLoad('{{$baseID}}', {{$selectedId|default:0}});
    });
/* ]]> */
</script>
