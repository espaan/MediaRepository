{* Purpose of this template: Display media handlers in html mailings *}
{*
<ul>
{foreach item='item' from=$items}
    <li>
        <a href="{modurl modname='MediaRepository' type='user' func='display' ot='$objectType id=$item.id" fqurl=true}
        ">{$item.title}
        </a>
    </li>
{foreachelse}
    <li>{gt text='No media handlers found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_MediaHandler_display_description.tpl'}
