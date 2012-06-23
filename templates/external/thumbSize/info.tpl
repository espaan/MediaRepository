{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="thumbSize{$thumbSize.de.guite.modulestudio.metamodel.modulestudio.impl.IntegerFieldImpl@2aaf914c (name: id, documentation: null) (defaultValue: null, mandatory: true, nullable: false, leading: false, primaryKey: true, readonly: false, unique: true, translatable: false, sluggablePosition: 0, sortableGroup: false) (length: 9, sortablePosition: false) (minValue: 0, maxValue: 0, aggregateFor: , version: false)}">
<dt>{$thumbSize.name|notifyfilters:'mediarepository.filter_hooks.thumbsizes.filter'|htmlentities}</dt>
{if $thumbSize.name ne ''}<dd>{$thumbSize.name}</dd>{/if}
</dl>
