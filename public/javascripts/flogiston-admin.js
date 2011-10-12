jQuery(function($) {

    function set_label_widths() {
        var labels = $('label');

        if (labels.size() != 0) {
            var widths = labels.map(function(i, elem) { return $(elem).width(); }).toArray();
            var max_width = Math.max.apply(Math, widths);

            labels.width(max_width + 'px');
        }
    }

    set_label_widths();

});
