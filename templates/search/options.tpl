{* Purpose of this template: Display search options *}
<input type="hidden" id="active_mediarepository" name="active[MediaRepository]" value="1" checked="checked" />
<div>
    <input type="checkbox" id="active_mediarepository_repositories" name="search_mediarepository_types['repository']" value="1"{if $active_repository} checked="checked"{/if} />
    <label for="active_mediarepository_repositories">{gt text='Repositories' domain='module_mediarepository'}</label>
</div>
<div>
    <input type="checkbox" id="active_mediarepository_mediahandlers" name="search_mediarepository_types['mediaHandler']" value="1"{if $active_mediaHandler} checked="checked"{/if} />
    <label for="active_mediarepository_mediahandlers">{gt text='Media handlers' domain='module_mediarepository'}</label>
</div>
<div>
    <input type="checkbox" id="active_mediarepository_media" name="search_mediarepository_types['medium']" value="1"{if $active_medium} checked="checked"{/if} />
    <label for="active_mediarepository_media">{gt text='Media' domain='module_mediarepository'}</label>
</div>
<div>
    <input type="checkbox" id="active_mediarepository_thumbsizes" name="search_mediarepository_types['thumbSize']" value="1"{if $active_thumbSize} checked="checked"{/if} />
    <label for="active_mediarepository_thumbsizes">{gt text='Thumb sizes' domain='module_mediarepository'}</label>
</div>
