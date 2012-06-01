{* Purpose of this template: Display thumb sizes in html mailings *}
{*
<ul>
{foreach item='item' from=$items}
    <li>
        <a href="{modurl modname='MediaRepository' type='user' func='display' ot='$objectType id=$item.id" fqurl=true}
        ">{$item.name}
        </a>
    </li>
{foreachelse}
    <li>{gt text='No thumb sizes found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_ThumbSize_display_description.tpl'}
