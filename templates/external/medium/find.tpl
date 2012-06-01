{* Purpose of this template: Display a popup selector of media for scribite integration *}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{lang}" lang="{lang}">
<head>
    <title>{gt text='Search and select medium'}</title>
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
    <a href="{modurl modname='MediaRepository' type='external' func='finder' objectType='repository' editor=$editorName}" title="{gt text='Search and select repository'}">{gt text='Repositories'}</a> | 
    <a href="{modurl modname='MediaRepository' type='external' func='finder' objectType='mediaHandler' editor=$editorName}" title="{gt text='Search and select media handler'}">{gt text='Media handlers'}</a> | 
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
            <legend>{gt text='Search and select medium'}</legend>
            <div class="z-formrow">
                <label for="MediaRepository_cid">{gt text='Category'}:</label>
                {gt text='All' assign='lblDef'}
                {selector_category category=$mainCategory name='catid' field='id' defaultText=$lblDef editLink=false submit=true selectedValue=$catId}
            </div>

            <div class="z-formrow">
                <label for="MediaRepository_pasteas">{gt text='Paste as'}:</label>
                <select id="MediaRepository_pasteas" name="pasteas">
                    <option value="1">{gt text='Link to the medium'}</option>
                    <option value="2">{gt text='ID of medium'}</option>
                </select>
            </div>
            <br />

            <div class="z-formrow">
                <label for="MediaRepository_objectid">{gt text='Medium'}:</label>
                <div id="medrepitemcontainer">
                    <ul>
                    {foreach item='medium' from=$objectData}
                        <li>
                            <a href="#" onclick="mediarepository.finder.selectItem({$medium.id})" onkeypress="mediarepository.finder.selectItem({$medium.id})">
                                {$medium.title}
                            </a>
                            <input type="hidden" id="url{$medium.id}" value="{modurl modname='MediaRepository' type='user' func='display' ot='medium' id=$medium.id slug=$medium.slug fqurl=true}" />
                            <input type="hidden" id="title{$medium.id}" value="{$medium.title|replace:"\"":""}" />
                            <input type="hidden" id="desc{$medium.id}" value="{capture assign='description'}{if $medium.description ne ''}{$medium.description}{/if}
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
                <option value="owner"{if $sort eq 'owner'} selected="selected"{/if}>{gt text='Owner'}</option>
                <option value="title"{if $sort eq 'title'} selected="selected"{/if}>{gt text='Title'}</option>
                <option value="keywords"{if $sort eq 'keywords'} selected="selected"{/if}>{gt text='Keywords'}</option>
                <option value="description"{if $sort eq 'description'} selected="selected"{/if}>{gt text='Description'}</option>
                <option value="description2"{if $sort eq 'description2'} selected="selected"{/if}>{gt text='Description2'}</option>
                <option value="dateTaken"{if $sort eq 'dateTaken'} selected="selected"{/if}>{gt text='Date taken'}</option>
                <option value="placeTaken"{if $sort eq 'placeTaken'} selected="selected"{/if}>{gt text='Place taken'}</option>
                <option value="notes"{if $sort eq 'notes'} selected="selected"{/if}>{gt text='Notes'}</option>
                <option value="license"{if $sort eq 'license'} selected="selected"{/if}>{gt text='License'}</option>
                <option value="areamap"{if $sort eq 'areamap'} selected="selected"{/if}>{gt text='Areamap'}</option>
                <option value="showLocation"{if $sort eq 'showLocation'} selected="selected"{/if}>{gt text='Show location'}</option>
                <option value="latitude"{if $sort eq 'latitude'} selected="selected"{/if}>{gt text='Latitude'}</option>
                <option value="longitude"{if $sort eq 'longitude'} selected="selected"{/if}>{gt text='Longitude'}</option>
                <option value="zoomFactor"{if $sort eq 'zoomFactor'} selected="selected"{/if}>{gt text='Zoom factor'}</option>
                <option value="settings"{if $sort eq 'settings'} selected="selected"{/if}>{gt text='Settings'}</option>
                <option value="dlcount"{if $sort eq 'dlcount'} selected="selected"{/if}>{gt text='Dlcount'}</option>
                <option value="url"{if $sort eq 'url'} selected="selected"{/if}>{gt text='Url'}</option>
                <option value="mediaHandler"{if $sort eq 'mediaHandler'} selected="selected"{/if}>{gt text='Media handler'}</option>
                <option value="freeType"{if $sort eq 'freeType'} selected="selected"{/if}>{gt text='Free type'}</option>
                <option value="additions"{if $sort eq 'additions'} selected="selected"{/if}>{gt text='Additions'}</option>
                <option value="fileUpload"{if $sort eq 'fileUpload'} selected="selected"{/if}>{gt text='File upload'}</option>
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
