{* purpose of this template: inclusion template for display of related Media in admin area *}
{if !isset($nolink)}
    {assign var='nolink' value=false}
{/if}
{if isset($items) && $items ne null}
<ul class="relatedItemList medium">
{foreach name='relLoop' item='item' from=$items}
    <li>
{if !$nolink}
    <a href="{modurl modname='MediaRepository' type='admin' func='display' ot='medium' id=$item.id slug=$item.slug}" title="{$item.title|replace:"\"":""}">
{/if}
{$item.title}
{if !$nolink}
    </a>
    <a id="mediumItem{$item.id}Display" href="{modurl modname='MediaRepository' type='admin' func='display' ot='medium' id=$item.id slug=$item.slug theme='Printer'}" title="{gt text='Open quick view window'}" style="display: none">
        {icon type='view' size='extrasmall' __alt='Quick view'}
    </a>
{/if}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        medrepInitInlineWindow($('mediumItem{{$item.id}}Display'), '{{$item.title|replace:"'":""}}');
    });
/* ]]> */
</script>
<br />
{if $item.fileUpload ne '' && isset($item.fileUploadFullPath)}
    <img src="{$item.fileUploadFullPath|mediarepositoryImageThumb:50:40}" width="50" height="40" alt="{$item.title|replace:"\"":""}" />
{/if}
    </li>
{/foreach}
</ul>
{/if}
