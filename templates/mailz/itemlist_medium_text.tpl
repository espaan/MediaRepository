{* Purpose of this template: Display media in text mailings *}
{foreach item='item' from=$items}
    {$item.title}
    {modurl modname='MediaRepository' type='user' func='display' ot='$objectType id=$item.id" slug=$item.slug fqurl=true}
    -----
{foreachelse}
    {gt text='No media found.'}
{/foreach}
