$(document).ready(function(){
	 $('#cardNews').find('div').eq(0).addClass('current');
	 var currentNum = 0;
	 var cardNews = {
		 init:function(){
			var _this = $('#cardNews');
			_this.find('div').eq(0).addClass('current');
			_this.find('div').eq(1).css({'z-index':'3'});
			_this.find('div').not(':eq(0)').addClass('next').append('<span class="bg"></span>');
			this.setLayout();
		 },
		 setLayout:function(){
			var _self = this;
			setTimeout(function(){ _self.setCardPos(); },300);

			// Pager setting
			var _pager = '';
			_pager += '<div class="pager-wrap">';
			for(i=0; i < $('#cardNews').find('.card').length; i++){
				_pager += '<span>'+(i+1)+'</span>';
			}
			_pager += '</div>'
			$('#cardNewsWrap').append(_pager);
			$('.pager-wrap span').eq(0).addClass('active');

			_self.addEvent();
		},
		setCardPos:function(){
			var card = $('#cardNews .card');
			$('.control .left').css({'margin-left':-card.find('img').width()/2});
			$('.control .right').css({'margin-right':-card.find('img').width()/2});

			if (!($('.card').index($('.current')) == 0)) {
				$('.control .left').show();
			}else{
				$('.control .left').hide();
			}
			$('.control').css({opacity:1});

			var cardWpercent = (card.find('img').width() / $('#cardNews').width()) * 100;
			$('#cardNews').height( $('#cardNews').find('.current').height());
			card.css({width:cardWpercent+'%','margin-left':-card.find('img').width()/2});
		},
		addEvent:function(){
			var _self = this;
			$(window).resize(function(){
				var setResize = setTimeout(function(){
					$('.pager-wrap').empty().remove();
					_self.setCardPos();
				},150);
			});

			$('.control a').on('click', function(){
				if($(this).hasClass('left')){
					if(!(currentNum <= 0)){
						$('.control .left, .control .right').show();
						$('.card').eq(currentNum).css({'z-index':'3'}).addClass('next').removeClass('current').append('<span class="bg"></span>');
						$('.card').eq(currentNum-1).css({'z-index':'4'}).addClass('current').removeClass('prev').find('.bg').remove();
						$('.card').eq(currentNum+1).css({'z-index':'2'});
						currentNum--;
						if( currentNum == 0 ){ $('.control .left').hide(); }
					}
				}else{
					if(!($('.card').length -1 == currentNum)){
						$('.control .left, .control .right').show();
						$('.card').eq(currentNum).css({'z-index':'3'}).addClass('prev').removeClass('current').append('<span class="bg"></span>');
						$('.card').eq(currentNum+1).css({'z-index':'4'}).addClass('current').removeClass('next').find('.bg').remove();
						$('.card').eq(currentNum+2).css({'z-index':'3'});
						currentNum++;
						if($('.card').length -1 == currentNum){ $('.control .right').hide(); }
					}
				}
				//Pager
				$('.card-num').text((currentNum+1)+' / '+$('#cardNews').find('.card').length);
				$('.pager-wrap span').removeClass('active');
				$('.pager-wrap span').eq(currentNum).addClass('active');
			});
			$('.card').on('click',function(e){
				if($(this).hasClass('prev')){
					e.preventDefault();
					$('.control a.left').trigger('click');
				}else if ($(this).hasClass('next')){
					e.preventDefault();
					$('.control a.right').trigger('click');
				}
			});
		}
	};
	$(window).load(function(){
		cardNews.init();
	});
});
