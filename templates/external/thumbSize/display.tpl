{* Purpose of this template: Display one certain thumb size within an external context *}
<div id="thumbSize{$thumbSize.de.guite.modulestudio.metamodel.modulestudio.impl.IntegerFieldImpl@2aaf914c (name: id, documentation: null) (defaultValue: null, mandatory: true, nullable: false, leading: false, primaryKey: true, readonly: false, unique: true, translatable: false, sluggablePosition: 0, sortableGroup: false) (length: 9, sortablePosition: false) (minValue: 0, maxValue: 0, aggregateFor: , version: false)}" class="medrepexternalthumbsize">
{if $displayMode eq 'link'}
    <p class="medrepexternallink">
    <a href="{modurl modname='MediaRepository' type='user' func='display' ot='thumbSize' id=$thumbSize.id}" title="{$thumbSize.name|replace:"\"":""}">
    {$thumbSize.name|notifyfilters:'mediarepository.filter_hooks.thumbsizes.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='MediaRepository::' instance='.*' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="medrepexternaltitle">
            <strong>{$thumbSize.name|notifyfilters:'mediarepository.filter_hooks.thumbsizes.filter'}</strong>
        </p>
    {/if}
{/checkpermissionblock}

{if $displayMode eq 'link'}
{elseif $displayMode eq 'embed'}
    <div class="medrepexternalsnippet">
        &nbsp;
    </div>

    {*if $source eq 'contentType'}
        ...
    {elseif $source eq 'scribite'}
        ...
    {/if*}
    {*
        <p class="medrepexternaldesc">
            {if $thumbSize.name ne ''}{$thumbSize.name}<br />{/if}
        </p>
    *}
{/if}
</div>
