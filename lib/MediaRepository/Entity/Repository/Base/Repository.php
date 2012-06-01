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

use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\Query;
use Doctrine\ORM\QueryBuilder;

use DoctrineExtensions\Paginate\Paginate;

/**
 * Repository class used to implement own convenience methods for performing certain DQL queries.
 *
 * This is the base repository class for repository entities.
 */
class MediaRepository_Entity_Repository_Base_Repository extends EntityRepository
{
    /**
     * @var string The default sorting field/expression.
     */
    protected $defaultSortingField = 'name';

    /**
     * Retrieves an array with all fields which can be used for sorting instances.
     *
     * @return array
     */
    public function getAllowedSortingFields()
    {
        return array(
            'id',
            'name',
            'workDirectory',
            'storageDirectory',
            'cacheDirectory',
            'storageMode',
            'permissionScope',
            'useQuota',
            'allowManagementOfOwnFiles',
            'allowFileMailing',
            'maxSizeForMail',
            'maxFilesPerUpload',
            'maxUploadFileSize',
            'uploadNamingConvention',
            'uploadNamingPrefix',
            'enableSharpen',
            'enableShrinking',
            'shrinkDimensions',
            'useThumbCropper',
            'cropSizeMode',
            'defaultTemplateCollection',
            'allowTemplateOverrideCollection',
            'defaultTemplateDetail',
            'allowTemplateOverrideDetail',
            'startPageViewMode',
            'downloadMode',
            'sendMailAfterUpload',
            'mailRecipient',
            'createdUserId',
            'updatedUserId',
            'createdDate',
            'updatedDate',
        );
    }

    /**
     * Get default sorting field.
     *
     * @return string
     */
    public function getDefaultSortingField()
    {
        return $this->defaultSortingField;
    }
    
    /**
     * Set default sorting field.
     *
     * @param string $defaultSortingField.
     *
     * @return void
     */
    public function setDefaultSortingField($defaultSortingField)
    {
        $this->defaultSortingField = $defaultSortingField;
    }
    

    /**
     * Returns name of the field used as title / name for entities of this repository.
     *
     * @return string name of field to be used as title. 
     */
    public function getTitleFieldName()
    {
        $fieldName = 'name';
        return $fieldName;
    }

    /**
     * Returns name of the field used for describing entities of this repository.
     *
     * @return string name of field to be used as description. 
     */
    public function getDescriptionFieldName()
   {
        $fieldName = 'workDirectory';
        return $fieldName;
    }

    /**
     * Returns name of the first upload field which is capable for handling images.
     *
     * @return string name of field to be used for preview images 
     */
    public function getPreviewFieldName()
    {
        $fieldName = '';
        return $fieldName;
    }

    /**
     * Returns an array of additional template variables which are specific to the object type treated by this repository.
     *
     * @param string $context Usage context (allowed values: controllerAction, api, actionHandler, block, contentType).
     * @param array  $args    Additional arguments.
     *
     * @return array List of template variables to be assigned.
     */
    public function getAdditionalTemplateParameters($context = '', $args = array())
    {
        if (!in_array($context, array('controllerAction', 'api', 'actionHandler', 'block', 'contentType'))) {
            $context = 'controllerAction';
        }
    
        $templateParameters = array();
    
        $currentFunc = FormUtil::getPassedValue('func', 'main', 'GETPOST');
        if (in_array($currentFunc, array('main', 'view'))) {
            $templateParameters = $this->getViewQuickNavParameters($context, $args);
        }
    
        // in the concrete child class you could do something like
        // $parameters = parent::getAdditionalTemplateParameters($context, $args);
        // $parameters['myvar'] = 'myvalue';
        // return $parameters;
    
        return $templateParameters;
    }
    
    /**
     * Returns an array of additional template variables for view quick navigation forms.
     *
     * @param string $context Usage context (allowed values: controllerAction, api, actionHandler, block, contentType).
     * @param array  $args    Additional arguments.
     *
     * @return array List of template variables to be assigned.
     */
    protected function getViewQuickNavParameters($context = '', $args = array())
    {
        if (!in_array($context, array('controllerAction', 'api', 'actionHandler', 'block', 'contentType'))) {
            $context = 'controllerAction';
        }
    
        $parameters = array();
        $parameters['catId'] = (int) FormUtil::getPassedValue('catid', 0, 'GET');
        $parameters['searchterm'] = FormUtil::getPassedValue('searchterm', '', 'GET');
        
        $parameters['useQuota'] = (int) FormUtil::getPassedValue('useQuota', 0, 'GET');
        $parameters['allowManagementOfOwnFiles'] = (int) FormUtil::getPassedValue('allowManagementOfOwnFiles', 0, 'GET');
        $parameters['allowFileMailing'] = (int) FormUtil::getPassedValue('allowFileMailing', 0, 'GET');
        $parameters['enableSharpen'] = (int) FormUtil::getPassedValue('enableSharpen', 0, 'GET');
        $parameters['enableShrinking'] = (int) FormUtil::getPassedValue('enableShrinking', 0, 'GET');
        $parameters['useThumbCropper'] = (int) FormUtil::getPassedValue('useThumbCropper', 0, 'GET');
        $parameters['allowTemplateOverrideCollection'] = (int) FormUtil::getPassedValue('allowTemplateOverrideCollection', 0, 'GET');
        $parameters['allowTemplateOverrideDetail'] = (int) FormUtil::getPassedValue('allowTemplateOverrideDetail', 0, 'GET');
        $parameters['sendMailAfterUpload'] = (int) FormUtil::getPassedValue('sendMailAfterUpload', 0, 'GET');
    
        // in the concrete child class you could do something like
        // $parameters = parent::getViewQuickNavParameters($context, $args);
        // $parameters['myvar'] = 'myvalue';
        // return $parameters;
    
        return $parameters;
    }

    /**
     * Helper method for truncating the table.
     * Used during installation when inserting default data.
     */
    public function truncateTable()
    {
        $qb = $this->getEntityManager()->createQueryBuilder();
        $qb->delete('MediaRepository_Entity_Repository', 'tbl');
        $query = $qb->getQuery();
        $query->execute();
    }

    /**
     * Deletes all objects created by a certain user.
     *
     * @param integer $userId The userid of the creator to be removed.
     *
     * @return void
     */
    public function deleteCreator($userId)
    {
        // check id parameter
        if ($userId == 0 || !is_numeric($userId)) {
            return LogUtil::registerArgsError();
        }
    
        $qb = $this->getEntityManager()->createQueryBuilder();
        $qb->delete('MediaRepository_Entity_Repository', 'tbl')
           ->where('tbl.createdUserId = :creator')
           ->setParameter('creator', $userId);
        $query = $qb->getQuery();
        $query->execute();
    }
    
    /**
     * Deletes all objects updated by a certain user.
     *
     * @param integer $userId The userid of the last editor to be removed.
     *
     * @return void
     */
    public function deleteLastEditor($userId)
    {
        // check id parameter
        if ($userId == 0 || !is_numeric($userId)) {
            return LogUtil::registerArgsError();
        }
    
        $qb = $this->getEntityManager()->createQueryBuilder();
        $qb->delete('MediaRepository_Entity_Repository', 'tbl')
           ->where('tbl.updatedUserId = :editor')
           ->setParameter('editor', $userId);
        $query = $qb->getQuery();
        $query->execute();
    }
    
    /**
     * Updates the creator of all objects created by a certain user.
     *
     * @param integer $userId    The userid of the creator to be replaced.
     * @param integer $newUserId The new userid of the creator as replacement.
     *
     * @return void
     */
    public function updateCreator($userId, $newUserId)
    {
        // check id parameter
        if ($userId == 0 || !is_numeric($userId)
         || $newUserId == 0 || !is_numeric($newUserId)) {
            return LogUtil::registerArgsError();
        }
    
        $qb = $this->getEntityManager()->createQueryBuilder();
        $qb->update('MediaRepository_Entity_Repository', 'tbl')
           ->set('tbl.createdUserId', $newUserId)
           ->where('tbl.createdUserId = :creator')
           ->setParameter('creator', $userId);
        $query = $qb->getQuery();
        $query->execute();
    }
    
    /**
     * Updates the last editor of all objects updated by a certain user.
     *
     * @param integer $userId    The userid of the last editor to be replaced.
     * @param integer $newUserId The new userid of the last editor as replacement.
     *
     * @return void
     */
    public function updateLastEditor($userId, $newUserId)
    {
        // check id parameter
        if ($userId == 0 || !is_numeric($userId)
         || $newUserId == 0 || !is_numeric($newUserId)) {
            return LogUtil::registerArgsError();
        }
    
        $qb = $this->getEntityManager()->createQueryBuilder();
        $qb->update('MediaRepository_Entity_Repository', 'tbl')
           ->set('tbl.updatedUserId', $newUserId)
           ->where('tbl.updatedUserId = :editor')
           ->setParameter('editor', $userId);
        $query = $qb->getQuery();
        $query->execute();
    }

    /**
     * Adds id filters to given query instance.
     *
     * @param mixed                     $id The id (or array of ids) to use to retrieve the object.
     * @param Doctrine\ORM\QueryBuilder $qb Query builder to be enhanced.
     *
     * @return Doctrine\ORM\QueryBuilder Enriched query builder instance.
     */
    protected function addIdFilter($id, $qb)
    {
        if (is_array($id)) {
            foreach ($id as $fieldName => $fieldValue) {
                $qb->andWhere('tbl.' . $fieldName . ' = :' . $fieldName)
                   ->setParameter($fieldName, $fieldValue);
            }
        } else {
            $qb->andWhere('tbl.id = :id')
               ->setParameter('id', $id);
        }
        return $qb;
    }
    
    /**
     * Selects an object from the database.
     *
     * @param mixed   $id       The id (or array of ids) to use to retrieve the object (optional) (default=0).
     * @param boolean $useJoins Whether to include joining related objects (optional) (default=true).
     * @param boolean $slimMode If activated only some basic fields are selected without using any joins (optional) (default=false).
     *
     * @return array|MediaRepository_Entity_Repository retrieved data array or MediaRepository_Entity_Repository instance
     */
    public function selectById($id = 0, $useJoins = true, $slimMode = false)
    {
        // check id parameter
        if ($id == 0) {
            return LogUtil::registerArgsError();
        }
    
        $qb = $this->_intBaseQuery('', '', $useJoins, $slimMode);
    
        $qb = $this->addIdFilter($id, $qb);
    
        $query = $this->getQueryFromBuilder($qb);
    
        return $query->getOneOrNullResult();
    }

    /**
     * Adds where clauses excluding desired identifiers from selection.
     *
     * @param Doctrine\ORM\QueryBuilder $qb        Query builder to be enhanced.
     * @param integer                   $excludeId The id (or array of ids) to be excluded from selection.
     *
     * @return Doctrine\ORM\QueryBuilder Enriched query builder instance.
     */
    protected function addExclusion($qb, $excludeId)
    {
        if ($excludeId > 0) {
            $qb->andWhere('tbl.id != :excludeId')
               ->setParameter('excludeId', $excludeId);
        }
        return $qb;
    }

    /**
     * Selects a list of objects with a given where clause.
     *
     * @param string  $where    The where clause to use when retrieving the collection (optional) (default='').
     * @param string  $orderBy  The order-by clause to use when retrieving the collection (optional) (default='').
     * @param boolean $useJoins Whether to include joining related objects (optional) (default=true).
     * @param boolean $slimMode If activated only some basic fields are selected without using any joins (optional) (default=false).
     *
     * @return ArrayCollection collection containing retrieved MediaRepository_Entity_Repository instances
     */
    public function selectWhere($where = '', $orderBy = '', $useJoins = true, $slimMode = false)
    {
        $qb = $this->_intBaseQuery($where, $orderBy, $useJoins, $slimMode);
    
        $query = $this->getQueryFromBuilder($qb);
    
        return $query->getResult();
    }

    /**
     * Returns query builder instance for retrieving a list of objects with a given where clause and pagination parameters.
     *
     * @param Doctrine\ORM\QueryBuilder $qb             Query builder to be enhanced.
     * @param integer                   $currentPage    Where to start selection
     * @param integer                   $resultsPerPage Amount of items to select
     *
     * @return array Created query instance and amount of affected items.
     */
    protected function getSelectWherePaginatedQuery($qb, $currentPage = 1, $resultsPerPage = 25)
    {
        $qb = $this->addCommonViewFilters($qb);
    
        $query = $this->getQueryFromBuilder($qb);
        $offset = ($currentPage-1) * $resultsPerPage;
    
        // count the total number of affected items
        $count = Paginate::getTotalQueryResults($query);
    
        // prefetch unique relationship ids for given pagination frame
        $query = Paginate::getPaginateQuery($query, $offset, $resultsPerPage);
        return array($query, $count);
    }
    
    /**
     * Selects a list of objects with a given where clause and pagination parameters.
     *
     * @param string  $where          The where clause to use when retrieving the collection (optional) (default='').
     * @param string  $orderBy        The order-by clause to use when retrieving the collection (optional) (default='').
     * @param integer $currentPage    Where to start selection
     * @param integer $resultsPerPage Amount of items to select
     * @param boolean $useJoins       Whether to include joining related objects (optional) (default=true).
     *
     * @return Array with retrieved collection and amount of total records affected by this query.
     */
    public function selectWherePaginated($where = '', $orderBy = '', $currentPage = 1, $resultsPerPage = 25, $useJoins = true)
    {
        $qb = $this->_intBaseQuery($where, $orderBy, $useJoins);
        list($query, $count) = $this->getSelectWherePaginatedQuery($qb, $currentPage, $resultsPerPage);
    
        $result = $query->getResult();
    
        return array($result, $count);
    }
    
    /**
     * Adds quick navigation related filter options as where clauses.
     *
     * @param Doctrine\ORM\QueryBuilder $qb Query builder to be enhanced.
     *
     * @return Doctrine\ORM\QueryBuilder Enriched query builder instance.
     */
    protected function addCommonViewFilters($qb)
    {
        $currentFunc = FormUtil::getPassedValue('func', 'main', 'GETPOST');
        if ($currentFunc != 'view' && $currentFunc != 'finder') {
            return $qb;
        }
    
        $parameters = $this->getViewQuickNavParameters('', array());
        foreach ($parameters as $k => $v) {
            if ($k == 'catId') {
                // category filter
                if ($v > 0) {
                    $qb->andWhere('tblCategories.category = :category')
                       ->setParameter('category', $v);
                }
            } elseif ($k == 'searchterm') {
                // quick search
                if (!empty($v)) {
                    $qb = $this->addSearchFilter($qb, $v);
                }
            } else {
                // field filter
                if ($v != '' || (is_numeric($v) && $v > 0)) {
                    $qb->andWhere('tbl.' . $k . ' = :' . $k)
                       ->setParameter($k, $v);
                }
            }
        }
        return $qb;
    }

    /**
     * Selects entities by a given search fragment.
     *
     * @param string  $fragment       The fragment to search for.
     * @param array   $exclude        Comma separated list with ids to be excluded from search.
     * @param string  $orderBy        The order-by clause to use when retrieving the collection (optional) (default='').
     * @param integer $currentPage    Where to start selection
     * @param integer $resultsPerPage Amount of items to select
     * @param boolean $useJoins       Whether to include joining related objects (optional) (default=true).
     *
     * @return Array with retrieved collection and amount of total records affected by this query.
     */
    public function selectSearch($fragment = '', $exclude = array(), $orderBy = '', $currentPage = 1, $resultsPerPage = 25, $useJoins = true)
    {
        $qb = $this->_intBaseQuery('', $orderBy, $useJoins);
        if (count($exclude) > 0) {
            $exclude = implode(', ', $exclude);
            $qb->andWhere('tbl.id NOT IN (:excludeList)')
               ->setParameter('excludeList', $exclude);
        }
    
        $qb = $this->addSearchFilter($qb, $fragment);
    
        list($query, $count) = $this->getSelectWherePaginatedQuery($qb, $currentPage, $resultsPerPage);
    
        $result = $query->getResult();
    
        return array($result, $count);
    }
    
    /**
     * Adds where clause for search query.
     *
     * @param Doctrine\ORM\QueryBuilder $qb       Query builder to be enhanced.
     * @param string                    $fragment The fragment to search for.
     *
     * @return Doctrine\ORM\QueryBuilder Enriched query builder instance.
     */
    protected function addSearchFilter($qb, $fragment = '')
    {
        if ($fragment == '') {
            return $qb;
        }
    
        $fragment = DataUtil::formatForStore($fragment);
    
        $where = '';
        $where .= ((!empty($where)) ? ' OR ' : '');
        $where .= 'tbl.name LIKE \'%' . $fragment . '%\'';
        $where .= ((!empty($where)) ? ' OR ' : '');
        $where .= 'tbl.workDirectory LIKE \'%' . $fragment . '%\'';
        $where .= ((!empty($where)) ? ' OR ' : '');
        $where .= 'tbl.storageDirectory LIKE \'%' . $fragment . '%\'';
        $where .= ((!empty($where)) ? ' OR ' : '');
        $where .= 'tbl.cacheDirectory LIKE \'%' . $fragment . '%\'';
        $where .= ((!empty($where)) ? ' OR ' : '');
        $where .= 'tbl.storageMode = \'' . $fragment . '\'';
        $where .= ((!empty($where)) ? ' OR ' : '');
        $where .= 'tbl.permissionScope = \'' . $fragment . '\'';
        $where .= ((!empty($where)) ? ' OR ' : '');
        $where .= 'tbl.maxSizeForMail = \'' . $fragment . '\'';
        $where .= ((!empty($where)) ? ' OR ' : '');
        $where .= 'tbl.maxFilesPerUpload = \'' . $fragment . '\'';
        $where .= ((!empty($where)) ? ' OR ' : '');
        $where .= 'tbl.maxUploadFileSize = \'' . $fragment . '\'';
        $where .= ((!empty($where)) ? ' OR ' : '');
        $where .= 'tbl.uploadNamingConvention = \'' . $fragment . '\'';
        $where .= ((!empty($where)) ? ' OR ' : '');
        $where .= 'tbl.uploadNamingPrefix LIKE \'%' . $fragment . '%\'';
        $where .= ((!empty($where)) ? ' OR ' : '');
        $where .= 'tbl.cropSizeMode = \'' . $fragment . '\'';
        $where .= ((!empty($where)) ? ' OR ' : '');
        $where .= 'tbl.defaultTemplateCollection LIKE \'%' . $fragment . '%\'';
        $where .= ((!empty($where)) ? ' OR ' : '');
        $where .= 'tbl.defaultTemplateDetail LIKE \'%' . $fragment . '%\'';
        $where .= ((!empty($where)) ? ' OR ' : '');
        $where .= 'tbl.startPageViewMode = \'' . $fragment . '\'';
        $where .= ((!empty($where)) ? ' OR ' : '');
        $where .= 'tbl.downloadMode = \'' . $fragment . '\'';
        $where .= ((!empty($where)) ? ' OR ' : '');
        $where .= 'tbl.mailRecipient LIKE \'%' . $fragment . '%\'';
        $where = '(' . $where . ')';
    
        $qb->andWhere($where);
    
        return $qb;
    }

    /**
     * Returns query builder instance for a count query.
     *
     * @param string  $where    The where clause to use when retrieving the object count (optional) (default='').
     * @param boolean $useJoins Whether to include joining related objects (optional) (default=true).
     *
     * @return Doctrine\ORM\QueryBuilder Created query builder instance.
     * @TODO fix usage of joins; please remove the first line and test.
     */
    protected function getCountQuery($where = '', $useJoins = true)
    {
        $useJoins = false;
    
        $selection = 'COUNT(tbl.id) AS numRepositories';
        if ($useJoins === true) {
            $selection .= $this->addJoinsToSelection();
        }
    
        $qb = $this->getEntityManager()->createQueryBuilder();
        $qb->select($selection)
           ->from('MediaRepository_Entity_Repository', 'tbl');
    
        if ($useJoins === true) {
            $this->addJoinsToFrom($qb);
        }
    
        if (!empty($where)) {
            $qb->where($where);
        }
    
        return $qb;
    }
    
    /**
     * Selects entity count with a given where clause.
     *
     * @param string  $where    The where clause to use when retrieving the object count (optional) (default='').
     * @param boolean $useJoins Whether to include joining related objects (optional) (default=true).
     *
     * @return integer amount of affected records
     */
    public function selectCount($where = '', $useJoins = true)
    {
        $qb = $this->getCountQuery($where, $useJoins);
        $query = $qb->getQuery();
        return $query->getSingleScalarResult();
    }


    /**
     * Checks for unique values.
     *
     * @param string $fieldName  The name of the property to be checked
     * @param string $fieldValue The value of the property to be checked
     * @param int    $excludeId  Id of repositories to exclude (optional).
     * @return boolean result of this check, true if the given repository does not already exist
     */
    public function detectUniqueState($fieldName, $fieldValue, $excludeId = 0)
    {
        $qb = $this->getCountQuery('', false);
        $qb->andWhere('tbl.' . $fieldName . ' = :' . $fieldName)
           ->setParameter($fieldName, $fieldValue);
    
        $qb = $this->addExclusion($qb, $excludeId);
    
        $query = $qb->getQuery();
    
        $count = $query->getSingleScalarResult();
    
        return ($count == 0);
    }

    /**
     * Builds a generic Doctrine query supporting WHERE and ORDER BY.
     *
     * @param string  $where    The where clause to use when retrieving the collection (optional) (default='').
     * @param string  $orderBy  The order-by clause to use when retrieving the collection (optional) (default='').
     * @param boolean $useJoins Whether to include joining related objects (optional) (default=true).
     * @param boolean $slimMode If activated only some basic fields are selected without using any joins (optional) (default=false).
     *
     * @return Doctrine\ORM\QueryBuilder query builder instance to be further processed
     */
    protected function _intBaseQuery($where = '', $orderBy = '', $useJoins = true, $slimMode = false)
    {
        // normally we select the whole table
        $selection = 'tbl';
    
        if ($slimMode === true) {
            // but for the slim version we select only the basic fields, and no joins
    
            $titleField = $this->getTitleFieldName();
            $selection = 'tbl.id';
            if ($titleField != '') {
                $selection .= ', tbl.' . $titleField;
            }
            $useJoins = false;
        }
    
        if ($useJoins === true) {
            $selection .= $this->addJoinsToSelection();
        }
    
        $qb = $this->getEntityManager()->createQueryBuilder();
        $qb->select($selection)
           ->from('MediaRepository_Entity_Repository', 'tbl');
    
        if ($useJoins === true) {
            $this->addJoinsToFrom($qb);
        }
    
        if (!empty($where)) {
            $qb->where($where);
        }
        $onlyOwn = (int) FormUtil::getPassedValue('own', 0, 'GETPOST');
        if ($onlyOwn == 1) {
            $qb->andWhere('tbl.createdUserId = :creator')
               ->setParameter('creator', UserUtil::getVar('uid'));
        }
    
        // add order by clause
        if (!empty($orderBy)) {
            if (strpos($orderBy, '.') === false) {
                $orderBy = 'tbl.' . $orderBy;
            }
            $qb->add('orderBy', $orderBy);
        }
    
        return $qb;
    }

    /**
     * Retrieves Doctrine query from query builder, applying FilterUtil and other common actions.
     *
     * @param Doctrine\ORM\QueryBuilder $qb Query builder instance
     *
     * @return Doctrine\ORM\Query query instance to be further processed
     */
    protected function getQueryFromBuilder(Doctrine\ORM\QueryBuilder $qb)
    {
        $query = $qb->getQuery();
    
        // TODO - see https://github.com/zikula/core/issues/118
        // use FilterUtil to support generic filtering
        //$fu = new FilterUtil('MediaRepository', $this);
    
        // you could set explicit filters at this point, something like
        // $fu->setFilter('type:eq:' . $args['type'] . ',id:eq:' . $args['id']);
        // supported operators: eq, ne, like, lt, le, gt, ge, null, notnull
    
        // process request input filters and add them to the query.
        //$fu->enrichQuery($query);
    
    
        return $query;
    }

    /**
     * Helper method to add join selections.
     *
     * @return String Enhancement for select clause.
     */
    protected function addJoinsToSelection()
    {
        $selection = ', tblFiles, tblThumbSizes';
        return $selection;
    }
    
    /**
     * Helper method to add joins to from clause.
     *
     * @param Doctrine\ORM\QueryBuilder $qb query builder instance used to create the query.
     *
     * @return String Enhancement for from clause.
     */
    protected function addJoinsToFrom(QueryBuilder $qb)
    {
        $qb->leftJoin('tbl.files', 'tblFiles');
        $qb->leftJoin('tbl.thumbSizes', 'tblThumbSizes');
        return $qb;
    }
}
