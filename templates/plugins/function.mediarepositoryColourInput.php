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
 * The mediarepositoryColourInput plugin handles fields carrying a html colour code.
 * It provides a colour picker for convenient editing.
 *
 * @param  array            $params  All attributes passed to this function from the template.
 * @param  Zikula_Form_View $view    Reference to the view object.
 *
 * @return string The output of the plugin.
 */
function smarty_function_mediarepositoryColourInput($params, $view)
{
    return $view->registerPlugin('MediaRepository_Form_Plugin_ColourInput', $params);
}