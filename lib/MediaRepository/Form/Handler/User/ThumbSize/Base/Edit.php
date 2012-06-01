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
 * This handler class handles the page events of the Form called by the MediaRepository_user_edit() function.
 * It aims on the thumb size object type.
 *
 * More documentation is provided in the parent class.
 */
class MediaRepository_Form_Handler_User_ThumbSize_Base_Edit extends MediaRepository_Form_Handler_User_Edit
{
    /**
     * Persistent member vars
     */

    /**
     * Pre-initialise hook.
     *
     * @return void
     */
    public function preInitialize()
    {
        parent::preInitialize();

        $this->objectType = 'thumbSize';
        $this->objectTypeCapital = 'ThumbSize';
        $this->objectTypeLower = 'thumbsize';
        $this->objectTypeLowerMultiple = 'thumbSizes';

        $this->hasPageLockSupport = true;
        $this->hasAttributes = false;
        $this->hasCategories = false;
        $this->hasMetaData = false;
    }

    /**
     * Initialize form handler.
     *
     * This method takes care of all necessary initialisation of our data and form states.
     *
     * @param Zikula_Form_View $view The form view instance.
     *
     * @return boolean False in case of initialization errors, otherwise true.
     */
    public function initialize(Zikula_Form_View $view)
    {
        parent::initialize($view);
    
        $entity = $this->entityRef;
    
        if ($this->mode == 'edit') {
        } else {
            if ($this->hasTemplateId !== true) {
            }
        }
    
        
        // save parent identifiers of unidirectional incoming relationships
        $this->incomingIds['repositories'] = FormUtil::getPassedValue('repositories', '', 'GET');
    
        // save entity reference for later reuse
        $this->entityRef = $entity;
    
        $entityData = $entity->toArray();
    
        // assign data to template as array (makes translatable support easier)
        $this->view->assign($this->objectTypeLower, $entityData);
    
        $this->initializeAdditions();
    
        // everything okay, no initialization errors occured
        return true;
    }

    /**
     * Post-initialise hook.
     *
     * @return void
     */
    public function postInitialize()
    {
        parent::postInitialize();
    }

    /**
     * Get list of allowed redirect codes.
     *
     * @return array list of possible redirect codes
     */
    protected function getRedirectCodes()
    {
        $codes = parent::getRedirectCodes();
        return $codes;
    }

    /**
     * Get the default redirect url. Required if no returnTo parameter has been supplied.
     * This method is called in handleCommand so we know which command has been performed.
     *
     * @param array  $args List of arguments.
     *
     * @return string The default redirect url.
     */
    protected function getDefaultReturnUrl($args)
    {
        // redirect to the list of thumbSizes
        $viewArgs = array('ot' => $this->objectType);
        $url = ModUtil::url($this->name, 'user', 'view', $viewArgs);
    
        if ($args['commandName'] != 'delete' && !($this->mode == 'create' && $args['commandName'] == 'cancel')) {
            // redirect to the detail page of treated thumbSize
            $url = ModUtil::url($this->name, 'user', 'display', array('ot' => 'thumbSize', 'id' => $this->idValues['id']));
        }
        return $url;
    }

    /**
     * Command event handler.
     *
     * This event handler is called when a command is issued by the user.
     *
     * @param Zikula_Form_View $view The form view instance.
     * @param array            $args Additional arguments.
     *
     * @return mixed Redirect or false on errors.
     */
    public function handleCommand(Zikula_Form_View $view, &$args)
    {
        $result = parent::handleCommand($view, $args);
        if ($result === false) {
            return $result;
        }
    
        return $this->view->redirect($this->getRedirectUrl($args));
    }
    
    /**
     * Get success or error message for default operations.
     *
     * @param Array   $args    arguments from handleCommand method.
     * @param Boolean $success true if this is a success, false for default error.
     * @return String desired status or error message.
     */
    protected function getDefaultMessage($args, $success = false)
    {
        if ($success !== true) {
            return parent::getDefaultMessage($args, $success);
        }
    
        $message = '';
        switch ($args['commandName']) {
            case 'create':
                        $message = $this->__('Done! Thumb size created.');
                        break;
            case 'update':
                        $message = $this->__('Done! Thumb size updated.');
                        break;
            case 'delete':
                        $message = $this->__('Done! Thumb size deleted.');
                        break;
        }
        return $message;
    }

    /**
     * Input data processing called by handleCommand method.
     *
     * @param Zikula_Form_View $view The form view instance.
     * @param array            $args Additional arguments.
     *
     * @return array form data after processing.
     */
    public function fetchInputData(Zikula_Form_View $view, &$args)
    {
        $otherFormData = parent::fetchInputData($view, $args);
    
        // get treated entity reference from persisted member var
        $entity = $this->entityRef;
    
        $entityData = array();
    
        $this->reassignRelatedObjects();
    
        // assign fetched data
        if (count($entityData) > 0) {
            $entity->merge($entityData);
        }
    
        // save updated entity
        $this->entityRef = $entity;
    
        return $otherFormData;
    }

    /**
     * Executing insert and update statements
     *
     * @param Array   $args    arguments from handleCommand method.
     */
    public function performUpdate($args)
    {
        // get treated entity reference from persisted member var
        $entity = $this->entityRef;
    
        $this->updateRelationLinks($entity);
        //$this->entityManager->transactional(function($entityManager) {
            $this->entityManager->persist($entity);
            $this->entityManager->flush();
        //});
    
        // save incoming relationship from parent entity
        if ($args['commandName'] == 'create') {
        if (!empty($this->incomingIds['repositories'])) {
            $relObj = ModUtil::apiFunc($this->name, 'selection', 'getEntity', array('ot' => 'repository', 'id' => $this->incomingIds['repositories']));
            if ($relObj != null) {
                $relObj->addThumbSizes($entity);
            }
        }
            $this->entityManager->flush();
        }
    }

    /**
     * Get url to redirect to.
     *
     * @param array  $args List of arguments.
     *
     * @return string The redirect url.
     */
    protected function getRedirectUrl($args)
    {
        if ($this->inlineUsage == true) {
            $urlArgs = array('idp' => $this->idPrefix,
                             'com' => $args['commandName']);
            $urlArgs = $this->addIdentifiersToUrlArgs($urlArgs);
            // inline usage, return to special function for closing the Zikula.UI.Window instance
            return ModUtil::url($this->name, 'user', 'handleInlineRedirect', $urlArgs);
        }
    
        if ($this->repeatCreateAction) {
            return $this->repeatReturnUrl;
        }
    
        // normal usage, compute return url from given redirect code
        if (!in_array($this->returnTo, $this->getRedirectCodes())) {
            // invalid return code, so return the default url
            return $this->getDefaultReturnUrl($args);
        }
    
        // parse given redirect code and return corresponding url
        switch ($this->returnTo) {
            case 'admin':
                        return ModUtil::url($this->name, 'admin', 'main');
            case 'adminView':
                        return ModUtil::url($this->name, 'admin', 'view',
                                                 array('ot' => $this->objectType));
            case 'adminDisplay':
                        if ($args['commandName'] != 'delete' && !($this->mode == 'create' && $args['commandName'] == 'cancel')) {
                            return ModUtil::url($this->name, 'admin', 'display', $this->addIdentifiersToUrlArgs());
                        }
                        return $this->getDefaultReturnUrl($args);
            case 'user':
                        return ModUtil::url($this->name, 'user', 'main');
            case 'userView':
                        return ModUtil::url($this->name, 'user', 'view',
                                                 array('ot' => $this->objectType));
            case 'userDisplay':
                        if ($args['commandName'] != 'delete' && !($this->mode == 'create' && $args['commandName'] == 'cancel')) {
                            return ModUtil::url($this->name, 'user', 'display', $this->addIdentifiersToUrlArgs());
                        }
                        return $this->getDefaultReturnUrl($args);
                    default:
                                return $this->getDefaultReturnUrl($args);
        }
    }

    /**
     * Reassign options chosen by the user to avoid unwanted form state resets.
     * Necessary until issue #23 is solved.
     */
    public function reassignRelatedObjects()
    {
        $selectedRelations = array();
        $this->view->assign('selectedRelations', $selectedRelations);
    }

    /**
     * Helper method for updating links to related records.
     *
     * @param object $entity Currently treated entity instance.
     */
    protected function updateRelationLinks($entity)
    {
        $relatedIds = $this->request->request->get('medrepThumbSize_RepositoriesItemList', '');
        if ($this->mode != 'create') {
            // remove all existing references
        }
        if (!empty($relatedIds)) {
            if (!is_array($relatedIds)) {
                $relatedIds = explode(',', $relatedIds);
            }
            if (is_array($relatedIds) && count($relatedIds)) {
                $idFields = ModUtil::apiFunc('MediaRepository', 'selection', 'getIdFields', array('ot' => 'repository'));
                $relatedIdValues = $this->decodeCompositeIdentifier($relatedIds, $idFields);
        
                $where = '';
                foreach ($idFields as $idField) {
                    if (!empty($where)) {
                        $where .= ' AND ';
                    }
                    $where .= 'tbl.' . $idField . ' IN (' . implode(', ', $relatedIdValues[$idField]) . ')';
                }
                $linkObjects = ModUtil::apiFunc($this->name, 'selection', 'getEntities', array('ot' => 'repository', 'where' => $where));
                // create new links
                foreach ($linkObjects as $relatedObject) {
                    if ($entity->getRepositories()->contains($relatedObject)) {
                        continue;
                    }
                    $entity->addRepositories($relatedObject);
                }
            }
        }
    }
}
