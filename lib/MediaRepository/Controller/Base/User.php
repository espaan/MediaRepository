<?php
/**
 * MediaRepository.
 *
 * @copyright Axel Guckelsberger
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package MediaRepository
 * @author Axel Guckelsberger <info@guite.de>.
 * @link http://zikula.de
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.5.5 (http://modulestudio.de) at Wed May 30 16:44:53 CEST 2012.
 */

/**
 * User controller class.
 */
class MediaRepository_Controller_Base_User extends Zikula_AbstractController
{
    /**
     * Post initialise.
     *
     * Run after construction.
     *
     * @return void
     */
    protected function postInitialize()
    {
        // Set caching to true by default.
        $this->view->setCaching(Zikula_View::CACHE_ENABLED);
    }

    /**
     * This method is the default function handling the user area called without defining arguments.
     *
     * @param array $args List of arguments.
     *
     * @return mixed Output.
     */
    public function main($args)
    {
        $this->throwForbiddenUnless(SecurityUtil::checkPermission($this->name . '::', '::', ACCESS_OVERVIEW), LogUtil::getErrorMsgPermission());
        // set caching id
        $this->view->setCacheId('main');
        
        // return main template
        return $this->view->fetch('user/main.tpl');
    }
    
    /**
     * This method provides a generic item list overview.
     *
     * @param array $args List of arguments.
     * @param string  $ot           Treated object type.
     * @param string  $sort         Sorting field.
     * @param string  $sortdir      Sorting direction.
     * @param int     $pos          Current pager position.
     * @param int     $num          Amount of entries to display.
     * @param string  $tpl          Name of alternative template (for alternative display options, feeds and xml output)
     * @param boolean $raw          Optional way to display a template instead of fetching it (needed for standalone output)
     *
     * @return mixed Output.
     */
    public function view($args)
    {
        // parameter specifying which type of objects we are treating
        $objectType = (isset($args['ot']) && !empty($args['ot'])) ? $args['ot'] : $this->request->query->filter('ot', 'medium', FILTER_SANITIZE_STRING);
        $utilArgs = array('controller' => 'user', 'action' => 'view');
        if (!in_array($objectType, MediaRepository_Util_Controller::getObjectTypes('controllerAction', $utilArgs))) {
            $objectType = MediaRepository_Util_Controller::getDefaultObjectType('controllerAction', $utilArgs);
        }
        $this->throwForbiddenUnless(SecurityUtil::checkPermission($this->name . ':' . ucwords($objectType) . ':', '::', ACCESS_READ), LogUtil::getErrorMsgPermission());
        $repository = $this->entityManager->getRepository($this->name . '_Entity_' . ucfirst($objectType));
        
        // parameter for used sorting field
        $sort = (isset($args['sort']) && !empty($args['sort'])) ? $args['sort'] : $this->request->query->filter('sort', '', FILTER_SANITIZE_STRING);
        if (empty($sort) || !in_array($sort, $repository->getAllowedSortingFields())) {
            $sort = $repository->getDefaultSortingField();
        }
        
        // parameter for used sort order
        $sdir = (isset($args['sortdir']) && !empty($args['sortdir'])) ? $args['sortdir'] : $this->request->query->filter('sortdir', '', FILTER_SANITIZE_STRING);
        $sdir = strtolower($sdir);
        if ($sdir != 'asc' && $sdir != 'desc') {
            $sdir = 'asc';
        }
        
        // convenience vars to make code clearer
        $currentUrlArgs = array('ot' => $objectType);
        
        $selectionArgs = array(
            'ot' => $objectType,
            'where' => '',
            'orderBy' => $sort . ' ' . $sdir
        );
        
        $showOwnEntries = (int) (isset($args['own']) && !empty($args['own'])) ? $args['own'] : $this->request->query->filter('own', 0, FILTER_VALIDATE_INT);
        $showAllEntries = (int) (isset($args['all']) && !empty($args['all'])) ? $args['all'] : $this->request->query->filter('all', 0, FILTER_VALIDATE_INT);
        
        $this->view->assign('showOwnEntries', $showOwnEntries)
                   ->assign('showAllEntries', $showAllEntries);
        if ($showOwnEntries == 1) {
            $currentUrlArgs['own'] = 1;
        }
        if ($showAllEntries == 1) {
            $currentUrlArgs['all'] = 1;
        }
        
        // prepare access level for cache id
        $accessLevel = ACCESS_READ;
        $component = 'MediaRepository:' . ucwords($this->objectType) . ':';
        $instance = '::';
        if (SecurityUtil::checkPermission($component, $instance, ACCESS_COMMENT)) $accessLevel = ACCESS_COMMENT;
        if (SecurityUtil::checkPermission($component, $instance, ACCESS_EDIT)) $accessLevel = ACCESS_EDIT;
        
        $templateFile = MediaRepository_Util_View::getViewTemplate($this->view, 'user', $objectType, 'view', $args);
        $cacheId = 'view|ot_' . $this->objectType . '_sort_' . $sort . '_' . $sdir;
        
        if ($showAllEntries == 1) {
            // set cache id
            $this->view->setCacheId($cacheId . '_all_1_own_' . $showOwnEntries . '_' . $accessLevel);
        
            // if page is cached return cached content
            if ($this->view->is_cached($templateFile)) {
                return MediaRepository_Util_View::processTemplate($this->view, 'user', $objectType, 'view', $args, $templateFile);
            }
        
            // retrieve item list without pagination
            $entities = ModUtil::apiFunc($this->name, 'selection', 'getEntities', $selectionArgs);
        } else {
            // the current offset which is used to calculate the pagination
            $currentPage = (int) (isset($args['pos']) && !empty($args['pos'])) ? $args['pos'] : $this->request->query->filter('pos', 1, FILTER_VALIDATE_INT);
        
            // the number of items displayed on a page for pagination
            $resultsPerPage = (int) (isset($args['num']) && !empty($args['num'])) ? $args['num'] : $this->request->query->filter('num', 0, FILTER_VALIDATE_INT);
            if ($resultsPerPage == 0) {
                $csv = (int) (isset($args['usecsv']) && !empty($args['usecsv'])) ? $args['usecsv'] : $this->request->query->filter('usecsvext', 0, FILTER_VALIDATE_INT);
                $resultsPerPage = ($csv == 1) ? 999999 : $this->getVar('pageSize', 10);
            }
        
            // set cache id
            $this->view->setCacheId($cacheId . '_amount_' . $resultsPerPage . '_page_' . $currentPage . '_own_' . $showOwnEntries . '_' . $accessLevel);
        
            // if page is cached return cached content
            if ($this->view->is_cached($templateFile)) {
                return MediaRepository_Util_View::processTemplate($this->view, 'user', $objectType, 'view', $args, $templateFile);
            }
        
            // retrieve item list with pagination
            $selectionArgs['currentPage'] = $currentPage;
            $selectionArgs['resultsPerPage'] = $resultsPerPage;
            list($entities, $objectCount) = ModUtil::apiFunc($this->name, 'selection', 'getEntitiesPaginated', $selectionArgs);
        
            $this->view->assign('currentPage', $currentPage)
                       ->assign('pager', array('numitems'     => $objectCount,
                                               'itemsperpage' => $resultsPerPage));
        }
        
        // build ModUrl instance for display hooks
        $currentUrlObject = new Zikula_ModUrl($this->name, 'user', 'view', ZLanguage::getLanguageCode(), $currentUrlArgs);
        
        // assign the object data, sorting information and details for creating the pager
        $this->view->assign('items', $entities)
                   ->assign('sort', $sort)
                   ->assign('sdir', $sdir)
                   ->assign('currentUrlObject', $currentUrlObject)
                   ->assign($repository->getAdditionalTemplateParameters('controllerAction', $utilArgs));
        
        // fetch and return the appropriate template
        return MediaRepository_Util_View::processTemplate($this->view, 'user', $objectType, 'view', $args, $templateFile);
    }
    
    /**
     * This method provides a generic item detail view.
     *
     * @param array $args List of arguments.
     * @param string  $ot           Treated object type.
     * @param string  $tpl          Name of alternative template (for alternative display options, feeds and xml output)
     * @param boolean $raw          Optional way to display a template instead of fetching it (needed for standalone output)
     *
     * @return mixed Output.
     */
    public function display($args)
    {
        // parameter specifying which type of objects we are treating
        $objectType = (isset($args['ot']) && !empty($args['ot'])) ? $args['ot'] : $this->request->query->filter('ot', 'medium', FILTER_SANITIZE_STRING);
        $utilArgs = array('controller' => 'user', 'action' => 'display');
        if (!in_array($objectType, MediaRepository_Util_Controller::getObjectTypes('controllerAction', $utilArgs))) {
            $objectType = MediaRepository_Util_Controller::getDefaultObjectType('controllerAction', $utilArgs);
        }
        $this->throwForbiddenUnless(SecurityUtil::checkPermission($this->name . ':' . ucwords($objectType) . ':', '::', ACCESS_READ), LogUtil::getErrorMsgPermission());
        $repository = $this->entityManager->getRepository($this->name . '_Entity_' . ucfirst($objectType));
        
        $idFields = ModUtil::apiFunc($this->name, 'selection', 'getIdFields', array('ot' => $objectType));
        
        // retrieve identifier of the object we wish to view
        $idValues = MediaRepository_Util_Controller::retrieveIdentifier($this->request, $args, $objectType, $idFields);
        $hasIdentifier = MediaRepository_Util_Controller::isValidIdentifier($idValues);
        
        // check for unique permalinks (without id)
        $hasSlug = false;
        $slug = '';
        if ($hasIdentifier === false) {
            $entityClass = $this->name . '_Entity_' . ucfirst($objectType);
            $objectTemp = new $entityClass();
            $hasSlug = $objectTemp->get_hasUniqueSlug();
            if ($hasSlug) {
                $slug = (isset($args['slug']) && !empty($args['slug'])) ? $args['slug'] : $this->request->query->filter('slug', '', FILTER_SANITIZE_STRING);
                $hasSlug = (!empty($slug));
            }
        }
        $hasIdentifier |= $hasSlug;
        $this->throwNotFoundUnless($hasIdentifier, $this->__('Error! Invalid identifier received.'));
        
        $entity = ModUtil::apiFunc($this->name, 'selection', 'getEntity', array('ot' => $objectType, 'id' => $idValues, 'slug' => $slug));
        $this->throwNotFoundUnless($entity != null, $this->__('No such item.'));
        unset($idValues);
        
        // build ModUrl instance for display hooks; also create identifier for permission check
        $currentUrlArgs = array('ot' => $objectType);
        $instanceId = '';
        foreach ($idFields as $idField) {
            $currentUrlArgs[$idField] = $entity[$idField];
            if (!empty($instanceId)) {
                $instanceId .= '_';
            }
            $instanceId .= $entity[$idField];
        }
        $currentUrlArgs['id'] = $instanceId;
        if (isset($entity['slug'])) {
            $currentUrlArgs['slug'] = $entity['slug'];
        }
        $currentUrlObject = new Zikula_ModUrl($this->name, 'user', 'display', ZLanguage::getLanguageCode(), $currentUrlArgs);
        
        $this->throwForbiddenUnless(SecurityUtil::checkPermission($this->name . ':' . ucwords($objectType) . ':', $instanceId . '::', ACCESS_READ), LogUtil::getErrorMsgPermission());
        
        $templateFile = MediaRepository_Util_View::getViewTemplate($this->view, 'user', $objectType, 'display', $args);
        
        // set cache id
        $component = $this->name . ':' . ucwords($objectType) . ':';
        $instance = $instanceId . '::';
        $accessLevel = ACCESS_READ;
        if (SecurityUtil::checkPermission($component, $instance, ACCESS_COMMENT)) $accessLevel = ACCESS_COMMENT;
        if (SecurityUtil::checkPermission($component, $instance, ACCESS_EDIT)) $accessLevel = ACCESS_EDIT;
        $this->view->setCacheId($objectType . '|' . $instanceId . '|a' . $accessLevel);
        
        // assign output data to view object.
        $this->view->assign($objectType, $entity)
                   ->assign('currentUrlObject', $currentUrlObject)
                   ->assign($repository->getAdditionalTemplateParameters('controllerAction', $utilArgs));
        
        // fetch and return the appropriate template
        return MediaRepository_Util_View::processTemplate($this->view, 'user', $objectType, 'display', $args, $templateFile);
    }
    
    /**
     * This method provides a generic handling of all edit requests.
     *
     * @param array $args List of arguments.
     * @param string  $ot           Treated object type.
     * @param string  $tpl          Name of alternative template (for alternative display options, feeds and xml output)
     * @param boolean $raw          Optional way to display a template instead of fetching it (needed for standalone output)
     *
     * @return mixed Output.
     */
    public function edit($args)
    {
        // parameter specifying which type of objects we are treating
        $objectType = (isset($args['ot']) && !empty($args['ot'])) ? $args['ot'] : $this->request->query->filter('ot', 'medium', FILTER_SANITIZE_STRING);
        $utilArgs = array('controller' => 'user', 'action' => 'edit');
        if (!in_array($objectType, MediaRepository_Util_Controller::getObjectTypes('controllerAction', $utilArgs))) {
            $objectType = MediaRepository_Util_Controller::getDefaultObjectType('controllerAction', $utilArgs);
        }
        $this->throwForbiddenUnless(SecurityUtil::checkPermission($this->name . ':' . ucwords($objectType) . ':', '::', ACCESS_EDIT), LogUtil::getErrorMsgPermission());
        
        // create new Form reference
        $view = FormUtil::newForm($this->name, $this);
        
        // build form handler class name
        $handlerClass = $this->name . '_Form_Handler_User_' . ucfirst($objectType) . '_Edit';
        
        // execute form using supplied template and page event handler
        return $view->execute('user/' . $objectType . '/edit.tpl', new $handlerClass());
    }
    

    /**
     * This method cares for a redirect within an inline frame.
     *
     * @return boolean
     */
    public function handleInlineRedirect()
    {
        $itemId = (int) $this->request->query->filter('id', 0, FILTER_VALIDATE_INT);
        $idPrefix = $this->request->query->filter('idp', '', FILTER_SANITIZE_STRING);
        $commandName = $this->request->query->filter('com', '', FILTER_SANITIZE_STRING);
        if (empty($idPrefix)) {
            return false;
        }

        $this->view->assign('itemId', $itemId)
                   ->assign('idPrefix', $idPrefix)
                   ->assign('commandName', $commandName)
                   ->assign('jcssConfig', JCSSUtil::getJSConfig())
                   ->display('user/inlineRedirectHandler.tpl');
        return true;
    }
}