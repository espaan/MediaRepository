{* purpose of this template: show output of import action in admin area *}
{include file='admin/header.tpl'}
<div class="mediarepository-import mediarepository-import">
{gt text='Import' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-admin-content-pagetitle">
    {icon type='options' size='small' __alt='Import'}
    <h3>{$templateTitle}</h3>
</div>

<p>Please override this template by moving it from <em>/modules/MediaRepository/templates/admin/import.tpl</em> to either your <em>/themes/YourTheme/templates/modules/MediaRepository/admin/import.tpl</em> or <em>/config/templates/MediaRepository/admin/import.tpl</em>.</p>

</div>
{include file='admin/footer.tpl'}
