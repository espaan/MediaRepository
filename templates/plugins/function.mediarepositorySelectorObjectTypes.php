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
 * The mediarepositorySelectorObjectTypes plugin provides items for a dropdown selector.
 *
 * Available parameters:
 *   - assign:   If set, the results are assigned to the corresponding variable instead of printed out.
 *
 * @param  array            $params  All attributes passed to this function from the template.
 * @param  Zikula_Form_View $view    Reference to the view object.
 *
 * @return string The output of the plugin.
 */
function smarty_function_mediarepositorySelectorObjectTypes($params, $view)
{
    $result = array();

    $result[] = array('text' => $view->__('Repositories'), 'value' => 'repository');
    $result[] = array('text' => $view->__('Media handlers'), 'value' => 'mediaHandler');
    $result[] = array('text' => $view->__('Media'), 'value' => 'medium');
    $result[] = array('text' => $view->__('Thumb sizes'), 'value' => 'thumbSize');

    if (array_key_exists('assign', $params)) {
        $view->assign($params['assign'], $result);
        return;
    }
    return $result;
}
