{* purpose of this template: inclusion template for display of related Repositories in admin area *}
{if !isset($nolink)}
    {assign var='nolink' value=false}
{/if}
{if isset($items) && $items ne null}
<ul class="relatedItemList repository">
{foreach name='relLoop' item='item' from=$items}
    <li>
{if !$nolink}
    <a href="{modurl modname='MediaRepository' type='admin' func='display' ot='repository' id=$item.id}" title="{$item.name|replace:"\"":""}">
{/if}
{$item.name}
{if !$nolink}
    </a>
    <a id="repositoryItem{$item.id}Display" href="{modurl modname='MediaRepository' type='admin' func='display' ot='repository' id=$item.id theme='Printer'}" title="{gt text='Open quick view window'}" style="display: none">
        {icon type='view' size='extrasmall' __alt='Quick view'}
    </a>
{/if}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        medrepInitInlineWindow($('repositoryItem{{$item.id}}Display'), '{{$item.name|replace:"'":""}}');
    });
/* ]]> */
</script>
    </li>
{/foreach}
</ul>
{/if}
