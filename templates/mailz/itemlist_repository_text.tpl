{* Purpose of this template: Display repositories in text mailings *}
{foreach item='item' from=$items}
    {$item.name}
    {modurl modname='MediaRepository' type='user' func='display' ot='$objectType id=$item.id" fqurl=true}
    -----
{foreachelse}
    {gt text='No repositories found.'}
{/foreach}
