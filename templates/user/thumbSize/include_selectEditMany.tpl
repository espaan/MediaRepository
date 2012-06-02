{* purpose of this template: inclusion template for managing related Thumb sizes in user area *}
{if isset($panel) && $panel eq true}
    <h3 class="thumbsizes z-panel-header z-panel-indicator z-pointer">{gt text='Thumb sizes'}</h3>
    <fieldset class="thumbsizes z-panel-content" style="display: none">
{else}
    <fieldset class="thumbsizes">
{/if}
    <legend>{gt text='Thumb sizes'}</legend>
    <div class="z-formrow">
        <div class="medrepRelationRightSide">
            <a id="{$idPrefix}AddLink" href="javascript:void(0);" style="display: none">{gt text='Add thumb size'}</a>
            <div id="{$idPrefix}AddFields">
                <label for="{$idPrefix}Selector">{gt text='Find thumb size'}</label>
                <br />
                {icon type='search' size='extrasmall' __alt='Search thumb size'}
                <input type="text" name="{$idPrefix}Selector" id="{$idPrefix}Selector" value="" />
                <input type="hidden" name="{$idPrefix}Scope" id="{$idPrefix}Scope" value="1" />
                {img src='indicator_circle.gif' modname='core' set='ajax' alt='' id="`$idPrefix`Indicator" style='display: none'}
                <div id="{$idPrefix}SelectorChoices" class="medrepAutoComplete"></div>
                <input type="button" id="{$idPrefix}SelectorDoCancel" name="{$idPrefix}SelectorDoCancel" value="{gt text='Cancel'}" class="z-button medrepInlineButton" />
                <a id="{$idPrefix}SelectorDoNew" href="{modurl modname='MediaRepository' type='user' func='edit' ot='thumbSize' forcelongurl=true}" title="{gt text='Create new thumb size'}" class="z-button medrepInlineButton">{gt text='Create'}</a>
            </div>
            <noscript><p>{gt text='This function requires JavaScript activated!'}</p></noscript>
        </div>
        <div class="medrepRelationLeftSide">
            {if isset($userSelection.$aliasName) && $userSelection.$aliasName ne ''}
                {* the user has submitted something *}
                {include file='user/thumbSize/include_selectEditItemListMany.tpl'  items=$userSelection.$aliasName}
            {elseif $mode ne 'create' || isset($relItem.$aliasName)}
                {include file='user/thumbSize/include_selectEditItemListMany.tpl'  items=$relItem.$aliasName}
            {else}
                {include file='user/thumbSize/include_selectEditItemListMany.tpl' }
            {/if}
        </div>
        <br style="clear: both" />
    </div>
</fieldset>
