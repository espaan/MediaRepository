{* Purpose of this template: Display a popup selector for Forms and Content integration *}
{assign var='baseID' value='medium'}
<div id="{$baseID}_preview" style="float: right; width: 300px; border: 1px dotted #a3a3a3; padding: .2em .5em; margin-right: 1em">
    <p><strong>{gt text='Medium information'}</strong></p>
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
    <label for="{$baseID}_id"{$leftSide}>{gt text='Medium'}:</label>
    <select id="{$baseID}_id" name="id" {$rightSide}>
        {foreach item='medium' from=$items}{strip}
            <option value="{$medium.id}"{if $selectedId eq $medium.id} selected="selected"{/if}>
                {$medium.title}
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
