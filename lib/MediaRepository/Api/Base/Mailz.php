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
    	 * @version Generated by ModuleStudio 0.5.5 (http://modulestudio.de) at Fri Jun 22 18:45:37 CEST 2012.
    	 */
    	
/**
 * Mailz api base class.
 */
class MediaRepository_Api_Base_Mailz extends Zikula_AbstractApi
{
    /**
     * Get mailz plugins with type / title.
     *
     * @param array $args List of arguments.
     *
     * @return array List of provided plugin functions.
     */
    public function getPlugins($args)
    {
        $plugins = array();
        $plugins[] = array(
            'pluginid'      => 1,
            'module'        => 'MediaRepository',
            'title'         => $this->__('3 newest media'),
            'description'   => $this->__('A list of the three newest media.')
        );
        $plugins[] = array(
            'pluginid'      => 2,
            'module'        => 'MediaRepository',
            'title'         => $this->__('3 random media'),
            'description'   => $this->__('A list of three random media.')
        );
        return $plugins;
    }
    
    /**
     * Get content for plugins.
     *
     * @param array    $args                List of arguments.
     * @param int      $args['pluginid']    id number of plugin (internal id for this module, see getPlugins method).
     * @param string   $args['params']      optional, show specific one or all otherwise.
     * @param int      $args['uid']         optional, user id for user specific content.
     * @param string   $args['contenttype'] h or t for html or text.
     * @param datetime $args['last']        timestamp of last newsletter.
     *
     * @return string output of plugin template.
     */
    public function getContent($args)
    {
        ModUtil::initOOModule('MediaRepository');
        // $args is something like:
        // Array ( [uid] => 5 [contenttype] => h [pluginid] => 1 [nid] => 1 [last] => 0000-00-00 00:00:00 [params] => Array ( [] => ) ) 1
        $objectType = 'medium';
    
        $serviceManager = ServiceUtil::getManager();
        $entityManager = $serviceManager->getService('doctrine.entitymanager');
        $repository = $entityManager->getRepository('MediaRepository_Entity_' . ucfirst($objectType));
    
        $idFields = ModUtil::apiFunc('MediaRepository', 'selection', 'getIdFields', array('ot' => $objectType));
    
        $sortParam = '';
        if ($args['pluginid'] == 2) {
            $sortParam = 'RAND()';
        } elseif ($args['pluginid'] == 1) {
            if (count($idFields) == 1) {
                $sortParam = $idFields[0] . ' DESC';
            } else {
                foreach ($idFields as $idField) {
                    if (!empty($sortParam)) {
                        $sortParam .= ', ';
                    }
                    $sortParam .= $idField . ' ASC';
                }
            }
        }
    
        $where = ''/*$this->filter*/;
        $resultsPerPage = 3;
    
        // get objects from database
        $selectionArgs = array(
            'ot' => $objectType,
            'where' => $where,
            'orderBy' => $sortParam,
            'currentPage' => 1,
            'resultsPerPage' => $resultsPerPage
        );
        list($entities, $objectCount) = ModUtil::apiFunc('MediaRepository', 'selection', 'getEntitiesPaginated', $selectionArgs);
    
        $view = Zikula_View::getInstance('MediaRepository', true);
    
        //$data = array('sorting' => $this->sorting, 'amount' => $this->amount, 'filter' => $this->filter, 'template' => $this->template);
        //$view->assign('vars', $data);
    
        $view->assign('objectType', 'medium')
             ->assign('items', $entities)
             ->assign($repository->getAdditionalTemplateParameters('api', array('name' => 'mailz')));
    
        if ($args['contenttype'] == 't') { /* text */
            return $view->fetch('mailz/itemlist_medium_text.tpl');
        } else {
            //return $view->fetch('contenttype/itemlist_display.html');
            return $view->fetch('mailz/itemlist_medium_html.tpl');
        }
    }
}
