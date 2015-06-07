(function ($, M) {
    $('.message.error').each(function () {
        M.toast($(this).html(), 10000, 'message');
    });
})(jQuery, Materialize);
