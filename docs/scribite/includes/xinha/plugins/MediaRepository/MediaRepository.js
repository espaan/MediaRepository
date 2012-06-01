// MediaRepository plugin for Xinha
// developed by Axel Guckelsberger
//
// requires MediaRepository module (http://zikula.de)
//
// Distributed under the same terms as xinha itself.
// This notice MUST stay intact for use (see license.txt).

'use strict';

function MediaRepository(editor) {
    var cfg, self;

    this.editor = editor;
    cfg = editor.config;
    self = this;

    cfg.registerButton({
        id       : 'MediaRepository',
        tooltip  : 'Insert MediaRepository object',
     // image    : _editor_url + 'plugins/MediaRepository/img/ed_MediaRepository.gif',
        image    : '/images/icons/extrasmall/favorites.png',
        textMode : false,
        action   : function (editor) {
            var url = Zikula.Config.baseURL + 'index.php'/*Zikula.Config.entrypoint*/ + '?module=MediaRepository&type=external&func=finder&editor=xinha';
            MediaRepositoryFinderXinha(editor, url);
        }
    });
    cfg.addToolbarElement('MediaRepository', 'insertimage', 1);
}

MediaRepository._pluginInfo = {
    name          : 'MediaRepository for xinha',
    version       : '1.0.0',
    developer     : 'Axel Guckelsberger',
    developer_url : 'http://zikula.de',
    sponsor       : 'ModuleStudio 0.5.5',
    sponsor_url   : 'http://modulestudio.de',
    license       : 'htmlArea'
};
