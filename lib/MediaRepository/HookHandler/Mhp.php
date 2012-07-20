<?php

/**
 * Copyright 2012 Zikula Foundation.
 *
 * This work is contributed to the Zikula Foundation under one or more
 * Contributor Agreements and licensed to You under the following license:
 *
 * @license MIT
 *
 * Please see the NOTICE file distributed with this source code for further
 * information regarding copyright and licensing.
 */
class MediaRepository_HookHandler_Mhp extends Zikula_Hook_AbstractHandler {

    /**
     * Zikula_View instance
     *
     * @var Zikula_View
     */
    private $view;

    /**
     * Post constructor hook.
     *
     * @return void
     */
    public function setup() {
        $this->view = Zikula_View::getInstance("MediaRepository");
    }

    /**
     * Display hook for view.
     *
     * Subject is the object being viewed that we're attaching to.
     * args[id] is the id of the object.
     * args[caller] the module who notified of this event.
     *
     * @param Zikula_Hook $hook
     *
     * @return void
     */
    public function ui_view(Zikula_DisplayHook $hook) {
        // Security check
        if (!SecurityUtil::checkPermission('MediaRepository::', '::', ACCESS_OVERVIEW)) {
            return;
        }
        $is_admin = SecurityUtil::checkPermission('MediaRepository::', '::', ACCESS_ADMIN);
        //get the id of the caller
        $id = $hook->getId();
        //look for it in our exam database

        //$q_ids = DataUtil::formatForDisplay(serialize($q_ids));
        //$this->view->assign('letters', $letters);
        //if ($is_admin) {
         //   $this->view->assign('admin', 'yes');
        //}
        // add this response to the event stack
        $response = new Zikula_Response_DisplayHook('provider.MediaRespository.ui_hooks.mhp', $this->view, 'mediarepository_hook_uiview.tpl');
        $hook->setResponse($response);
    }

    /**
     * Display hook for edit views.
     *
     * Subject is the object being created/edited that we're attaching to.
     * args[id] Is the ID of the subject.
     * args[caller] the module who notified of this event.
     *
     * @param Zikula_Hook $hook
     *
     * @return void
     */
    public function ui_edit(Zikula_DisplayHook $hook) {
        //I am thinking we really don't have a response to editing something
        //we only want to deal with it if it is deleted.
        // add this response to the event stack
        $response = new Zikula_Response_DisplayHook('provider.Quickcheck.ui_hooks.mhp', $this->view, 'MediaRepository_hook_mhp_ui_edit.tpl');
        $hook->setResponse($response);
    }

    /**
     * Display hook for delete views.
     *
     * Subject is the object being created/edited that we're attaching to.
     * args[id] Is the ID of the subject.
     * args[caller] the module who notified of this event.
     *
     * @param Zikula_Hook $hook
     *
     * @return void
     */
    public function ui_delete(Zikula_DisplayHook $hook) {
        // Security check
        if (!SecurityUtil::checkPermission('Quickcheck::', '::', ACCESS_DELETE)) {
            return;
        }
        $id = $hook->getId();
        if ($id) {
            //Check to see if we have an exam attached to this ID
            $exam = modUtil::apiFunc('quickcheck', 'user', 'get', array('art_id' => $id));
            //if we have an exam, detach it from the hooked sample.
            if ($exam) {
                $exam['art_id'] = -1; //no article attached
                modUtil::apiFunc('quickcheck', 'admin', 'update', $exam);
            }
        }
        //we don't need to respond to this. We just detach the exam.
        // add this response to the event stack
//        $response = new Zikula_Response_DisplayHook('provider.Quickcheck.ui_hooks.mhp', $this->view, '');
        //      $hook->setResponse($response);
    }

    /**
     * process edit hook handler.
     *
     * This should be executed only if the validation has succeeded.
     * This is used for both new and edit actions.  We can determine which
     * by the presence of an ID field or not.
     *
     * Subject is the object being created/edited that we're attaching to.
     * args[id] Is the ID of the subject.
     * args[caller] the module who notified of this event.
     *
     * @param Zikula_Hook $hook
     *
     * @return void
     */
    public function process_edit(Zikula_ProcessHook $hook) {

        if (!$hook->getId()) {
            // new so do an INSERT
        } else {
            // existing so do an UPDATE
        }
    }

    /**
     * delete process hook handler.
     *
     * The subject should be the object that was deleted.
     * args[id] Is the is of the object
     * args[caller] is the name of who notified this event.
     *
     * @param Zikula_Hook $hook
     *
     * @return void
     */
    public function process_delete(Zikula_ProcessHook $hook) {
        // this example does not have an data stored in database to delete
        // however, if i had any, i would execute a db call here to delete them
    }

}

?>
