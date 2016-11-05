(function() {
    'use strict';
    window.electionNight = window.electionNight || {};

    window.electionNight.newCandidate = function newCandidate (name, image_url,intelligence, charisma, willpower) {
        $.ajax({
            url: '/candidates',
            dataType: 'json',
            method: 'POST'
            headers: {
              'Content-Type': 'application/json'
            }//end of headers for POST ajax call
          .done(function handleCandidate(data) {
              console.log("it worked!");
              console.log(data);
          })//end done click hanlder
          .fail(function handleCandidateError(xhr) {
              if (xhr > 400 || xhr < 499) {
                  console.log('Oh no! Client error. please check your data and re-submit.');
              }

              if (xhr > 500 || xhr <599) {
                  console.log('Oh no! Server error! We need to make sure our server is working as it should');
              }
          })//ends fail event handler
        });//end of ajax call for GET /candidates
    }//ends new candidate function

    

})();
