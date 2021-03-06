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
 * This is the base validation class for repository entities.
 */
class MediaRepository_Entity_Validator_Base_Repository extends MediaRepository_Validator
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
        if (!$this->isStringNotLongerThan('name', 255)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('name', 255), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotEmpty('name')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('name'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('workDirectory', 255)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('workDirectory', 255), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotEmpty('workDirectory')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('workDirectory'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('storageDirectory', 255)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('storageDirectory', 255), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotEmpty('storageDirectory')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('storageDirectory'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('cacheDirectory', 255)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('cacheDirectory', 255), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotEmpty('cacheDirectory')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('cacheDirectory'), $dom);
            return $errorInfo;
        }
        if (!$this->isValidInteger('storageMode')) {
            $errorInfo['message'] = __f('Error! Field value may only contain digits (%s).', array('storageMode'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotEmpty('storageMode')) {
            $errorInfo['message'] = __f('Error! Field value must not be 0 (%s).', array('storageMode'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotLongerThan('storageMode', 2)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('storageMode', 2), $dom);
            return $errorInfo;
        }
        if (!$this->isValidInteger('permissionScope')) {
            $errorInfo['message'] = __f('Error! Field value may only contain digits (%s).', array('permissionScope'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotEmpty('permissionScope')) {
            $errorInfo['message'] = __f('Error! Field value must not be 0 (%s).', array('permissionScope'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotLongerThan('permissionScope', 4)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('permissionScope', 4), $dom);
            return $errorInfo;
        }
        if (!$this->isValidBoolean('useQuota')) {
            $errorInfo['message'] = __f('Error! Field value must be a valid boolean (%s).', array('useQuota'), $dom);
            return $errorInfo;
        }
        if (!$this->isValidBoolean('allowManagementOfOwnFiles')) {
            $errorInfo['message'] = __f('Error! Field value must be a valid boolean (%s).', array('allowManagementOfOwnFiles'), $dom);
            return $errorInfo;
        }
        if (!$this->isValidBoolean('allowFileMailing')) {
            $errorInfo['message'] = __f('Error! Field value must be a valid boolean (%s).', array('allowFileMailing'), $dom);
            return $errorInfo;
        }
        if (!$this->isValidInteger('maxSizeForMail')) {
            $errorInfo['message'] = __f('Error! Field value may only contain digits (%s).', array('maxSizeForMail'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotLongerThan('maxSizeForMail', 11)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('maxSizeForMail', 11), $dom);
            return $errorInfo;
        }
        if (!$this->isValidInteger('maxFilesPerUpload')) {
            $errorInfo['message'] = __f('Error! Field value may only contain digits (%s).', array('maxFilesPerUpload'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotEmpty('maxFilesPerUpload')) {
            $errorInfo['message'] = __f('Error! Field value must not be 0 (%s).', array('maxFilesPerUpload'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotLongerThan('maxFilesPerUpload', 2)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('maxFilesPerUpload', 2), $dom);
            return $errorInfo;
        }
        if (!$this->isValidInteger('maxUploadFileSize')) {
            $errorInfo['message'] = __f('Error! Field value may only contain digits (%s).', array('maxUploadFileSize'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotLongerThan('maxUploadFileSize', 11)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('maxUploadFileSize', 11), $dom);
            return $errorInfo;
        }
        if (!$this->isValidInteger('uploadNamingConvention')) {
            $errorInfo['message'] = __f('Error! Field value may only contain digits (%s).', array('uploadNamingConvention'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotEmpty('uploadNamingConvention')) {
            $errorInfo['message'] = __f('Error! Field value must not be 0 (%s).', array('uploadNamingConvention'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotLongerThan('uploadNamingConvention', 2)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('uploadNamingConvention', 2), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('uploadNamingPrefix', 50)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('uploadNamingPrefix', 50), $dom);
            return $errorInfo;
        }
        if (!$this->isValidBoolean('enableSharpen')) {
            $errorInfo['message'] = __f('Error! Field value must be a valid boolean (%s).', array('enableSharpen'), $dom);
            return $errorInfo;
        }
        if (!$this->isValidBoolean('enableShrinking')) {
            $errorInfo['message'] = __f('Error! Field value must be a valid boolean (%s).', array('enableShrinking'), $dom);
            return $errorInfo;
        }
        if (!$this->isValidBoolean('useThumbCropper')) {
            $errorInfo['message'] = __f('Error! Field value must be a valid boolean (%s).', array('useThumbCropper'), $dom);
            return $errorInfo;
        }
        if (!$this->isValidInteger('cropSizeMode')) {
            $errorInfo['message'] = __f('Error! Field value may only contain digits (%s).', array('cropSizeMode'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotLongerThan('cropSizeMode', 2)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('cropSizeMode', 2), $dom);
            return $errorInfo;
        }
        if (!$this->isValidInteger('downloadMode')) {
            $errorInfo['message'] = __f('Error! Field value may only contain digits (%s).', array('downloadMode'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotEmpty('downloadMode')) {
            $errorInfo['message'] = __f('Error! Field value must not be 0 (%s).', array('downloadMode'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotLongerThan('downloadMode', 2)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('downloadMode', 2), $dom);
            return $errorInfo;
        }
        if (!$this->isValidBoolean('sendMailAfterUpload')) {
            $errorInfo['message'] = __f('Error! Field value must be a valid boolean (%s).', array('sendMailAfterUpload'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('mailRecipient', 255)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('mailRecipient', 255), $dom);
            return $errorInfo;
        }
        
        return true;
    }
    
    /**
     * Check for unique values.
     *
     * This method determines if there already exist repositories with the same repository.
     *
     * @param string $fieldName The name of the property to be checked
     * @return boolean result of this check, true if the given repository does not already exist
     */
    public function isUniqueValue($fieldName)
    {
        if (empty($this->entity[$fieldName])) {
            return false;
        }
    
        $serviceManager = ServiceUtil::getManager();
        $entityManager = $serviceManager->getService('doctrine.entitymanager');
        $repository = $entityManager->getRepository('MediaRepository_Entity_Repository');
    
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
