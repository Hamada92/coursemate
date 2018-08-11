import Markdown from 'pagedown-with-extra-bootstrap/pagedown.js';
import hljs from 'highlightjs/highlight.pack.js'

export default function initiate_editor(){
  $('textarea.wmd-input').each(function(i, input) {
    var attr, converter, editor;
    attr = $(input).attr('id').split('wmd-input')[1];
    converter = new Markdown.Converter();
    Markdown.Extra.init(converter, {highlighter: "highlight"});
    editor = new Markdown.Editor(converter, attr);
    return editor.run();
  });

  $('pre code').each(function(i, block) {
    hljs.highlightBlock(block);
  });
};
