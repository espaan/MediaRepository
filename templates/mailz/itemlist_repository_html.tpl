{* Purpose of this template: Display repositories in html mailings *}
{*
<ul>
{foreach item='item' from=$items}
    <li>
        <a href="{modurl modname='MediaRepository' type='user' func='display' ot='$objectType id=$item.id" fqurl=true}
        ">{$item.name}
        </a>
    </li>
{foreachelse}
    <li>{gt text='No repositories found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_Repository_display_description.tpl'}
