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
 * Colour field plugin including colour picker.
 *
 * The allowed formats are '#RRGGBB' and '#RGB'.
 *
 * You can also use all of the features from the Zikula_Form_Plugin_TextInput plugin since
 * the colour input inherits from it.
 */
class MediaRepository_Form_Plugin_Base_ColourInput extends Zikula_Form_Plugin_TextInput
{
    /**
     * Get filename of this file.
     * The information is used to re-establish the plugins on postback.
     *
     * @return string
     */
    public function getFilename()
    {
        return __FILE__;
    }

    /**
     * Create event handler.
     *
     * @param Zikula_Form_View $view    Reference to Zikula_Form_View object.
     * @param array            &$params Parameters passed from the Smarty plugin function.
     *
     * @see    Zikula_Form_AbstractPlugin
     * @return void
     */
    public function create(Zikula_Form_View $view, &$params)
    {
        $params['maxLength'] = 7;
        $params['width'] = '8em';

        // let parent plugin do the work in detail
        parent::create($view, $params);
    }

    /**
     * Helper method to determine css class.
     *
     * @see    Zikula_Form_Plugin_TextInput
     *
     * @return string the list of css classes to apply
     */
    protected function getStyleClass()
    {
        $class = parent::getStyleClass();
        return str_replace('z-form-text', 'z-form-colour', $class);
    }

    /**
     * Render event handler.
     *
     * @param Zikula_Form_View $view Reference to Zikula_Form_View object.
     *
     * @return string The rendered output
     */
    public function render(Zikula_Form_View $view)
    {
        static $firstTime = true;
        if ($firstTime) {
            PageUtil::addVar('stylesheet', 'javascript/picky_color/picky_color.css');
            PageUtil::addVar('javascript', 'javascript/picky_color/picky_color.js');
        }
        $firstTime = false;

        $dom = ZLanguage::getModuleDomain('MediaRepository');

        $result = parent::render($view);

        if ($this->readOnly) {
            return $result;
        }

        $result .= "<script type=\"text/javascript\" charset=\"utf-8\">
            /* <![CDATA[ */
                var namePicky = new PickyColor({
                    field: '" . $this->id . "',
                    color: '" . DataUtil::formatForDisplay($this->text) . "',
                    colorWell: '" . $this->id . "',
                    closeText: '" . __('Close', $dom) . "'
                })
            /* ]]> */
            </script>";

        return $result;
    }

    /**
     * Parses a value.
     *
     * @param Zikula_Form_View $view Reference to Zikula_Form_View object.
     * @param string           $text Text.
     *
     * @return string Parsed Text.
     */
    public function parseValue(Zikula_Form_View $view, $text)
    {
        if (empty($text)) {
            return null;
        }

        return $text;
    }

    /**
     * Validates the input string.
     *
     * @param Zikula_Form_View $view Reference to Zikula_Form_View object.
     *
     * @return boolean
     */
    public function validate(Zikula_Form_View $view)
    {
        parent::validate($view);

        if (!$this->isValid) {
            return false;
        }

        if (strlen($this->text) > 0) {
            $regex = '/^#?(([a-fA-F0-9]{3}){1,2})$/';
            $result = preg_match($regex, $this->entity[$this->id]);
            if (!$result) {
                $this->setError(__('Error! Invalid colour.'));
                return false;
            }
        }
    }
}
