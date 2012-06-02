{* Purpose of this template: Edit block for generic item list *}
<div class="z-formrow">
    <label for="MediaRepository_objecttype">{gt text='Object type'}:</label>
    <select id="MediaRepository_objecttype" name="objecttype" size="1">
        <option value="repository"{if $objectType eq 'repository'} selected="selected"{/if}>{gt text='Repositories'}</option>
        <option value="mediaHandler"{if $objectType eq 'mediaHandler'} selected="selected"{/if}>{gt text='Media handlers'}</option>
        <option value="medium"{if $objectType eq 'medium'} selected="selected"{/if}>{gt text='Media'}</option>
        <option value="thumbSize"{if $objectType eq 'thumbSize'} selected="selected"{/if}>{gt text='Thumb sizes'}</option>
    </select>
</div>
{if $mainCategory ne null}
    <div class="z-formrow">
        <label for="catid">{gt text='Category'}</label>
        {gt text='All' assign='lblDef'}
        {selector_category category=$mainCategory name='catid' field='id' defaultText=$lblDef editLink=false selectedValue=$catId}
        <p class="z-formnote">{gt text='This is an optional filter.'}</p>
    </div>
{/if}
<div class="z-formrow">
    <label for="MediaRepository_sorting">{gt text='Sorting'}:</label>
    <select id="MediaRepository_sorting" name="sorting">
        <option value="random"{if $sorting eq 'random'} selected="selected"{/if}>{gt text='Random'}</option>
        <option value="newest"{if $sorting eq 'newest'} selected="selected"{/if}>{gt text='Newest'}</option>
        <option value="alpha"{if $sorting eq 'default' || ($sorting != 'random' && $sorting != 'newest')} selected="selected"{/if}>{gt text='Default'}</option>
    </select>
</div>
<div class="z-formrow">
    <label for="MediaRepository_amount">{gt text='Amount'}:</label>
    <input type="text" id="MediaRepository_amount" name="amount" size="10" value="{$amount|default:"5"}" />
</div>
<div class="z-formrow">
    <label for="MediaRepository_template">{gt text='Template File'}:</label>
    <select id="MediaRepository_template" name="template">
        <option value="itemlist_display.tpl"{if $template eq 'itemlist_display.tpl'} selected="selected"{/if}>{gt text='Only item titles'}</option>
        <option value="itemlist_display_description.tpl"{if $template eq 'itemlist_display_description.tpl'} selected="selected"{/if}>{gt text='With description'}</option>
    </select>
</div>
<div class="z-formrow" style="display: none">
    <label for="MediaRepository_filter">{gt text='Filter (expert option)'}:</label>
    <input type="text" id="MediaRepository_filter" name="filter" size="40" value="{$filterValue|default:""}" />
    <div class="z-formnote">({gt text='Syntax examples'}: <kbd>name:like:foobar</kbd> {gt text='or'} <kbd>status:ne:3</kbd>)</div>
</div>
