/*
 * version: jmodal 4.0.1 25.08.2013
 * author: hmelii
 * email: anufry@inbox.ru
 */

(function ($) {

    var imgRegExp = /\.(jpg|gif|png|bmp|jpeg)(.*)?$/i;


    var methods = {

        init: function (options) {


            return this.each(function (index, element) {

                var settings = {
                    modalId: '#js-modal',
                    modalBodyClass: '.js-modal__body',
                    keyboard: true,
                    modalClassHide: 'hidden',
                    modalClassShow: 'show',
                    modalClassClose: 'js-modal_hide',
                    remote: null,
                    link: false,
                    template: true,
                    element: null,
                    beforeShow: function () {
                    },
                    afterShow: function () {
                    },
                    afterHide: function () {
                    },
                    beforeHide: function () {
                    }
                };

                var $element = $(element);

                var data = $element.data('modal');

                options = options || {};


                if (!$element.hasClass('js-modal_template') && $element.prop('tagName') != 'SCRIPT' && !options.link) {

                    options.template = false;
                    options.modalId = '#' + $element.attr('id');


                }


                if (data) {
                    settings = $.extend(data.settings, options || {});
                } else {
                    settings = $.extend(settings, options || {});
                }


                $element.data('modal', {
                    content: $element.html(),
                    settings: settings
                });


                data = $element.data('modal');


                //console.log('init');


            });
        },

        toggle: function () {

            return this.each(function (index, element) {
                var $element = $(element);
                var data = $element.data('modal');

                if (!data) {
                    $element.jmodal();
                    data = $element.data('modal');
                }

                data.isShown ? $element.jmodal('hide') : $element.jmodal('show');


            });

        },


        show: function () {

            return this.each(function (index, element) {

                var $element = $(element);
                var data = $element.data('modal');

                if (!data) {

                    $element.jmodal();
                    data = $element.data('modal');

                }

                if (methods.element) {
                    methods.newElement = $element;
                    methods.oldElement = methods.element;
                    methods.element.jmodal('hide');
                }


                var settings = data.settings;
                var $modal = $(settings.modalId);
                var $modalBody = $modal.find(settings.modalBodyClass);
                var $body = $(document.body);
                var $html = $(document.documentElement);
                var bodyWidth = $body.width();
                var htmlScrollTop = $html.scrollTop();

                methods.element = $element;
                methods.isShown = true;
                data.isShown = true;

                settings.beforeShow($modal[0], settings.element);

                if (!methods.newElement || (methods.newElement && methods.newElement.data('modal').settings.modalId != methods.oldElement.data('modal').settings.modalId)) {

                    $html
                        .data('modal', {
                            scrollTop: htmlScrollTop
                        })
                        .css('overflow', 'hidden')
                        .scrollTop(htmlScrollTop);


                    var bodyWidthWithoutHtmlScroll = $body.width();
                    var htmlScrollWidth = bodyWidthWithoutHtmlScroll - bodyWidth;

                    $html.css('paddingRight', htmlScrollWidth + 'px');



                    $modal.removeClass(settings.modalClassHide).addClass(settings.modalClassShow);

                }


                methods.escape($element);
                methods.close($element);


                if (settings.link) {
                    var href = $element.attr('href');

                    if (href.match(imgRegExp)) {

                        var title = $element.attr('title') || '';
                        $modalBody.html('<img src="' + href + '" alt="' + title + '" />');


                        settings.afterShow($modal[0], settings.element);


                    } else if ($element.data('modal-type') == 'frame') {

                        $modalBody.html('<iframe id="modal_frame" name="modal_frame' + new Date().getTime() + '" frameborder="0" hspace="0" allowtransparency="true" src="' + href + '" width="640" height="390"></iframe>');


                        settings.afterShow($modal[0], settings.element);


                    } else {
                        $modalBody.load(href, function () {

                            settings.afterShow($modal[0], settings.element);

                        });

                    }
                } else {
                    if (settings.template) {

                        $modalBody.html(data.content);

                    }


                    settings.afterShow($modal[0], settings.element);

                }

                methods.newElement = null;


                //console.log('show');

            });

        },

        hide: function () {

            return this.each(function (index, element) {
                var $element = $(element);
                var data = $element.data('modal');
                if (!data) {
                    $element.jmodal();
                    data = $element.data('modal');
                }

                var settings = data.settings;
                var $modal = $(settings.modalId);
                var $modalBody = $modal.find(settings.modalBodyClass);
                var $html = $(document.documentElement);
                var htmlData = $html.data('modal');

                methods.element = null;

                methods.isShown = false;
                data.isShown = false;


                settings.beforeHide($modal[0], settings.element);


                //data.content = $modalBody.children().clone();
                if (settings.template) {
                    $modalBody.html('');
                }


                if (!methods.newElement || methods.newElement.data('modal').settings.modalId != settings.modalId) {
                    $modal.removeClass(settings.modalClassShow).addClass(settings.modalClassHide);
                    $html.css({'overflow': '', 'paddingRight': ''}).scrollTop(htmlData.scrollTop);
                }

                methods.escape($element);
                methods.close($element);


                settings.afterHide($modal[0], settings.element);


                //console.log('hide');

            });


        },

        close: function ($element) {
            var $html = $(document.documentElement);
            var data = $element.data('modal');
            var settings = data.settings;

            if (methods.isShown) {
                //console.log('добавили close');
                $html.on('click.dissmiss.modal', function (event) {
                    if (event.target.className.indexOf(settings.modalClassClose) > -1) {
                        event.preventDefault();
                        $element.jmodal('hide');
                    }
                });
            } else if (!methods.isShown) {
                //console.log('убрали close');
                $html.off('click.dissmiss.modal');
            }
        },

        escape: function ($element) {
            var $html = $(document.documentElement);
            var data = $element.data('modal');
            var settings = data.settings;

            if (methods.isShown && settings.keyboard) {
                //console.log('добавили esc');
                $html.on('keyup.dismiss.modal', function (event) {
                    if (event.which == 27) {
                        $element.jmodal('hide');
                    }
                });
            } else if (!methods.isShown) {
                //console.log('убрали esc');
                $html.off('keyup.dismiss.modal');
            }

        }

    };

    $.fn.jmodal = function (method) {

        if (methods[method]) {

            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));

        } else if (typeof method === 'object' || !method) {

            return methods.init.apply(this, arguments);

        } else {

            $.error('Метод с именем ' + method + ' не существует для jmodal');

        }

    };

    $(document).on('click.modal.data-api', '.js-show_modal', function (event) {

        event.preventDefault();

        var $element = $(this);
        var href = $element.attr('href');
        var options = {};
        var $target;
        var template = true;

        if (!/#/.test(href)) {

            $target = $element;

            options = {
                link: true
            }


        } else {
            $target = $(href);


            options = {
                element: $element[0]

            };
        }


        $target.jmodal(options).jmodal('show');


    });


    $(document).on('click.modal.data-api', '.js-lightbox', function (event) {

        event.preventDefault();

        var $element = $(this);
        var href = $element.attr('href');

        var gal = $element.attr('data-lightbox');
        var $target = $element;
        var $modal = $('#js-modal .js-modal__body');

        var options = {
            link: true,
            afterShow: function () {


                if ($element.attr('title')) {
                    $modal.prepend('<div id="js-lightbox__title" class="lightbox__title" />');
                    $('#js-lightbox__title').html($element.attr('title'));
                }

                $modal.find('img').wrap('<div id="js-lightbox__image" class="lightbox__image" />');


                if (!gal) {
                    return;
                }

                var $gallery = $('[data-lightbox=' + gal + ']');

                var l = $gallery.length;

                var cur = 0;

                if (l < 2) {
                    return;
                }

                $gallery.each(function (index) {
                    if (this == $element[0]) {
                        cur = index;
                    }
                });


                $modal.append('<a id="js-lightbox__prev" href="#" class="lightbox__prev" /><a id="js-lightbox__next" href="#" class="lightbox__next" />');

                $('#js-lightbox__prev').on('click', function (event) {

                    event.preventDefault();

                    cur > 0 ? cur-- : cur = (l - 1);

                    $gallery.eq(cur).click();

                });

                $('#js-lightbox__next').on('click', function (event) {

                    event.preventDefault();

                    cur < (l - 1) ? cur++ : cur = 0;

                    $gallery.eq(cur).click();


                });


            }
        };


        $target.jmodal(options).jmodal('show');

    });

    $(function () {
        setTimeout(function () {
            $('.js-modal:not(.hidden),.js-modal_template:not(.hidden)').jmodal('show');

        }, 1);

    });


})(jQuery);