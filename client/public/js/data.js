(function() {
    'use strict';
    window.electionNight = window.electionNight || {};

    window.electionNight.newCandidate = function newCandidate (name, avatar_url,intelligence, charisma, willpower) {
        $.ajax({
            url: '/candidates',
            dataType: 'json',
            method: 'POST'
            headers: {
              'Content-Type': 'application/json'
            }
          .done(function handleCandidate(data) {
              console.log("it worked!");
          })
          .fail(function handleCandidateError(xhr) {
              
          })
        });
    }

})();
