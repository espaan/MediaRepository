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
 * Event handler implementation class for user-related events.
 */
class MediaRepository_Listener_User
{
    /**
     * Listener for the `user.gettheme` event.
     *
     * Called during UserUtil::getTheme() and is used to filter the results.
     * Receives arg['type'] with the type of result to be filtered
     * and the $themeName in the $event->data which can be modified.
     * Must $event->stop() if handler performs filter.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function getTheme(Zikula_Event $event)
    {
    }
    
    /**
     * Listener for the `user.account.create` event.
     *
     * Occurs after a user account is created. All handlers are notified.
     * It does not apply to creation of a pending registration.
     * The full user record created is available as the subject.
     * This is a storage-level event, not a UI event. It should not be used for UI-level actions such as redirects.
     * The subject of the event is set to the user record that was created.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function create(Zikula_Event $event)
    {
    }
    
    /**
     * Listener for the `user.account.update` event.
     *
     * Occurs after a user is updated. All handlers are notified.
     * The full updated user record is available as the subject.
     * This is a storage-level event, not a UI event. It should not be used for UI-level actions such as redirects.
     * The subject of the event is set to the user record, with the updated values.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function update(Zikula_Event $event)
    {
    }
    
    /**
     * Listener for the `user.account.delete` event.
     *
     * Occurs after a user is deleted from the system.
     * All handlers are notified.
     * The full user record deleted is available as the subject.
     * This is a storage-level event, not a UI event. It should not be used for UI-level actions such as redirects.
     * The subject of the event is set to the user record that is being deleted.
     *
     * @param Zikula_Event $event The event instance.
     */
    public static function delete(Zikula_Event $event)
    {
    	$userRecord = $event->getSubject();
    	$uid = $userRecord['uid'];
    	$serviceManager = ServiceUtil::getManager();
    	$entityManager = $serviceManager->getService('doctrine.entitymanager');
    	
    	$repo = $entityManager->getRepository('MediaRepository_Entity_Repository');
    	// delete all repositories created by this user
    	$repo->deleteCreator($uid);
    	// note you could also do: $repo->updateCreator($uid, 2);
    	
    	// set last editor to admin (2) for all repositories updated by this user
    	$repo->updateLastEditor($uid, 2);
    	// note you could also do: $repo->deleteLastEditor($uid);
    	
    	$repo = $entityManager->getRepository('MediaRepository_Entity_MediaHandler');
    	// delete all media handlers created by this user
    	$repo->deleteCreator($uid);
    	// note you could also do: $repo->updateCreator($uid, 2);
    	
    	// set last editor to admin (2) for all media handlers updated by this user
    	$repo->updateLastEditor($uid, 2);
    	// note you could also do: $repo->deleteLastEditor($uid);
    	
    	$repo = $entityManager->getRepository('MediaRepository_Entity_Medium');
    	// delete all media created by this user
    	$repo->deleteCreator($uid);
    	// note you could also do: $repo->updateCreator($uid, 2);
    	
    	// set last editor to admin (2) for all media updated by this user
    	$repo->updateLastEditor($uid, 2);
    	// note you could also do: $repo->deleteLastEditor($uid);
    	// set owner to guest (1) for all affected media
    	$repo->updateUserField('owner', $uid, 1);
    	
    	$repo = $entityManager->getRepository('MediaRepository_Entity_ThumbSize');
    	// delete all thumb sizes created by this user
    	$repo->deleteCreator($uid);
    	// note you could also do: $repo->updateCreator($uid, 2);
    	
    	// set last editor to admin (2) for all thumb sizes updated by this user
    	$repo->updateLastEditor($uid, 2);
    	// note you could also do: $repo->deleteLastEditor($uid);
    }
}
