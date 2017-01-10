//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require jquery-fileupload/basic
//= require jquery-fileupload/jquery.fileupload-process
//= require jquery-fileupload/jquery.fileupload-validate
//= require twitter/typeahead
//= require local_time
//= require jquery.Jcrop
//= require pagedown_bootstrap
//= require highlight.pack.js
//= require_tree .

$(document).ready(ready)

function ready() {

  userEdit();
  
  set_autocomplete();

  $('[data-toggle="tooltip"]').tooltip()

  $('textarea.wmd-input').each(function(i, input) {
    var attr, converter, editor;
    attr = $(input).attr('id').split('wmd-input')[1];
    converter = new Markdown.Converter();
    Markdown.Extra.init(converter, {highlighter: "highlight"});
    editor = new Markdown.Editor(converter, attr);
    return editor.run();
  });

  $('.markdown-output').each(function(i, input) {
    var converter = Markdown.getSanitizingConverter();
    Markdown.Extra.init(converter, {highlighter: "highlight"});
    $(input).html(converter.makeHtml($(input).text()));
  });

  $('pre code').each(function(i, block) {
    hljs.highlightBlock(block);
  });

}

