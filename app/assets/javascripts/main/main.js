$(document).ready(function(){

	ajaxTimer();

	var graphData = [['x', '2015-08-30'],
            		 ['クイズ1', '40'],
            		 ['クイズ2', '30'],
              		 ['クイズ3', '50'],
            		 ['クイズ4', '30']
            		];

	function ajaxTimer(){
		$.ajax({
			type: 'GET',
			url: '/ajax_render',
			cache: false
		}).done(function(json){
			var quizzes = json.quizzes;
			var bets = json.user.bets || [];
			var point = json.user.point;
			var seat = json.user.seat;
			console.log(json);
			renderQuiz(quizzes, bets, point, seat);
			setTimeout(function(){
				ajaxTimer();
			}, 1500);
		}).fail(function(json){
			//alert('データ取得エラー');
		});
	}

	function renderQuiz(quizzes, bets, point, seat){
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
				$quiz.find('.header').find('h2.js-quiz-text').text(quizzes[i].content);
				$quiz.find('.answer-btn').each(function() {
					$(this).click(answer_btn_handler);
					$(this).text(quizzes[i]["op" + $(this).data('op-id')]);
				});
				$quiz.find('.hint').html(quizzes[i].hint);

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
			$('#my-seat').text(seat + '席');

			var $str_quiz = $('.js-quiz-content').not('.hidden');
			var tmp_str = $str_quiz.attr("id");
			var current_quiz_id;
			if(tmp_str){
				current_quiz_id = tmp_str.replace(/quiz/, ''); 
				console.log(current_quiz_id);
				var val = [];
				val[0] = 100.0 / quizzes[current_quiz_id - 1].odds['op1'];
				val[1] = 100.0 / quizzes[current_quiz_id - 1].odds['op2'];
				val[2] = 100.0 / quizzes[current_quiz_id - 1].odds['op3'];
				val[3] = 100.0 / quizzes[current_quiz_id - 1].odds['op4'];
				console.log(graphData);
				chart.unload();
				chart.load({
					columns: [['x', '2015-08-30'],
            		 		  ['クイズ1', val[0]],
            		 		  ['クイズ2', val[1]],
              		 		  ['クイズ3', val[2]],
            		 		  ['クイズ4', val[3]]
            		 		  ],
					type: 'bar'
				});

			} 
			
			if(quizzes[i].correct){
				$quiz.find('.answer-btn').removeClass('button-secondary').removeClass('button-warning').addClass('button-error');
				$quiz.find('.answer-btn').each(function(){
					if($(this).data('op-id') == quizzes[i].correct){
						$(this).removeClass('button-secondary').removeClass('button-warning').removeClass('button-error').addClass('button-success');
					}
				});
				$quiz.find('.js-closed-quiz').addClass('hidden');
				$quiz.find('.js-correct-quiz').removeClass('hidden');
			}		
			
			else if(quizzes[i].is_closed){
				$quiz.find('.answer-btn').removeClass('button-secondary').removeClass('button-error').addClass('button-warning');
				$quiz.find('.js-correct-quiz').addClass('hidden');
				$quiz.find('.js-closed-quiz').removeClass('hidden');
			}
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
            },
          success: function(){
          	location.href="#openModal";
          },
          error: function(XMLHttpRequest, textStatus, errorThrown) {
          	if(XMLHttpRequest.status == 409) {
          		location.href="#openModalErrorOver";
          	} else if(XMLHttpRequest.status == 403) {
          		location.href="#openModalErrorClosed";
          	} else {
          		location.href="#openModalError";
          	}

          }
    	});
  	}

			var chart = c3.generate({
    			data: {
        			x: 'x',
        			columns: graphData,
        			axes: {
        				'temperature': 'y2'
        			},
        				type: 'bar',
    				},
    				subchart: {
      					show: false
    				},
    				zoom: {
      					enabled: true
    				},
    				axis: {
        			x: {
            		type: 'timeseries',
            		tick: {
                		format: '%Y-%m-%d'
            		}
        			},
        			y: {
          			label: {
            			text: '人気度',
            			position: 'outer-middle'
          			}
        		}
    			}
			});

});
