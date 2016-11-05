(function() {
    'use strict';
    window.electionNight = window.electionNight || {};


    var candidateInfo = {};
    var candidateName = $('name').val();
    // var avatar = $('image_url').val();
    // var willPower = willpower.val();
    // var charisma = charisma.val();
    // var intelligence = intelligence.val();

    window.electionNight.newCandidate = function newCandidate (name, image_url,intelligence, charisma, willpower) {
        $.ajax({
            url: '/candidates',
            dataType: 'json',
            method: 'POST',
            headers: {
              'Content-Type': 'application/json'
            }//end of headers for POST ajax call
          .done(function handleCandidate(data) {
              event.preventDefault()

              console.log("it worked!");
              console.log(data);
          })//end done click hanlder
          .fail(function handleCandidateError(xhr, errorType) {
              if (errorType > 400 || errorType < 499) {
                  console.log('Oh no! Client error. please check your data and re-submit.');
              }//end of how to handle CLIENT error for newCandidate

              if (errorType > 500 || errorType <599) {
                  console.log('Oh no! Server error! We need to make sure our server is working as it should');
              }//end of how to handle server error for newCandidate
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

    window.electionNight.getCandidates = function getCandidates (data) {
        $.ajax({
            url: '/candidates',
            dataType: 'json',
            headers: {
                'Content-Type': 'application/json'
            }//end of header for getCandidates
        })
        .done(function handleGetCandidatesSuccess(data) {
            console.log("Call successful");
        })//end of ajax call for getCandidates
        .fail(function handleGetCandidatesError(xhr, errorType) {
            console.log("ERROR");
            if (errorType > 400 || errorType < 499) {
                console.log('Oh no! Client error. please check your data and re-submit.');
            }//end of how to handle client error for getCandidate

            if (errorType > 500 || errorType <599) {
                console.log('Oh no! Server error! We need to make sure our server is working as it should');
            }//end of how to handle server errors for getCandidate
        })//end of fail callback for getCandidate
    }//end of function for getCandidates

    window.electionNight.editCandidate = function editCandidate(candidate) {
      $.ajax({
          url: '/candidates',
          method: 'PATCH',
          dataType: 'json',
          headers: {
              'Content-Type': 'application/json'
          }//end of header for editCandidate
    })
  }
})();
