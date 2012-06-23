{* Purpose of this template: Display a popup selector of repositories for scribite integration *}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{lang}" lang="{lang}">
<head>
    <title>{gt text='Search and select repository'}</title>
    <link type="text/css" rel="stylesheet" href="{$baseurl}style/core.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/MediaRepository/style/style.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/MediaRepository/style/finder.css" />
    {assign var='ourEntry' value=$modvars.ZConfig.entrypoint}
    <script type="text/javascript">/* <![CDATA[ */
        if (typeof(Zikula) == 'undefined') {var Zikula = {};}
        Zikula.Config = {'entrypoint': '{{$ourEntry|default:'index.php'}}', 'baseURL': '{{$baseurl}}'}; /* ]]> */</script>
    <script type="text/javascript" src="{$baseurl}javascript/ajax/original_uncompressed/prototype.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/ajax/original_uncompressed/scriptaculous.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/ajax/original_uncompressed/dragdrop.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/ajax/original_uncompressed/effects.js"></script>
    <script type="text/javascript" src="{$baseurl}modules/MediaRepository/javascript/MediaRepository_finder.js"></script>
{if $editorName eq 'tinymce'}
    <script type="text/javascript" src="{$baseurl}modules/Scribite/includes/tinymce/tiny_mce_popup.js"></script>
{/if}
</head>
<body>
    <p>{gt text='Switch to'}:
    <a href="{modurl modname='MediaRepository' type='external' func='finder' objectType='mediaHandler' editor=$editorName}" title="{gt text='Search and select media handler'}">{gt text='Media handlers'}</a> | 
    <a href="{modurl modname='MediaRepository' type='external' func='finder' objectType='medium' editor=$editorName}" title="{gt text='Search and select medium'}">{gt text='Media'}</a> | 
    <a href="{modurl modname='MediaRepository' type='external' func='finder' objectType='thumbSize' editor=$editorName}" title="{gt text='Search and select thumb size'}">{gt text='Thumb sizes'}</a>
    </p>
    <form action="{$ourEntry|default:'index.php'}" id="selectorForm" method="get" class="z-form">
    <div>
        <input type="hidden" name="module" value="MediaRepository" />
        <input type="hidden" name="type" value="external" />
        <input type="hidden" name="func" value="finder" />
        <input type="hidden" name="objectType" value="{$objectType}" />
        <input type="hidden" name="editor" id="editorName" value="{$editorName}" />

        <fieldset>
            <legend>{gt text='Search and select repository'}</legend>
            <div class="z-formrow">
                <label for="MediaRepository_cid">{gt text='Category'}:</label>
                {gt text='All' assign='lblDef'}
                {selector_category category=$mainCategory name='catid' field='id' defaultText=$lblDef editLink=false submit=true selectedValue=$catId}
            </div>

            <div class="z-formrow">
                <label for="MediaRepository_pasteas">{gt text='Paste as'}:</label>
                <select id="MediaRepository_pasteas" name="pasteas">
                    <option value="1">{gt text='Link to the repository'}</option>
                    <option value="2">{gt text='ID of repository'}</option>
                </select>
            </div>
            <br />

            <div class="z-formrow">
                <label for="MediaRepository_objectid">{gt text='Repository'}:</label>
                <div id="medrepitemcontainer">
                    <ul>
                    {foreach item='repository' from=$objectData}
                        <li>
                            <a href="#" onclick="mediarepository.finder.selectItem({$repository.id})" onkeypress="mediarepository.finder.selectItem({$repository.id})">
                                {$repository.name}
                            </a>
                            <input type="hidden" id="url{$repository.id}" value="{modurl modname='MediaRepository' type='user' func='display' ot='repository' id=$repository.id fqurl=true}" />
                            <input type="hidden" id="title{$repository.id}" value="{$repository.name|replace:"\"":""}" />
                            <input type="hidden" id="desc{$repository.id}" value="{capture assign='description'}{if $repository.name ne ''}{$repository.name}{/if}
                            {/capture}{$description|strip_tags|replace:"\"":""}" />
                        </li>
                    {foreachelse}
                        <li>{gt text='No entries found.'}</li>
                    {/foreach}
                    </ul>
                </div>
            </div>

            <div class="z-formrow">
                <label for="MediaRepository_sort">{gt text='Sort by'}:</label>
                <select id="MediaRepository_sort" name="sort" style="width: 150px" class="z-floatleft" style="margin-right: 10px">
                <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
                <option value="name"{if $sort eq 'name'} selected="selected"{/if}>{gt text='Name'}</option>
                <option value="workDirectory"{if $sort eq 'workDirectory'} selected="selected"{/if}>{gt text='Work directory'}</option>
                <option value="storageDirectory"{if $sort eq 'storageDirectory'} selected="selected"{/if}>{gt text='Storage directory'}</option>
                <option value="cacheDirectory"{if $sort eq 'cacheDirectory'} selected="selected"{/if}>{gt text='Cache directory'}</option>
                <option value="storageMode"{if $sort eq 'storageMode'} selected="selected"{/if}>{gt text='Storage mode'}</option>
                <option value="permissionScope"{if $sort eq 'permissionScope'} selected="selected"{/if}>{gt text='Permission scope'}</option>
                <option value="useQuota"{if $sort eq 'useQuota'} selected="selected"{/if}>{gt text='Use quota'}</option>
                <option value="allowManagementOfOwnFiles"{if $sort eq 'allowManagementOfOwnFiles'} selected="selected"{/if}>{gt text='Allow management of own files'}</option>
                <option value="allowFileMailing"{if $sort eq 'allowFileMailing'} selected="selected"{/if}>{gt text='Allow file mailing'}</option>
                <option value="maxSizeForMail"{if $sort eq 'maxSizeForMail'} selected="selected"{/if}>{gt text='Max size for mail'}</option>
                <option value="maxFilesPerUpload"{if $sort eq 'maxFilesPerUpload'} selected="selected"{/if}>{gt text='Max files per upload'}</option>
                <option value="maxUploadFileSize"{if $sort eq 'maxUploadFileSize'} selected="selected"{/if}>{gt text='Max upload file size'}</option>
                <option value="uploadNamingConvention"{if $sort eq 'uploadNamingConvention'} selected="selected"{/if}>{gt text='Upload naming convention'}</option>
                <option value="uploadNamingPrefix"{if $sort eq 'uploadNamingPrefix'} selected="selected"{/if}>{gt text='Upload naming prefix'}</option>
                <option value="enableSharpen"{if $sort eq 'enableSharpen'} selected="selected"{/if}>{gt text='Enable sharpen'}</option>
                <option value="enableShrinking"{if $sort eq 'enableShrinking'} selected="selected"{/if}>{gt text='Enable shrinking'}</option>
                <option value="shrinkDimensions"{if $sort eq 'shrinkDimensions'} selected="selected"{/if}>{gt text='Shrink dimensions'}</option>
                <option value="useThumbCropper"{if $sort eq 'useThumbCropper'} selected="selected"{/if}>{gt text='Use thumb cropper'}</option>
                <option value="cropSizeMode"{if $sort eq 'cropSizeMode'} selected="selected"{/if}>{gt text='Crop size mode'}</option>
                <option value="downloadMode"{if $sort eq 'downloadMode'} selected="selected"{/if}>{gt text='Download mode'}</option>
                <option value="sendMailAfterUpload"{if $sort eq 'sendMailAfterUpload'} selected="selected"{/if}>{gt text='Send mail after upload'}</option>
                <option value="mailRecipient"{if $sort eq 'mailRecipient'} selected="selected"{/if}>{gt text='Mail recipient'}</option>
                <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
                <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
                <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
                </select>
                <select id="MediaRepository_sortdir" name="sortdir" style="width: 100px">
                    <option value="asc"{if $sortdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
                    <option value="desc"{if $sortdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
                </select>
            </div>

            <div class="z-formrow">
                <label for="MediaRepository_pagesize">{gt text='Page size'}:</label>
                <select id="MediaRepository_pagesize" name="num" style="width: 50px; text-align: right">
                    <option value="5"{if $pager.itemsperpage eq 5} selected="selected"{/if}>5</option>
                    <option value="10"{if $pager.itemsperpage eq 10} selected="selected"{/if}>10</option>
                    <option value="15"{if $pager.itemsperpage eq 15} selected="selected"{/if}>15</option>
                    <option value="20"{if $pager.itemsperpage eq 20} selected="selected"{/if}>20</option>
                    <option value="30"{if $pager.itemsperpage eq 30} selected="selected"{/if}>30</option>
                    <option value="50"{if $pager.itemsperpage eq 50} selected="selected"{/if}>50</option>
                    <option value="100"{if $pager.itemsperpage eq 100} selected="selected"{/if}>100</option>
                </select>
            </div>

            <div class="z-formrow">
                <label for="MediaRepository_searchterm">{gt text='Search for'}:</label>
                <input type="text" id="MediaRepository_searchterm" name="searchterm" style="width: 150px" class="z-floatleft" style="margin-right: 10px" />
                <input type="button" id="MediaRepository_gosearch" name="gosearch" value="{gt text='Filter'}" style="width: 80px" />
            </div>

            <div style="margin-left: 6em">
                {pager display='page' rowcount=$pager.numitems limit=$pager.itemsperpage posvar='pos' template='pagercss.tpl' maxpages='10'}
            </div>
            <input type="submit" id="MediaRepository_submit" name="submitButton" value="{gt text='Change selection'}" />
            <input type="button" id="MediaRepository_cancel" name="cancelButton" value="{gt text='Cancel'}" />
            <br />
        </fieldset>
    </div>
    </form>

    <script type="text/javascript">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            mediarepository.finder.onLoad();
        });
    /* ]]> */
    </script>

    {*
    <div class="medrepform">
        <fieldset>
            {modfunc modname='MediaRepository' type='admin' func='edit'}
        </fieldset>
    </div>
    *}
</body>
</html>
