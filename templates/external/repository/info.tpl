{* Purpose of this template: Display item information for previewing from other modules *}
<dl id="repository{$repository.de.guite.modulestudio.metamodel.modulestudio.impl.IntegerFieldImpl@2206179e (name: id, documentation: null) (defaultValue: null, mandatory: true, nullable: false, leading: false, primaryKey: true, readonly: false, unique: true, translatable: false, sluggablePosition: 0, sortableGroup: false) (length: 9, sortablePosition: false) (minValue: 0, maxValue: 0, aggregateFor: , version: false)}">
<dt>{$repository.name|notifyfilters:'mediarepository.filter_hooks.repositories.filter'|htmlentities}</dt>
{if $repository.name ne ''}<dd>{$repository.name}</dd>{/if}
<dd>{assignedcategorieslist categories=$repository.categories doctrine2=true}</dd>
</dl>
