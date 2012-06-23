{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="medium{$medium.de.guite.modulestudio.metamodel.modulestudio.impl.IntegerFieldImpl@ba3bc8c (name: id, documentation: null) (defaultValue: null, mandatory: true, nullable: false, leading: false, primaryKey: true, readonly: false, unique: true, translatable: false, sluggablePosition: 0, sortableGroup: false) (length: 9, sortablePosition: false) (minValue: 0, maxValue: 0, aggregateFor: , version: false)}">
<dt>{$medium.title|notifyfilters:'mediarepository.filter_hooks.media.filter'|htmlentities}</dt>
<dd>  <a href="{$medium.fileUploadFullPathURL}" title="{$medium.title|replace:"\"":""}"{if $medium.fileUploadMeta.isImage} rel="imageviewer[medium]"{/if}>
  {if $medium.fileUploadMeta.isImage}
      <img src="{$medium.fileUploadFullPath|mediarepositoryImageThumb:250:150}" width="250" height="150" alt="{$medium.title|replace:"\"":""}" />
  {else}
      {gt text='Download'} ({$medium.fileUploadMeta.size|mediarepositoryGetFileSize:$medium.fileUploadFullPath:false:false})
  {/if}
  </a>
</dd>
{if $medium.description ne ''}<dd>{$medium.description}</dd>{/if}
<dd>{assignedcategorieslist categories=$medium.categories doctrine2=true}</dd>
</dl>
