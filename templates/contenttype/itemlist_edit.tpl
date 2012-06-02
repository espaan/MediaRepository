{* Purpose of this template: edit view of generic item list content type *}

<div class="z-formrow">
    {formlabel for='MediaRepository_objecttype' __text='Object type'}
    {mediarepositorySelectorObjectTypes assign='allObjectTypes'}
    {formdropdownlist id='MediaRepository_objecttype' dataField='objectType' group='data' mandatory=true items=$allObjectTypes}
</div>

<div class="z-formrow">
    {formlabel __text='Sorting'}
    <div>
        {formradiobutton id='MediaRepository_srandom' value='random' dataField='sorting' group='data' mandatory=true}
        {formlabel for='MediaRepository_srandom' __text='Random'}
        {formradiobutton id='MediaRepository_snewest' value='newest' dataField='sorting' group='data' mandatory=true}
        {formlabel for='MediaRepository_snewest' __text='Newest'}
        {formradiobutton id='MediaRepository_sdefault' value='default' dataField='sorting' group='data' mandatory=true}
        {formlabel for='MediaRepository_sdefault' __text='Default'}
    </div>
</div>

<div class="z-formrow">
    {formlabel for='MediaRepository_amount' __text='Amount'}
    {formtextinput id='MediaRepository_amount' dataField='amount' group='data' mandatory=true maxLength=2}
</div>

<div class="z-formrow">
    {formlabel for='MediaRepository_template' __text='Template File'}
    {mediarepositorySelectorTemplates assign='allTemplates'}
    {formdropdownlist id='MediaRepository_template' dataField='template' group='data' mandatory=true items=$allTemplates}
</div>

<div class="z-formrow" style="display: none">
    {formlabel for='MediaRepository_filter' __text='Filter (expert option)'}
    {formtextinput id='MediaRepository_filter' dataField='filter' group='data' mandatory=false maxLength=255}
    <div class="z-formnote">({gt text='Syntax examples'}: <kbd>name:like:foobar</kbd> {gt text='or'} <kbd>status:ne:3</kbd>)</div>
</div>
