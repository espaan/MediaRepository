{* purpose of this template: media view filter form in user area *}
{checkpermissionblock component='MediaRepository:Medium:' instance='.*' level='ACCESS_EDIT'}
<form action="{$modvars.ZConfig.entrypoint|default:'index.php'}" method="get" id="medrepMediumQuickNavForm" class="medrepQuickNavForm">
    <fieldset>
        <h3>{gt text='Quick navigation'}</h3>
        <input type="hidden" name="module" value="{modgetinfo modname='MediaRepository' info='displayname'}" />
        <input type="hidden" name="type" value="user" />
        <input type="hidden" name="func" value="view" />
        <input type="hidden" name="ot" value="medium" />
        {gt text='All' assign='lblDefault'}
        {if !isset($categoryFilter) || $categoryFilter eq true}
            <label for="categoryid">{gt text='Category'}</label>
            &nbsp;
            {modapifunc modname='MediaRepository' type='category' func='getMainCat' assign='mainCategory'}
            {selector_category category=$mainCategory name='catid' field='id' defaultText=$lblDefault editLink=false selectedValue=$catId}
        {/if}
        {if !isset($ownerFilter) || $ownerFilter eq true}
            <label for="owner">{gt text='Owner'}</label>
            {selector_user name='owner' selectedValue=$owner defaultText=$lblDefault}
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
            <option value="owner"{if $sort eq 'owner'} selected="selected"{/if}>{gt text='Owner'}</option>
            <option value="title"{if $sort eq 'title'} selected="selected"{/if}>{gt text='Title'}</option>
            <option value="keywords"{if $sort eq 'keywords'} selected="selected"{/if}>{gt text='Keywords'}</option>
            <option value="description"{if $sort eq 'description'} selected="selected"{/if}>{gt text='Description'}</option>
            <option value="description2"{if $sort eq 'description2'} selected="selected"{/if}>{gt text='Description2'}</option>
            <option value="dateTaken"{if $sort eq 'dateTaken'} selected="selected"{/if}>{gt text='Date taken'}</option>
            <option value="placeTaken"{if $sort eq 'placeTaken'} selected="selected"{/if}>{gt text='Place taken'}</option>
            <option value="notes"{if $sort eq 'notes'} selected="selected"{/if}>{gt text='Notes'}</option>
            <option value="license"{if $sort eq 'license'} selected="selected"{/if}>{gt text='License'}</option>
            <option value="areamap"{if $sort eq 'areamap'} selected="selected"{/if}>{gt text='Areamap'}</option>
            <option value="showLocation"{if $sort eq 'showLocation'} selected="selected"{/if}>{gt text='Show location'}</option>
            <option value="latitude"{if $sort eq 'latitude'} selected="selected"{/if}>{gt text='Latitude'}</option>
            <option value="longitude"{if $sort eq 'longitude'} selected="selected"{/if}>{gt text='Longitude'}</option>
            <option value="zoomFactor"{if $sort eq 'zoomFactor'} selected="selected"{/if}>{gt text='Zoom factor'}</option>
            <option value="settings"{if $sort eq 'settings'} selected="selected"{/if}>{gt text='Settings'}</option>
            <option value="dlcount"{if $sort eq 'dlcount'} selected="selected"{/if}>{gt text='Dlcount'}</option>
            <option value="url"{if $sort eq 'url'} selected="selected"{/if}>{gt text='Url'}</option>
            <option value="mediaHandler"{if $sort eq 'mediaHandler'} selected="selected"{/if}>{gt text='Media handler'}</option>
            <option value="freeType"{if $sort eq 'freeType'} selected="selected"{/if}>{gt text='Free type'}</option>
            <option value="additions"{if $sort eq 'additions'} selected="selected"{/if}>{gt text='Additions'}</option>
            <option value="fileUpload"{if $sort eq 'fileUpload'} selected="selected"{/if}>{gt text='File upload'}</option>
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
        {if !isset($showLocationFilter) || $showLocationFilter eq true}
            <input type="checkbox" id="showLocation" name="showLocation" value="1"{if $showLocation eq 1} checked="checked"{/if} />
            <label for="showLocation">{gt text='Show location'}</label>
        {/if}
        <input type="submit" name="updateview" id="quicknav_submit" value="{gt text='OK'}" />
    </fieldset>
</form>

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        medrepInitQuickNavigation('medium', 'user');
        {{if isset($searchFilter) && $searchFilter eq false}}
            {{* we can hide the submit button if we have no quick search field *}}
            $('quicknav_submit').hide();
        {{/if}}
    });
/* ]]> */
</script>
{/checkpermissionblock}
