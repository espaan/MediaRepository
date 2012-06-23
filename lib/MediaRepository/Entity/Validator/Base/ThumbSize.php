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
 * @version Generated by ModuleStudio 0.5.5 (http://modulestudio.de) at Fri Jun 22 18:45:35 CEST 2012.
 */

/**
 * Validator class for encapsulating entity validation methods.
 *
 * This is the base validation class for thumb size entities.
 */
class MediaRepository_Entity_Validator_Base_ThumbSize extends MediaRepository_Validator
{
    /**
     * Performs all validation rules.
     *
     * @return mixed either array with error information or true on success
     */
    public function validateAll()
    {
        $errorInfo = array('message' => '', 'code' => 0, 'debugArray' => array());
        $dom = ZLanguage::getModuleDomain('MediaRepository');
        if (!$this->isStringNotLongerThan('name', 100)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('name', 100), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotEmpty('name')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('name'), $dom);
            return $errorInfo;
        }
        if (!$this->isValidInteger('width')) {
            $errorInfo['message'] = __f('Error! Field value may only contain digits (%s).', array('width'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotEmpty('width')) {
            $errorInfo['message'] = __f('Error! Field value must not be 0 (%s).', array('width'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotLongerThan('width', 5)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('width', 5), $dom);
            return $errorInfo;
        }
        if (!$this->isValidInteger('height')) {
            $errorInfo['message'] = __f('Error! Field value may only contain digits (%s).', array('height'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotEmpty('height')) {
            $errorInfo['message'] = __f('Error! Field value must not be 0 (%s).', array('height'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotLongerThan('height', 5)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('height', 5), $dom);
            return $errorInfo;
        }
        if (!$this->isValidBoolean('keepAspectRatio')) {
            $errorInfo['message'] = __f('Error! Field value must be a valid boolean (%s).', array('keepAspectRatio'), $dom);
            return $errorInfo;
        }
        
        return true;
    }
    
    /**
     * Check for unique values.
     *
     * This method determines if there already exist thumb sizes with the same thumb size.
     *
     * @param string $fieldName The name of the property to be checked
     * @return boolean result of this check, true if the given thumb size does not already exist
     */
    public function isUniqueValue($fieldName)
    {
        if (empty($this->entity[$fieldName])) {
            return false;
        }
    
        $serviceManager = ServiceUtil::getManager();
        $entityManager = $serviceManager->getService('doctrine.entitymanager');
        $repository = $entityManager->getRepository('MediaRepository_Entity_ThumbSize');
    
        $excludeid = $this->entity['id'];
        return $repository->detectUniqueState($fieldName, $this->entity[$fieldName], $excludeid);
    }
    
    /**
     * Get entity.
     *
     * @return Zikula_EntityAccess
     */
    public function getEntity()
    {
        return $this->entity;
    }
    
    /**
     * Set entity.
     *
     * @param Zikula_EntityAccess $entity.
     *
     * @return void
     */
    public function setEntity(Zikula_EntityAccess $entity = null)
    {
        $this->entity = $entity;
    }
    
}
