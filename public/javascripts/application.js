window.addEvent('domready', function() {

	var votes = {};
	
	$$('.options .option').each(function(option) {
		var optionId = option.get('data-option_id');
		votes[optionId] = 
			option.hasClass('voted_for') ? 'for' : option.hasClass('voted_against') ? 'against' : 'empty'
	});
	
	['for', 'against', 'empty'].each(function(value) {
		$$('.options .vote_'+value).addEvent('click', function(e) {
			var optionId = this.getParent('.option').get('data-option_id');
			votes[optionId] = value;
			updateVotes();
		});
	});
	
	updateVotes();
	
	function getVotes(withValue) {
		return withValue ? Object.filter(votes, function(value) { return value == withValue; }) : votes;
	}
	function updateVotes() {
		$('poll_participant_votes_for').set('value', Object.keys(getVotes('for')).join(','));
		$('poll_participant_votes_against').set('value', Object.keys(getVotes('against')).join(','));
		
		$$('.options .option').each(function(option) {
			var optionId = option.get('data-option_id');
			var value = votes[optionId];
			option.removeClass('voted_for').removeClass('voted_against').removeClass('voted_empty');
			option.addClass('voted_'+value);
		});
	}
	
});