<?php
/**
 * MediaRepository.
 *
 * @copyright Timothy Paustian
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package MediaRepository
 * @author Tim Paustian.
 * @link http://zikula.de
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.5.5 (http://modulestudio.de) at Fri Jun 22 18:45:35 CEST 2012.
 */

/**
 * This handler class handles the page events of the Form called by the MediaRepository_admin_edit() function.
 * It aims on the medium object type.
 */
class MediaRepository_Form_Handler_Admin_Medium_Edit extends MediaRepository_Form_Handler_Admin_Medium_Base_Edit {

    // feel free to extend the base handler class here
    private $_currRepo = null;

    public function postInitialize() {
        parent::postInitialize();

        $allRepositories = ModUtil::apiFunc($this->name, 'selection', 'getEntities', array('ot' => 'repository'));
        $repositoryItems = array();
        foreach ($allRepositories as $repository) {
            $repositoryItems[] = array('value' => $repository['id'], 'text' =>
                $repository['name']);
            if ($this->mode == 'edit') {
                //We are about to present the form, so lets find if it is connected
                //to a repository. The following line grabs the Repository Table data
                //Here we walk through each repository, get the medium files associated with it (getFiles)
                //The calls contains on its collection of medium files
                // if the collection of files contains the file we are editing, then we set the incomingID to it
                //This will then set the repository correctly.
                if ($repository->getFiles()->contains($this->entityRef)) {
                    if ($this->incomingIds['repository'] == 0) {
                        $this->incomingIds['repository'] = $repository->getID();
                    }
                    $this->_currRepo = $repository;
                }
            }
        }

        $medium = $this->view->get_template_vars('medium');
        $medium['repositoryItems'] = $repositoryItems;
        //Set the repository that this file belongs to. We determined this in initialize.

        $medium['repository'] = $this->incomingIds['repository']; // selected value


        $this->view->assign('medium', $medium);
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
    public function initialize(Zikula_Form_View $view) {


        parent::initialize($view);

        $entity = $this->entityRef;

        $entityData = $entity->toArray();
        //we need to convert the userid to a username
        $owner = UserUtil::getVars($entityData['owner']);
        if ($owner) {
            $entityData['ownerSelector'] = $owner['uname'];
        }
        // assign data to template as array (makes translatable support easier)
        $this->view->assign($this->objectTypeLower, $entityData);

        //this grabs the respository id from the form, it also 
        //gives it as an array and the incomingIds expects just he id
        //so we pull it out of the array.
        //note that I had to take some code out of the Base class to prevent it from
        //stomping on this code and changing incomingIds['repository'
        $medRepo = $this->request->request->get('repository', '');
        $this->incomingIds['repository'] = 0;
        if ($medRepo) {
            $this->incomingIds['repository'] = $medRepo[0];
        }
        // everything okay, no initialization errors occured
        return true;
    }

    /**
     * Executing insert and update statements
     *
     * @param Array   $args    arguments from handleCommand method.
     */
    public function performUpdate($args) {
        // get treated entity reference from persisted member var
        $entity = $this->entityRef;

        $this->updateRelationLinks($entity);
        //$this->entityManager->transactional(function($entityManager) {
        $this->entityManager->persist($entity);
        $this->entityManager->flush();
        //});
        // save incoming relationship from parent entity
        //this saves it for the parent entity, but I have to figure out how to grab this
        //and put it into the form upon a desire to update this information
        if (($args['commandName'] == 'create') || ($args['commandName'] == 'update')) {
            if (!empty($this->incomingIds['repository'])) {
                $relObj = ModUtil::apiFunc($this->name, 'selection', 'getEntity', array('ot' => 'repository', 'id' => $this->incomingIds['repository']));
                if ($relObj != null) {
                    //The data may have changed for this file, I should store the old repository
                    //and see if it has changed.
                    if ($this->_currRepo != null) {
                        if ($this->_currRepo->getID() != $relObj->getID()) {
                            //remove the reference to the file from the old repo
                            $this->_currRepo->removeFiles($entity);
                            $relObj->addFiles($entity);
                        }
                    } else {
                        $relObj->addFiles($entity);
                    }
                }
                $this->entityManager->flush();
            }
        }
    }

}

