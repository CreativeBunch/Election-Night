(function() {
    'use strict';
    window.electionNight = window.electionNight || {};

    window.electionNight.newCandidate = function newCandidate (name, avatar_url,intelligence, charisma, willpower) {
        $.ajax({
            url: '/candidates',
            dataType: 'json',
            method: 'POST'
            headers: {

            }
            
        });
    }

})();
