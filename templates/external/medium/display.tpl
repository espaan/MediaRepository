{* Purpose of this template: Display one certain medium within an external context *}
<div id="medium{$medium.de.guite.modulestudio.metamodel.modulestudio.impl.IntegerFieldImpl@569c6f2 (name: id, documentation: null) (defaultValue: null, mandatory: true, nullable: false, leading: false, primaryKey: true, readonly: false, unique: true, translatable: false, sluggablePosition: 0, sortableGroup: false) (length: 9, sortablePosition: false) (minValue: 0, maxValue: 0, aggregateFor: , version: false)}" class="medrepexternalmedium">
{if $displayMode eq 'link'}
    <p class="medrepexternallink">
    <a href="{modurl modname='MediaRepository' type='user' func='display' ot='medium' id=$medium.id slug=$medium.slug}" title="{$medium.title|replace:"\"":""}">
    {$medium.title|notifyfilters:'mediarepository.filter_hooks.media.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='MediaRepository::' instance='.*' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="medrepexternaltitle">
            <strong>{$medium.title|notifyfilters:'mediarepository.filter_hooks.media.filter'}</strong>
        </p>
    {/if}
{/checkpermissionblock}

{if $displayMode eq 'link'}
{elseif $displayMode eq 'embed'}
    <div class="medrepexternalsnippet">
          <a href="{$medium.fileUploadFullPathURL}" title="{$medium.title|replace:"\"":""}"{if $medium.fileUploadMeta.isImage} rel="imageviewer[medium]"{/if}>
          {if $medium.fileUploadMeta.isImage}
              <img src="{$medium.fileUploadFullPath|mediarepositoryImageThumb:250:150}" width="250" height="150" alt="{$medium.title|replace:"\"":""}" />
          {else}
              {gt text='Download'} ({$medium.fileUploadMeta.size|mediarepositoryGetFileSize:$medium.fileUploadFullPath:false:false})
          {/if}
          </a>
    </div>

    {*if $source eq 'contentType'}
        ...
    {elseif $source eq 'scribite'}
        ...
    {/if*}
    {*
        <p class="medrepexternaldesc">
            {if $medium.description ne ''}{$medium.description}<br />{/if}
            {assignedcategorieslist categories=$medium.categories doctrine2=true}
        </p>
    *}
{/if}
</div>
