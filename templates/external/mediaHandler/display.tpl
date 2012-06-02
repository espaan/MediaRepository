{* Purpose of this template: Display one certain media handler within an external context *}
<div id="mediaHandler{$mediaHandler.de.guite.modulestudio.metamodel.modulestudio.impl.IntegerFieldImpl@1e4218cb (name: id, documentation: null) (defaultValue: null, mandatory: true, nullable: false, leading: false, primaryKey: true, readonly: false, unique: true, translatable: false, sluggablePosition: 0, sortableGroup: false) (length: 9, sortablePosition: false) (minValue: 0, maxValue: 0, aggregateFor: , version: false)}" class="medrepexternalmediahandler">
{if $displayMode eq 'link'}
    <p class="medrepexternallink">
    <a href="{modurl modname='MediaRepository' type='user' func='display' ot='mediaHandler' id=$mediaHandler.id}" title="{$mediaHandler.title|replace:"\"":""}">
    {$mediaHandler.title|notifyfilters:'mediarepository.filter_hooks.mediahandlers.filter'}
    </a>
    </p>
{/if}
{checkpermissionblock component='MediaRepository::' instance='.*' level='ACCESS_EDIT'}
    {if $displayMode eq 'embed'}
        <p class="medrepexternaltitle">
            <strong>{$mediaHandler.title|notifyfilters:'mediarepository.filter_hooks.mediahandlers.filter'}</strong>
        </p>
    {/if}
{/checkpermissionblock}

{if $displayMode eq 'link'}
{elseif $displayMode eq 'embed'}
    <div class="medrepexternalsnippet">
        {if $mediaHandler.image ne ''}
          <a href="{$mediaHandler.imageFullPathURL}" title="{$mediaHandler.title|replace:"\"":""}"{if $mediaHandler.imageMeta.isImage} rel="imageviewer[mediahandler]"{/if}>
          {if $mediaHandler.imageMeta.isImage}
              <img src="{$mediaHandler.imageFullPath|mediarepositoryImageThumb:250:150}" width="250" height="150" alt="{$mediaHandler.title|replace:"\"":""}" />
          {else}
              {gt text='Download'} ({$mediaHandler.imageMeta.size|mediarepositoryGetFileSize:$mediaHandler.imageFullPath:false:false})
          {/if}
          </a>
        {else}&nbsp;{/if}
    </div>

    {*if $source eq 'contentType'}
        ...
    {elseif $source eq 'scribite'}
        ...
    {/if*}
    {*
        <p class="medrepexternaldesc">
            {if $mediaHandler.mimeType ne ''}{$mediaHandler.mimeType}<br />{/if}
        </p>
    *}
{/if}
</div>
