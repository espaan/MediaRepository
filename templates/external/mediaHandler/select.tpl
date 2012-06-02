{* Purpose of this template: Display a popup selector for Forms and Content integration *}
{assign var='baseID' value='mediaHandler'}
<div id="{$baseID}_preview" style="float: right; width: 300px; border: 1px dotted #a3a3a3; padding: .2em .5em; margin-right: 1em">
    <p><strong>{gt text='Media handler information'}</strong></p>
    {img id='ajax_indicator' modname='core' set='ajax' src='indicator_circle.gif' alt='' style='display: none'}
    <div id="{$baseID}_previewcontainer">&nbsp;</div>
</div>
<br />
<br />
{assign var='leftSide' value=' style="float: left; width: 10em"'}
{assign var='rightSide' value=' style="float: left"'}
{assign var='break' value=' style="clear: left"'}
<p>
    <label for="{$baseID}_id"{$leftSide}>{gt text='Media handler'}:</label>
    <select id="{$baseID}_id" name="id" {$rightSide}>
        {foreach item='mediaHandler' from=$items}{strip}
            <option value="{$mediaHandler.id}"{if $selectedId eq $mediaHandler.id} selected="selected"{/if}>
                {$mediaHandler.title}
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
