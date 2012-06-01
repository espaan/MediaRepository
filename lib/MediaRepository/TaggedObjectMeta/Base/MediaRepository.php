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
 * This class provides object meta data for the Tag module.
 */
class MediaRepository_TaggedObjectMeta_Base_MediaRepository extends Tag_AbstractTaggedObjectMeta
{
            /**
             * Constructor.
             *
             * @param integer $objectId
             * @param integer $areaId
             * @param string $module
             * @param type $urlString **deprecated**
             * @param Zikula_ModUrl $urlObject
             */
            function __construct($objectId, $areaId, $module, $urlString = null, Zikula_ModUrl $urlObject = null)
            {
                // call base constructor to store arguments in member vars
                parent::__construct($objectId, $areaId, $module, $urlString, $urlObject);
    
                // derive object type from area
    /** TODO */
    (if not possible:
    $urlObject = $this->getUrlObject() --> Zikula_ModUrl
    )
    
    
    NEWS
            $newsItem = ModUtil::apiFunc('News', 'user', 'get', array('sid' => $this->getObjectId()));
            // the api takes care of the permissions check. we must check for pending/expiration & status
            $expired = (isset($newsItem['to']) && (strtotime($newsItem['to']) < strtotime("now")));
            $pending = (strtotime($newsItem['from']) > strtotime("now"));
            $statuspublished = ($newsItem['published_status'] == News_Api_User::STATUS_PUBLISHED);
            if ($newsItem && $statuspublished && !$pending && !$expired) {
                $this->setObjectAuthor($newsItem['contributor']);
                $this->setObjectDate($newsItem['from']);
                $this->setObjectTitle($newsItem['title']);
            }
        }
    
    CONTENT
    
            $perm = SecurityUtil::checkPermission('Content:page:', $objectId . '::', ACCESS_READ);
            if ($perm) {
                $page = ModUtil::apiFunc('Content', 'Page', 'getPage', array(
                        'id' => $this->getObjectId(),
                        'preview' => false,
                        'includeContent' => false));
                // the Page Api resolves page active status and availabilty times
                if ($page) {
                    $this->setObjectAuthor($page['uname']);
                    $this->setObjectDate($page['cr_date']);
                    $this->setObjectTitle(html_entity_decode($page['title']));
                }
            }
        }
    
    PC
            $entityManager = ServiceUtil::getService('doctrine.entitymanager');
            $pc_event = $entityManager->getRepository('PostCalendar_Entity_CalendarEvent')->find($this->getObjectId())->getOldArray();
            // check for permission and status
            $permission = SecurityUtil::checkPermission('PostCalendar::Event', "$pc_event[title]::$pc_event[eid]", ACCESS_OVERVIEW);
            $private = ($pc_event['sharing'] == 0 && $pc_event['aid'] != UserUtil::getVar('uid') && !SecurityUtil::checkPermission('PostCalendar::', '::', ACCESS_ADMIN));
            $formats = ModUtil::getVar('PostCalendar', 'pcDateFormats');
            $timeFormat = ModUtil::getVar('PostCalendar', 'pcTime24Hours') ? "G:i" : "g:i a";
            if ($pc_event && $permission && !$private) {
                $this->setObjectAuthor("");
                $this->setObjectDate($pc_event['eventStart']->format($formats['date'] . " " . $timeFormat));
                $this->setObjectTitle($pc_event['title']);
            }
        }
    
    
    
    
            /**
             * Sets the object title.
             *
             * @param string $title
             */
            public function setObjectTitle($title)
            {
                $this->title = $title;
            }
    
            /**
             * Sets the object date.
             *
             * @param string $date
             */
            public function setObjectDate($date)
            {
                $this->date = $date;
                $this->date = DateUtil::formatDatetime($date, 'datetimebrief');
            }
    
            /**
             * Sets the object author.
             *
             * @param string $author
             */
            public function setObjectAuthor($author)
            {
                $this->author = $author;
            }
}
