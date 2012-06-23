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
 * This is the base validation class for media handler entities.
 */
class MediaRepository_Entity_Validator_Base_MediaHandler extends MediaRepository_Validator
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
        if (!$this->isStringNotLongerThan('mimeType', 50)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('mimeType', 50), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotEmpty('mimeType')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('mimeType'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('fileType', 20)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('fileType', 20), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotEmpty('fileType')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('fileType'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('foundMimeType', 50)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('foundMimeType', 50), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotEmpty('foundMimeType')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('foundMimeType'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('foundFileType', 50)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('foundFileType', 50), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotEmpty('foundFileType')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('foundFileType'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('handlerName', 50)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('handlerName', 50), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotEmpty('handlerName')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('handlerName'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('title', 50)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('title', 50), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotEmpty('title')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('title'), $dom);
            return $errorInfo;
        }
        if (!$this->isValidBoolean('active')) {
            $errorInfo['message'] = __f('Error! Field value must be a valid boolean (%s).', array('active'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('image', 255)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('image', 255), $dom);
            return $errorInfo;
        }
        
        return true;
    }
    
    /**
     * Check for unique values.
     *
     * This method determines if there already exist media handlers with the same media handler.
     *
     * @param string $fieldName The name of the property to be checked
     * @return boolean result of this check, true if the given media handler does not already exist
     */
    public function isUniqueValue($fieldName)
    {
        if (empty($this->entity[$fieldName])) {
            return false;
        }
    
        $serviceManager = ServiceUtil::getManager();
        $entityManager = $serviceManager->getService('doctrine.entitymanager');
        $repository = $entityManager->getRepository('MediaRepository_Entity_MediaHandler');
    
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
