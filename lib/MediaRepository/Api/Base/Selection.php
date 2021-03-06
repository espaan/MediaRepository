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
 * @version Generated by ModuleStudio 0.5.5 (http://modulestudio.de) at Fri Jun 22 18:45:36 CEST 2012.
 */

/**
 * Selection api base class.
 */
class MediaRepository_Api_Base_Selection extends Zikula_AbstractApi
{
    /**
     * Gets the list of identifier fields for a given object type.
     *
     * @param string $args['ot'] The object type to be treated (optional)
     *
     * @return array List of identifier field names.
     */
    public function getIdFields($args)
    {
        $objectType = $this->determineObjectType($args, 'getIdFields');
        $entityClass = 'MediaRepository_Entity_' . ucfirst($objectType);
        $objectTemp = new $entityClass(); 
        $idFields = $objectTemp->get_idFields();
        return $idFields;
    }
    
    /**
     * Selects a single entity.
     *
     * @param string  $args['ot']       The object type to retrieve (optional)
     * @param mixed   $args['id']       The id (or array of ids) to use to retrieve the object (default=null).
     * @param string  $args['slug']     Slug to use as selection criteria instead of id (optional) (default=null).
     * @param boolean $args['useJoins'] Whether to include joining related objects (optional) (default=true).
     * @param boolean $args['slimMode'] If activated only some basic fields are selected without using any joins (optional) (default=false).
     *
     * @return mixed Desired entity object or null.
     */
    public function getEntity($args)
    {
        if (!isset($args['id']) && !isset($args['slug'])) {
            return LogUtil::registerArgsError();
        }
        $objectType = $this->determineObjectType($args, 'getEntity');
        $repository = $this->getRepository($objectType);
    
        $idValues = $args['id'];
        $slug = isset($args['slug']) ? $args['slug'] : null;
        $useJoins = isset($args['useJoins']) ? ((bool) $args['useJoins']) : true;
        $slimMode = isset($args['slimMode']) ? ((bool) $args['slimMode']) : false;
    
        $entity = null;
        if ($slug != null) {
            $entity = $repository->selectBySlug($slug, $useJoins, $slimMode);
        } else {
            $entity = $repository->selectById($idValues, $useJoins, $slimMode);
        }
    
        return $entity;
    }
    
    /**
     * Selects a list of entities by different criteria.
     *
     * @param string  $args['ot']       The object type to retrieve (optional)
     * @param string  $args['where']    The where clause to use when retrieving the collection (optional) (default='').
     * @param string  $args['orderBy']  The order-by clause to use when retrieving the collection (optional) (default='').
     * @param boolean $args['useJoins'] Whether to include joining related objects (optional) (default=true).
     * @param boolean $args['slimMode'] If activated only some basic fields are selected without using any joins (optional) (default=false).
     *
     * @return Array with retrieved collection.
     */
    public function getEntities($args)
    {
        $objectType = $this->determineObjectType($args, 'getEntities');
        $repository = $this->getRepository($objectType);
    
        $where = isset($args['where']) ? $args['where'] : '';
        $orderBy = isset($args['orderBy']) ? $args['orderBy'] : '';
        $useJoins = isset($args['useJoins']) ? ((bool) $args['useJoins']) : true;
        $slimMode = isset($args['slimMode']) ? ((bool) $args['slimMode']) : false;
    
        return $repository->selectWhere($where, $orderBy, $useJoins, $slimMode);
    }
    
    /**
     * Selects a list of entities by different criteria.
     *
     * @param string  $args['ot']             The object type to retrieve (optional)
     * @param string  $args['where']          The where clause to use when retrieving the collection (optional) (default='').
     * @param string  $args['orderBy']        The order-by clause to use when retrieving the collection (optional) (default='').
     * @param integer $args['currentPage']    Where to start selection
     * @param integer $args['resultsPerPage'] Amount of items to select
     * @param boolean $args['useJoins']       Whether to include joining related objects (optional) (default=true).
     * @param boolean $args['slimMode']       If activated only some basic fields are selected without using any joins (optional) (default=false).
     *
     * @return Array with retrieved collection and amount of total records affected by this query.
     */
    public function getEntitiesPaginated($args)
    {
        $objectType = $this->determineObjectType($args, 'getEntitiesPaginated');
        $repository = $this->getRepository($objectType);
    
        $where = isset($args['where']) ? $args['where'] : '';
        $orderBy = isset($args['orderBy']) ? $args['orderBy'] : '';
        $currentPage = isset($args['currentPage']) ? $args['currentPage'] : 1;
        $resultsPerPage = isset($args['resultsPerPage']) ? $args['resultsPerPage'] : 25;
        $useJoins = isset($args['useJoins']) ? ((bool) $args['useJoins']) : true;
        $slimMode = isset($args['slimMode']) ? ((bool) $args['slimMode']) : false;
    
        if ($orderBy == 'RAND()') {
            // random ordering is disabled for now, see https://github.com/Guite/MostGenerator/issues/143
            $orderBy = $repository->getDefaultSortingField();
        }
    
        return $repository->selectWherePaginated($where, $orderBy, $currentPage, $resultsPerPage, $useJoins, $slimMode);
    }
    
    /**
     * Determines object type using controller util methods.
     *
     * @param string $args['ot'] The object type to retrieve (optional)
     * @param string $methodName Name of calling method
     *
     * @return string the object type.
     */
    protected function determineObjectType($args, $methodName = '')
    {
        $objectType = isset($args['ot']) ? $args['ot'] : '';
        $controllerHelper = new MediaRepository_Util_Controller($this->serviceManager);
        $utilArgs = array('api' => 'selection', 'action' => $methodName);
        if (!in_array($objectType, $controllerHelper->getObjectTypes('api', $utilArgs))) {
            $objectType = $controllerHelper->getDefaultObjectType('api', $utilArgs);
        }
        return $objectType;
    }
    
    /**
     * Returns repository instance for a certain object type.
     *
     * @param string $objectType The desired object type.
     *
     * @return mixed Repository class instance or null.
     */
    protected function getRepository($objectType = '')
    {
        if (empty($objectType)) {
            return LogUtil::registerArgsError();
        }
        return $this->entityManager->getRepository('MediaRepository_Entity_' . ucfirst($objectType));
    }
}
