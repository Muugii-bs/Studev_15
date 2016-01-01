$(document).ready(function(){

	ajaxTimer();

	function ajaxTimer(){
		$.ajax({
			type: 'GET',
			url: '/ajax_render',
			cache: false
		}).done(function(json){
			var quizzes = json.quizzes;
			var bets = json.user.bets || [];
			var point = json.user.point;
			console.log(point);
			renderQuiz(quizzes, bets, point);
			setTimeout(function(){
				ajaxTimer();
			}, 1500);
		}).fail(function(json){
			//alert('データ取得エラー');
		});
	}

	function renderQuiz(quizzes, bets, point){
		var bet_map = {};
		for(var i = 0; i < bets.length; i++) {
			var bet = bets[i];
			bet_map[bet.quiz_id] = bet_map[bet.quiz_id] || {};
			bet_map[bet.quiz_id][bet.answer] = bet_map[bet.quiz_id][bet.answer] || 0;
			bet_map[bet.quiz_id][bet.answer] = bet_map[bet.quiz_id][bet.answer] + bet.amount;
		}
		for(var i = 0; i < quizzes.length; i++){
			var $quiz;
			var $quiz_menu;
			if($('#quiz' + quizzes[i].id).length) {
				$quiz = $('#quiz' + quizzes[i].id);
				$quiz_menu = $(this).find("data-quiz-id='" + quizzes[i].id + "'");
			} else {
				$quiz = $('#quiz-template').clone();
				$quiz.attr("id", 'quiz' +  quizzes[i].id);
				$quiz.addClass('js-quiz-content');
				$quiz.addClass('hidden');
				$quiz.find('.header').find('h1').text(quizzes[i].title);
				$quiz.find('.header').find('h2').text(quizzes[i].content);
				$quiz.find('.answer-btn').each(function() {
					$(this).click(answer_btn_handler);
					$(this).text(quizzes[i]["op" + $(this).data('op-id')]);
				});
				$quiz.find('.hint').text(quizzes[i].hint);

				$quiz_menu = $('#menu-item-template').find('.li-template').clone();
				$quiz_menu.removeClass('li-template');
				$quiz_menu.find('.js-sidemenu-quiz').attr("data-quiz-id", quizzes[i].id);
				$quiz_menu.find('.js-sidemenu-quiz').each(function() {
					$(this).text(quizzes[i].title);
				});
				$('.js-quiz-content-wrapper').append($quiz);
				$('.pure-menu').find('.sidemenu-quiz-part').append($quiz_menu);
				showContent();
			}
			$quiz.find('.rate-btn').each(function() {
				var tmp = 'op' + $(this).data('op-id');
				$(this).text(quizzes[i].odds[tmp] + '倍');
			});
			$quiz.find('.point-field').each(function() {
				var amount =
					(bet_map[quizzes[i].id] && bet_map[quizzes[i].id][parseInt($(this).data('op-id'))])
					? bet_map[quizzes[i].id][parseInt($(this).data('op-id'))]
					: 0;
				$(this).text(amount + 'pt');
			});
			$('#my-point').text(point + 'pt');
		}
	}

	function showContent(){
		$('.js-sidemenu-quiz').click(function(){
			$('.js-quiz-content').addClass('hidden');
			var sidemenu_id = $(this).data('quiz-id');
			var content_id = 'quiz' + sidemenu_id;
			$('#'+content_id).removeClass('hidden');
		});
	}

	function answer_btn_handler(){
    	var op_id = $(this).data('op-id');
    	var quiz_id = $(this).parents('.js-quiz-content').attr('id').replace(/quiz/, "");
    	var amount = $(this).parent().find('select').val();
    	$.ajax({
      		type: 'POST',
      		url: '/bet',
      		data: {
              "answer": op_id,
              "amount": amount,
              "quiz_id": quiz_id
            }
    	});
  }

});
