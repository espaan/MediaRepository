{* Purpose of this template: Display media handlers in text mailings *}
{foreach item='item' from=$items}
    {$item.title}
    {modurl modname='MediaRepository' type='user' func='display' ot='$objectType id=$item.id" fqurl=true}
    -----
{foreachelse}
    {gt text='No media handlers found.'}
{/foreach}
