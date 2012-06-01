{* Purpose of this template: Display media within an external context *}
{foreach item='item' from=$items}
    <h3>{$item.title}</h3>
    <p><a href="{modurl modname='MediaRepository' type='user' func='display' ot='$objectType id=$item.id" slug=$item.slug}">{gt text='Read more'}</a>
    </p>
{/foreach}
