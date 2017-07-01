$(function(){
  $('pre > code').on('click', function(){
    var range = document.createRange();
    range.selectNodeContents(this);
    var selection = window.getSelection();
    selection.removeAllRanges();
    selection.addRange(range);
  });
});
