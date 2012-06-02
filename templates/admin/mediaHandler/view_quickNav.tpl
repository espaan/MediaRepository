{* purpose of this template: media handlers view filter form in admin area *}
{checkpermissionblock component='MediaRepository:MediaHandler:' instance='.*' level='ACCESS_EDIT'}
<form action="{$modvars.ZConfig.entrypoint|default:'index.php'}" method="get" id="medrepMediaHandlerQuickNavForm" class="medrepQuickNavForm">
    <fieldset>
        <h3>{gt text='Quick navigation'}</h3>
        <input type="hidden" name="module" value="{modgetinfo modname='MediaRepository' info='displayname'}" />
        <input type="hidden" name="type" value="admin" />
        <input type="hidden" name="func" value="view" />
        <input type="hidden" name="ot" value="mediaHandler" />
        {gt text='All' assign='lblDefault'}
        {if !isset($searchFilter) || $searchFilter eq true}
            <label for="searchterm">{gt text='Search'}:</label>
            <input type="text" id="searchterm" name="searchterm" value="{$searchterm}" />
        {/if}
        {if !isset($sorting) || $sorting eq true}
            <label for="sortby">{gt text='Sort by'}</label>
            &nbsp;
            <select id="sortby" name="sort">
            <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
            <option value="mimeType"{if $sort eq 'mimeType'} selected="selected"{/if}>{gt text='Mime type'}</option>
            <option value="fileType"{if $sort eq 'fileType'} selected="selected"{/if}>{gt text='File type'}</option>
            <option value="foundMimeType"{if $sort eq 'foundMimeType'} selected="selected"{/if}>{gt text='Found mime type'}</option>
            <option value="foundFileType"{if $sort eq 'foundFileType'} selected="selected"{/if}>{gt text='Found file type'}</option>
            <option value="handlerName"{if $sort eq 'handlerName'} selected="selected"{/if}>{gt text='Handler name'}</option>
            <option value="title"{if $sort eq 'title'} selected="selected"{/if}>{gt text='Title'}</option>
            <option value="active"{if $sort eq 'active'} selected="selected"{/if}>{gt text='Active'}</option>
            <option value="image"{if $sort eq 'image'} selected="selected"{/if}>{gt text='Image'}</option>
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
        {if !isset($activeFilter) || $activeFilter eq true}
            <input type="checkbox" id="active" name="active" value="1"{if $active eq 1} checked="checked"{/if} />
            <label for="active">{gt text='Active'}</label>
        {/if}
        <input type="submit" name="updateview" id="quicknav_submit" value="{gt text='OK'}" />
    </fieldset>
</form>

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        medrepInitQuickNavigation('mediaHandler', 'admin');
        {{if isset($searchFilter) && $searchFilter eq false}}
            {{* we can hide the submit button if we have no quick search field *}}
            $('quicknav_submit').hide();
        {{/if}}
    });
/* ]]> */
</script>
{/checkpermissionblock}
