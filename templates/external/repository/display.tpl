{* Purpose of this template: Display one certain repository within an external context *}
<div id="repository{$repository.de.guite.modulestudio.metamodel.modulestudio.impl.IntegerFieldImpl@35a3f178 (name: id, documentation: null) (defaultValue: null, mandatory: true, nullable: false, leading: false, primaryKey: true, readonly: false, unique: true, translatable: false, sluggablePosition: 0, sortableGroup: false) (length: 9, sortablePosition: false) (minValue: 0, maxValue: 0, aggregateFor: , version: false)}" class="medrepexternalrepository">
{if $displayMode eq 'link'}
    <p class="medrepexternallink">
    <a href="{modurl modname='MediaRepository' type='user' func='display' ot='repository' id=$repository.id}" title="{$repository.name|replace:"\"":""}">
    {$repository.name|notifyfilters:'mediarepository.filter_hooks.repositories.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='MediaRepository::' instance='.*' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="medrepexternaltitle">
            <strong>{$repository.name|notifyfilters:'mediarepository.filter_hooks.repositories.filter'}</strong>
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
            {if $repository.name ne ''}{$repository.name}<br />{/if}
            {assignedcategorieslist categories=$repository.categories doctrine2=true}
        </p>
    *}
{/if}
</div>
