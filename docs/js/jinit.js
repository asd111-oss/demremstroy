var html = document.documentElement; // html element
var path = '/templates/demremstroy/'; // location scripts and styles



Modernizr.load([
    {   // if not supported attribute placeholder - load fix script
        test : Modernizr.input.placeholder,
        nope : [ path + 'js/jplaceholder.js'],
        callback : function() {

            $('[placeholder]').jplaceholder();
        }
    }


]);



$(function() {


    if(!!window.sidebar && typeof document.body.style.flex != 'undefined' || typeof document.body.style.MozBoxFlex) {
        $(html).removeClass('no-flexbox').addClass('flexbox');
    }

    if ($('.js-carousel').length) {
        initCarousel();
    }

    if ($('.js-faq').length) {
        initFaq();
    }

});

function initFaq() {
    $('.js-faq').each(function(){
        var $faq = $(this);
        var $q = $faq.find('.question .link');

        $q.click(function(){
            $(this).parents('.question').next('.answer').slideToggle('fast');
            return false;
        });

    });
}

function initCarousel() {
    $('.js-carousel').each(function() {
        var $car = $(this);

        var $list = $car.find('.list');

        var $items = $list.find('.item');

        var i = 0;
        var l = $items.length - 1;

        var $prev = $car.find('.prev');
        var $next = $car.find('.next');

        var $menu = $car.find('.menu');
        var li = '';



        for (var j=0; j<=l; j++ ) {
            li += '<li class="item"><a class="link'+(j==0?' active':'')+'" href="#"></a></li>';
        }

        $menu.html(li);

        var $a = $menu.find('.link');

        $a.each(function(index){
            $(this).click(function(){
                clearInterval(t);
                $a.eq(i).removeClass('active');
                i = index;
                $list.stop().animate({'marginLeft':'-'+i*212},500);
                $a.eq(i).addClass('active');
            });
        });

        $prev.click(function() {
            clearInterval(t);
            $a.eq(i).removeClass('active');
            i>0?i--:i=l;
            $list.stop().animate({'marginLeft':'-'+i*212},500);
            $a.eq(i).addClass('active');
            return false;
        });

        $next.click(function() {
            clearInterval(t);
            $a.eq(i).removeClass('active');
            i<l?i++:i=0;
            $list.stop().animate({'marginLeft':'-'+i*212},500);
            $a.eq(i).addClass('active');
            return false;
        });

        var t = setInterval(function() {
            $a.eq(i).removeClass('active');
            i<l?i++:i=0;
            $list.stop().animate({'marginLeft':'-'+i*212},500);
            $a.eq(i).addClass('active');
        },5000);
    });
}




		