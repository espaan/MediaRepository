{* Purpose of this template: Display thumb sizes in text mailings *}
{foreach item='item' from=$items}
    {$item.name}
    {modurl modname='MediaRepository' type='user' func='display' ot='$objectType id=$item.id" fqurl=true}
    -----
{foreachelse}
    {gt text='No thumb sizes found.'}
{/foreach}
