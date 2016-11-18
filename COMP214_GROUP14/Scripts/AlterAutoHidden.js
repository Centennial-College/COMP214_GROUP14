
$(document).ready(function () {

    window.setTimeout(function () {
        $(".alert").fadeTo(1000, 0).slideUp(1000, function () {
            $(this).remove();
        });
    }, 2000);
    $('[data-toggle="tooltip"]').tooltip();

});
