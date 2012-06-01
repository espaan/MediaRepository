{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="mediaHandler{$mediaHandler.de.guite.modulestudio.metamodel.modulestudio.impl.IntegerFieldImpl@1e4218cb (name: id, documentation: null) (defaultValue: null, mandatory: true, nullable: false, leading: false, primaryKey: true, readonly: false, unique: true, translatable: false, sluggablePosition: 0, sortableGroup: false) (length: 9, sortablePosition: false) (minValue: 0, maxValue: 0, aggregateFor: , version: false)}">
<dt>{$mediaHandler.title|notifyfilters:'mediarepository.filter_hooks.mediahandlers.filter'|htmlentities}</dt>
<dd>{if $mediaHandler.image ne ''}
  <a href="{$mediaHandler.imageFullPathURL}" title="{$mediaHandler.title|replace:"\"":""}"{if $mediaHandler.imageMeta.isImage} rel="imageviewer[mediahandler]"{/if}>
  {if $mediaHandler.imageMeta.isImage}
      <img src="{$mediaHandler.imageFullPath|mediarepositoryImageThumb:250:150}" width="250" height="150" alt="{$mediaHandler.title|replace:"\"":""}" />
  {else}
      {gt text='Download'} ({$mediaHandler.imageMeta.size|mediarepositoryGetFileSize:$mediaHandler.imageFullPath:false:false})
  {/if}
  </a>
{else}&nbsp;{/if}
</dd>
{if $mediaHandler.mimeType ne ''}<dd>{$mediaHandler.mimeType}</dd>{/if}
</dl>
