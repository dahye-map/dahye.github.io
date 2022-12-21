// // gnb 메뉴 아이콘 클릭시, show
// $('.btn-menu02').on('click', function(){
//   $('.gnb-wrapper').addClass('active');
//   });

// $('.close-btn').on('click', function(){
//   $('.gnb-wrapper').removeClass('active');
// });

// gnb 메뉴 아이콘 클릭시, show & dim 처리 
$('.btn-menu02').on('click', function(){
  $('.gnb-wrapper').addClass('active40');
  $('.gnb-overlay').addClass('active');
  });

$('.close-btn').on('click', function(){
  $('.gnb-wrapper').removeClass('active40');
  $('.gnb-overlay').removeClass('active');
});

$('.gnb-overlay').on('click', function(){
  $('.gnb-wrapper').removeClass('active40');
  $('.gnb-overlay').removeClass('active');
})